# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  email           :string
#  orientation     :string
#  gender          :boolean
#  image_url       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  uid             :integer
#  last_name       :string
#  provider        :string
#  password_digest :string
#  access_token    :string
#

class User < ActiveRecord::Base
  has_many :matches
  has_many :votes
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password

  before_save :downcase_email
  after_save :create_all_matches
  validates_uniqueness_of :email
  validates_presence_of :email, :orientation
  validates :orientation, inclusion: { in: ['straight', 'gay', 'bi'] }
  validates_confirmation_of :password

  def update_facebook_params(auth)
    self.provider = auth['provider']
    self.uid = auth['uid']

    if auth['info']
      puts auth['info'].inspect
      self.first_name = auth['info']['first_name'] || ""
      self.last_name = auth['info']['last_name'] || ""
      self.image_url = auth['info']['image'] || ""
      self.gender = auth['info']['gender'] == 'male'

      @graph = Koala::Facebook::API.new(auth['credentials']['token'])
      friends = @graph.get_connections("me", "friends", api_version: "v2.0")

      friends.each do |profile|
        next unless friend = User.find_by_uid(profile['id'])
        Friendship.create(user_id: id, friend_id: friend.id)
      end

    end
  end

  def friends_matches
    Match.where(user_1_id: self.friends).where(user_2_id: self.friends)
  end

  def get_votable_match
    matches_ive_voted_on = Vote.where(user_id: id).all.map(&:match_id)
    match = friends_matches.where.not(id: matches_ive_voted_on).order("RANDOM()").first
    match = friends_matches.order("RANDOM()").first if match.blank?
    return_match_json(match)
  end

  def get_votable_match_for_user(other_user_id)
    matches_ive_voted_on = Vote.where(user_id: id).all.map(&:match_id)
    matches_for_user = friends_matches.where('user_1_id = (?) or user_2_id = (?)',
                                             other_user_id, other_user_id)
    match = matches_for_user.where.not(id: matches_ive_voted_on).order("RANDOM()").first
    match = matches_for_user.order("RANDOM()").first unless match
    return_match_json(match)
  end

  def return_match_json(match)
    unless match.blank?
      if match.user1.uid==nil || match.user2.uid==nil
        return get_votable_match

      else
        return {
          'match_id': match.id,
          'user_id': id,
          'user_name': full_name,
          'users': [
                    {'name': match.user1.full_name, 'profile_picture': match.user1.image_url},
                    {'name': match.user2.full_name, 'profile_picture': match.user2.image_url},
                   ]
        }
      end
    else
      return {
        'match_id': false
      }
    end
  end

  def create_all_matches
    Match.create_valid_matches unless uid.nil?
  end

  def downcase_email
    self.email.downcase!
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
    self.save
    return self.access_token
  end
end

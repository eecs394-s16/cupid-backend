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
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password

  before_save :downcase_email
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
        #next if Friendship.where(user_id: user.id, friend_id: friend.id).blank?
        Friendship.create({:user_id => auth['info']['uid'],:friend_id => profile['id']})
      end

    end
  end

  def get_votable_match
    # votable matches, whether voted on or not
    votable_matches = Match.where.not(user_1_id: id).where.not(user_2_id: id)
    # matches I've voted on - this will be slow because it's not sql
    matches_ive_voted_on = Vote.where(user_id: id).all.map(&:match_id)

    # postgres specific
    match = votable_matches.where.not(id: matches_ive_voted_on).order("RANDOM()").first
    # if it is not an empty match
    unless match.blank?
      return {
        'match_id': match.id,
        'user_id': id,
        'user_name': full_name,
        'users': [
           {'name': match.user1.full_name, 'profile_picture': match.user1.image_url},
           {'name': match.user2.full_name, 'profile_picture': match.user2.image_url},
        ]
      }

    # otherwise return match_id equals null
    else
      return {
          'match_id': false
        }
    end
  end

  def downcase_email
    self.email.downcase!
  end

  def full_name
    first_name + ' ' + last_name
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
    self.save
    return self.access_token
  end
end

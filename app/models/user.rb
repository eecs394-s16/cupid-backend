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
  before_save :downcase_email

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        puts auth['info'].inspect
        user.first_name = auth['info']['first_name'] || ""
        user.last_name = auth['info']['last_name'] || ""
        user.email = auth['info']['email'] || ""
        user.image_url = auth['info']['image'] || ""
        user.gender = auth['info']['gender'] == 'male'
        print auth['info']['gender']
      end
    end
  end

  has_many :matches
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password

  validates_uniqueness_of :email
  validates_presence_of :email, :orientation
  validates :orientation, inclusion: { in: ['straight', 'gay', 'bi'] }
  validates_confirmation_of :password

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

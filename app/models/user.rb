# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string
#  email       :string
#  orientation :string
#  gender      :boolean
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uid         :integer
#  last_name   :string
#

class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        puts "!!!!!!!!!!!!!!!!!!!!!!!!"
        puts auth['info'].inspect
        user.first_name = auth['info']['first_name'] || ""
        user.last_name = auth['info']['last_name'] || ""
        user.email = auth['info']['email'] || ""
        user.image_url = auth['info']['image'] || ""
        user.gender = auth['info']['gender'] == 'male'
      end
    end
  end

  has_many :matches

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email, :image_url #, :orientation, :gender
  validates :orientation, inclusion: { in: ['straight', 'gay', 'bi', nil] }

  def get_votable_match
    # votable matches, whether voted on or not
    votable_matches = Match.where.not(user_1_id: id).where.not(user_2_id: id)
    # matches I've voted on - this will be slow because it's not sql
    matches_ive_voted_on = Vote.where(user_id: id).all.map(&:match_id)

    # postgres specific
    match = votable_matches.where.not(id: matches_ive_voted_on).order("RANDOM()").first

    return {
      'match_id': match.id,
      'user_id': id,
      'users': [
         {'name': match.user1.full_name, 'profile_picture': match.user1.image_url},
         {'name': match.user2.full_name, 'profile_picture': match.user2.image_url},
      ]
    }
  end

  def full_name
    first_name + ' ' + last_name
  end
end

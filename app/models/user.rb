# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  email       :string
#  orientation :string
#  gender      :boolean
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ActiveRecord::Base
  has_many :matches

  validates_uniqueness_of :email
  validates_presence_of :name, :email, :orientation, :image_url
  validates :orientation, inclusion: { in: ['straight', 'gay', 'bi'] }

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
         {'name': match.user1.name, 'profile_picture': match.user1.image_url},
         {'name': match.user2.name, 'profile_picture': match.user2.image_url},
      ]
    }
  end
end

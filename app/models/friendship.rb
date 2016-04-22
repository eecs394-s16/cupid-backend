# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_1_id  :integer
#  user_2_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ActiveRecord::Base
  belongs_to :friend, :class_name => 'User'
  belongs_to :user
  after_create :create_complement

  validates_uniqueness_of :user_id, scope: :friend_id

  def create_complement
    Friendship.find_or_create_by(user_id: friend_id, friend_id: user_id)
  end
end

# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  user_1     :integer
#  user_2     :integer
#  yes_count  :integer
#  no_count   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ActiveRecord::Base
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_1_id'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_2_id'

  def self.create_valid_matches
    User.find_each do |user|
      if user.orientation != 'gay'
        User.where('id > ?',  user.id)
          .where(gender: !user.gender, orientation: ['straight', 'bi']).each do |u2|
          Match.find_or_create_by(user1: user, user2: u2)
        end
      end

      if user.orientation != 'straight'
        User.where('id > ?', user.id)
          .where(gender: user.gender, orientation: ['gay', 'bi']).each do |u2|
          Match.find_or_create_by(user1: user, user2: u2)
        end
      end
    end
  end
end

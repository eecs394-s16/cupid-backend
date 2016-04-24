# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  user_1_id  :integer
#  user_2_id  :integer
#  yes_count  :integer          default(0)
#  no_count   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Validator so that User 1 < User 2 (Finished)

class MyValidator < ActiveModel::Validator
    def validate(record)
        unless record.user_1_id < record.user_2_id
          record.errors[:name] << 'User 1 >= User 2'
        end
    end
end

class Match < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with MyValidator

  has_many :votes
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_1_id'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_2_id'

  def self.create_valid_matches
    User.where.not(uid: nil).find_each do |user|
      if user.orientation != 'gay'
        User.where('id > ?',  user.id)
          .where(gender: !user.gender, orientation: ['straight', 'bi']).each do |u2|
          Match.find_or_create_by(user1: user, user2: u2)
        end
      end

      if user.orientation != 'straight'
        User.where.not(uid: nil).where('id > ?', user.id)
          .where(gender: user.gender, orientation: ['gay', 'bi']).each do |u2|
          Match.find_or_create_by(user1: user, user2: u2)
        end
      end
    end
  end
end

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
  
  
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_1_id'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_2_id'

  # need validation for match repetitiveness

  def self.get_votable_match_for(user_id)
    match = Match.joins('LEFT join votes on match.id = vote.match_id')
      .where.not(user_id: user_id).where.not(user_1_id: user_id).where.not(user_2_id: user_id).first
    return {
      'match_id': match.id,
      'user_id': user_id,
      'users': [
         {'name': match.user1.full_name, 'profile_picture': match.user1.image_url},
         {'name': match.user2.full_name, 'profile_picture': match.user2.image_url},
      ]
    }
  end

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

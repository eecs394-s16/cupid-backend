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


# Validator so that User 1 < User 2
class MyValidator < ActiveRecord::Validator
  def validate(record)
    if record.
      record.errors[:name] << "User 1 >= User2"
    end
  end









class Match < ActiveRecord::Base
  
  includes ActiveModel::Validations
  validates_with MyValidator
  
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_1'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_2'

  # need validation for match repetetiveness
  
  
  

  # validate that no match has same two people
  def self.get_votable_match_for(user_id)
    match = Match.joins('LEFT join votes on match.id = vote.match_id')
      .where.not(user_id: user_id).where.not(user_1: user_id).where.not(user_2: user_id).first
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
    # this needs to be implemented
    # User.where(gender: true ....
    # Match.create(user1: user1, user2: user2)
  end
end

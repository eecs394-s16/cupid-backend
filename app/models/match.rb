class Match < ActiveRecord::Base
  belongs_to :user1, :class_name => 'User', :foreign_key => 'user_1'
  belongs_to :user2, :class_name => 'User', :foreign_key => 'user_2'

  # validate that no match has same two people
end

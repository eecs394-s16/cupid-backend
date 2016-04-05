# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  match_id   :integer
#  yes        :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  def self.match_vote(match_params)
    Vote.create!(user_id: match_params[:user_id],
                 match_id: match_params[:match_id],
                 yes: match_params[:yes])
  end
end

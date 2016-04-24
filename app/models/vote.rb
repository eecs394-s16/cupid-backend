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
  belongs_to :match
  belongs_to :user

  def self.match_vote(match_params)
    v = Vote.find_or_create_by(user_id: match_params[:user_id],
                               match_id: match_params[:match_id])
    v.update_attributes(yes: match_params[:yes])
  end

  def self.find_num_votes(match_id)
  	return Vote.where(match_id: match_id, yes: true).count
  end
end

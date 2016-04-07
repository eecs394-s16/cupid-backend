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

class MatchesController < ApplicationController
  def vote_on_match
    render json: {sup: 'hai'}
    # get_params
    # Vote.match_vote(@match_params) if @match_params[:match_id]
    # resp = User.find(@match_params[:user_id]).get_votable_match
    # render json: resp
  end

  def hi
    render json: {hello: 'hi'}
  end

  private
  def get_params
    @match_params = params.permit(:user_id, :match_id, :yes)
  end
end

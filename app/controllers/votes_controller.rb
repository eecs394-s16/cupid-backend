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

class VotesController < ApplicationController
  include ApplicationHelper
  skip_before_filter :verify_authenticity_token

  def create
    if check_token
      get_params
      Vote.match_vote(@vote_params) if @vote_params[:match_id]
      u = User.find(@vote_params[:user_id])
      if u.uid != nil
        resp = u.get_votable_match
        resp['fb_connected'] = true
        render json: resp.to_json
      else
        render json: {'fb_connected': false}
      end

    else
      render json: {status: 401}
    end
  end

  private

  def get_params
    @vote_params = params.permit(:user_id, :match_id, :yes)
  end
end

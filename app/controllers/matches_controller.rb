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
  before_action :set_default_response_format

  def match_response
    get_params
    Vote.match_vote(@match_params)
    render json: JSON.encode(Match.get_votable_match_for(@match_params[:user_id]))
  end

  private
  def get_params
    @match_params = params.permit(:user_id, :match_id, :yes)
  end

  def set_default_response_format
    request.format = :json
  end
end

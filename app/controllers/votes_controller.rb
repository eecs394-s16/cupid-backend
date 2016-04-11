class VotesController < ApplicationController
  def create
    get_params
    Vote.match_vote(@vote_params) if @vote_params[:match_id]
    resp = User.find(@vote_params[:user_id]).get_votable_match

    render json: {'hello': 'hi'}
    # render json: resp.to_json
  end

  private
  def get_params
    @vote_params = params.permit(:user_id, :match_id, :yes)
  end

end

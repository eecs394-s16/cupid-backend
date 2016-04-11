class VotesController < ApplicationController
  def create
    get_params
    # Vote.match_vote(@vote_params) if @vote_params[:match_id]
    # resp = User.find(@vote_params[:user_id]).get_votable_match

    # http_envs = {}.tap do |envs|
    #   request.headers.each do |key, value|
    #     envs[key] = value if key.downcase.starts_with?('http')
    #   end
    # end

    render json: {req: @vote_params}

    # render json: resp.to_json
  end

  private
  def get_params
    @vote_params = params.permit(:user_id, :match_id, :yes)
  end

end

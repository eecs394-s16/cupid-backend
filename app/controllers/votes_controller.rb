class VotesController < ApplicationController
  def create
    get_params
    Vote.match_vote(@vote_params) if @vote_params[:match_id]
    resp = User.find(@vote_params[:user_id]).get_votable_match

    m  = Match.where.not(user_1_id: 1).where.not(user_2_id: 2).all.shuffle.first
    # render json: {
    #   'match_id': m.id,
    #   'user_id': 1,
    #   'users': [
    #      {'name': m.user1.full_name, 'profile_picture': m.user1.image_url},
    #      {'name': m.user2.full_name, 'profile_picture': m.user2.image_url},
    #   ]
    # }

    render json: resp.to_json
  end

  private
  def get_params
    @vote_params = params.permit(:user_id, :match_id, :yes)
  end

end

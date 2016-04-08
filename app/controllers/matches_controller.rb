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
    get_params
    Vote.match_vote(@match_params) if @match_params[:match_id]
    puts @match_params
    resp = User.find(@match_params[:user_id]).get_votable_match

    # m  = Match.where.not(user_1_id: 1).where.not(user_2_id: 2).all.shuffle.first
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

  def hi
    render json: {hello: 'hi'}
  end

  private
  def get_params
    @match_params = params.permit(:user_id, :match_id, :yes)
  end
end

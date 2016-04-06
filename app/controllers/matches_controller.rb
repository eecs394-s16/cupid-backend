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
    respond_to do |format|
      format.json do
        puts 'haiiii'
        get_params
        Vote.match_vote(@match_params)
        resp = User.find(@match_params[:user_id]).get_votable_match
        render json: resp
      end
    end
  end

  def hi
    respond_to do |format|
      format.json do
        puts 'recieved'
        render json: {hello: 'hi'}
      end
    end
  end

  private
  def get_params
    @match_params = params.permit(:user_id, :match_id, :yes)
  end
end

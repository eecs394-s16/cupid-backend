# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  user_1_id  :integer
#  user_2_id  :integer
#  yes_count  :integer          default(0)
#  no_count   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MatchesController < ApplicationController
  include ApplicationHelper
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def mymatch
    if check_token
      data = JSON.parse request.body.read
      mymatch_array = Array.new
      Match.where(user_1_id: data["user_id"]).find_each do |m|
        user_2_id = m.user_2_id
        num_votes = Vote.find_num_votes(m.id)
        user_2 = User.where(id: user_2_id).take
        mymatch_array << {
          "user_2_fb_id": user_2.uid,
          'user_2_first_name': user_2.first_name,
          'user_2_last_name': user_2.last_name,
          'user_2_pic': user_2.image_url,
          'num_votes': num_votes
        }
      end
      render json: {'mymatch': mymatch_array}
    else
      render json: {status: 401}
    end
  end

  def show
    if check_token
      m  = Match.where.not(user_1_id: 1).where.not(user_2_id: 2).all.shuffle.first
      render json: {'hello': 'hi'}
    else
      render json: {status: 401}
    end
  end

  def get_next_user_and_votable_match
  	# if check_token
      data = JSON.parse request.body.read
      # The data should contain two things:
      # One is the user's id. The other one is the id of the previous match (relative to the new match you're about to get)
      return_data=User.find(data['user_id']).get_next_user(data['prev_user_id'])
      render json: return_data
    # else
    #   render json: {status: 401}
    # end
  end

  def get_prev_user_and_votable_match
  	# if check_token
      data = JSON.parse request.body.read
      # The data should contain two things:
      # One is the user's id. The other one is the id of the current match.
      return_data=User.find(data['user_id']).get_prev_user(data['curr_user_id'])
      render json: return_data
    # else
    #   render json: {status: 401}
    # end
  end

  def get_votable_match_for_user
  	# if check_token
      # The data should contain two things:
      # One is the user's id. The other one is the id of the person to be matched.
      return_data=User.find(params[:user_id]).get_votable_match_for_user(params[:curr_matched_id])
      render json: return_data
    # else
    #   render json: {status: 401}
    # end
  end

  private
  def get_params
    # @match_params = params.permit(:user_id, :match_id, :yes)
  end

end

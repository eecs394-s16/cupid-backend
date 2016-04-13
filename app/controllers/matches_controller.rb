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

	# avoid "Can't verify CSRF token authenticity" error
	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  def show
    m  = Match.where.not(user_1_id: 1).where.not(user_2_id: 2).all.shuffle.first

    render json: {'hello': 'hi'}
  end


  def mymatch
  	# the data contains the user id
  	data= JSON.parse request.body.read
  	# the things we need to return are: list of [user_2_id, user_2_first_name, user_2_last_name, user_2_pic, num_votes]
  	mymatch_array = Array.new
  	Match.where(user_1_id: data["user_id"]).find_each do |m|
	  user_2_id=m.user_2_id
	  num_votes=m.yes_count
	  user_2=User.where(id: user_2_id).take
	  user_2_first_name=user_2.first_name
	  user_2_last_name=user_2.last_name
	  user_2_pic=user_2.image_url
	  mymatch_array << {"user_2_id": user_2_id, 'user_2_first_name': user_2_first_name, 'user_2_last_name': user_2_last_name, 'user_2_pic': user_2_pic, 'num_votes': num_votes}
	end
  	#render text: "Thanks for sending a POST request with cURL! Payload: #{data}";
  	#render text: "Thanks for sending a POST request with cURL! Returning: #{m.user_2_id}";
  	render json: {'mymatch': mymatch_array}
  	return
  end

  private
  def get_params
    # @match_params = params.permit(:user_id, :match_id, :yes)
  end

end

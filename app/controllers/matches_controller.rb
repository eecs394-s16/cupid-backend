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
  def show
    m  = Match.where.not(user_1_id: 1).where.not(user_2_id: 2).all.shuffle.first

    render json: {'hello': 'hi'}
  end

  private
  def get_params
    # @match_params = params.permit(:user_id, :match_id, :yes)
  end
end

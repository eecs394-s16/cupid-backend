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

require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end

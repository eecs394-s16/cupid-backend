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

require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end

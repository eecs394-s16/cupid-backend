# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  email           :string
#  orientation     :string
#  gender          :boolean
#  image_url       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  uid             :integer
#  last_name       :string
#  provider        :string
#  password_digest :string
#  access_token    :string
#

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end

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

class UsersController < ApplicationController
  def create
    user_params
    u = User.new(@user_params)
    if u.save
      return {access_token: u.generate_access_token, success: true}
    else
      return {success: false, errors: u.errors.full_messages}
    end
  end

  private

  def user_params
    @user_params = params.require(:user)
      .permit(:password, :password_confirmation, :email, :orientation)
  end
end

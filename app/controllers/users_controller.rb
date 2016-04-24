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
  skip_before_action :verify_authenticity_token

  def create
    user_params
    u = User.new(@user_params)
    if u.save
      render json: {access_token: u.generate_access_token, success: true, user_id: u.id}
    else
      render json: {success: false, errors: u.errors.full_messages}
    end
  end

  def show
    begin
      first_name = User.find(params[:id]).first_name.capitalize
      @welcome_message = "Welcome to Cupid, #{first_name}!"
    rescue
      @welcome_message = "Welcome to Cupid!"
    end
  end

  private

  def user_params
    @user_params = params.require(:user)
      .permit(:password, :password_confirmation, :email, :orientation)
  end
end


# tested create with: curl -v -d "user[email]=hello@example.com&user[orientation]=straight&user[password]=password&user[password_confirmation]=password" localhost:3000/api/users

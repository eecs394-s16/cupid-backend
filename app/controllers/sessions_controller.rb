class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "!!!!!!!!!!!!!!!!!!!!!"
    puts params
    puts "!!!!!!!!!!!!!!!!!!!!!"
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      render json: { success: true, access_token: user.generate_access_token, user_id: user.id }
    else
      render json: { success: false }
    end
  end

  def destroy
    if check_token
      User.find_by(user_id: params[:user_id]).access_token = nil
    else
      render json: {status: 401}
    end
  end

  # FACEBOOK STUFF: will need to reimplement later

  # def create
  #   auth = request.env["omniauth.auth"]
  #   user = User.where(:provider => auth['provider'],
  #                     :uid => auth['uid']).first || User.create_with_omniauth(auth)
  #   session[:user_id] = user.id
  #   redirect_to root_url, :notice => "Signed in!"
  # end

  # def new
  #   redirect_to '/auth/facebook'
  # end

  # def destroy
  #   reset_session
  #   redirect_to root_url, notice => 'Signed out'
  # end

end

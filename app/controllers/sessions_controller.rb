class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.uid
        render json: { success: true, access_token: user.generate_access_token, user_id: user.id, fb_connected: true }
      else
        render json: {success: false, fb_connected: false, error_msg: "Please link your account with facebook."}
      end
    else
      render json: { success: false, fb_connected: false }
    end
  end

  def destroy
    # unused currently
    if check_token
      User.find_by(user_id: params[:user_id]).access_token = nil
    else
      render json: {status: 401}
    end
  end

  def connect
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to '/auth/facebook'
    else
      flash[:danger] = 'Incorrect email or password'
      redirect_to '/signin'
    end
  end

  def connect_callback
    auth = request.env["omniauth.auth"]
    u = User.find(session[:user_id])
    u.update_facebook_params(auth)
    redirect_to "/users/#{u.id}", :notice => "Signed in!"
  end

  def signin
  end
end

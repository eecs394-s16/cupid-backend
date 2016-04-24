module ApplicationHelper
  def check_token
    user = User.find(params[:user_id])
    return true if user && user.access_token && user.access_token == params[:access_token]
    return false
  end
end

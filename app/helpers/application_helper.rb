module ApplicationHelper
  def check_token
    if user = User.find(params[:user_id]) && user.access_token == params[:access_token]
      return true
    else
      return false
    end
  end
end

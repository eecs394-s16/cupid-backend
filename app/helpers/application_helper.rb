module ApplicationHelper
  def check_token
    if User.find(params[:user_id]).access_token == params[:access_token]
      return true
    else
      return false
    end
  end
end

module SessionsHelper
  #Create a cookies to hold login info
  def sign_in(user)
    cookies.permanent[:username] = user.username
    self.current_user = user
  end
  #set user to a session variable
  def current_user=(user)
    @current_user = user
  end
  #get current logged in user
  def current_user
    @current_user ||= User.find_by_username(cookies[:username])
  end
  #if session variable is nil the user not logged in
  def signed_in?
    !current_user.nil?
  end
  #clear session variable and cookie
  def sign_out
    self.current_user = nil
    cookies.delete(:username)
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  #Check if a user is logged in before loading every page
  before_filter :require_login

  private
  #check user is logged in
  def require_login
    unless current_user
      redirect_to signin_path
    end
  end

end

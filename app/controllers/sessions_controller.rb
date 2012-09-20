class SessionsController < ApplicationController
  #skip the check if a user is logged in
  skip_before_filter :require_login

  #Sign Up a new or redirect an existing user to a root
  def new
    if !signed_in?
      render 'new'
    else
      redirect_to root_path
    end
  end

  #authenticate an existing user and redirect to home page.
  def create
      user = User.find_by_username(params[:session][:username])
      if user && user.authenticate(params[:password])
        # Sign the user in and redirect to the user's show page.
        sign_in user
        redirect_to posts_path
      else
        # Create an error message and re-render the signin form.
        flash.now[:error] = 'Invalid email/password combination' # Not quite right!
        render 'new'
      end
  end

  #signout and remove the cookie
  def destroy
    sign_out
    redirect_to root_url
  end
end
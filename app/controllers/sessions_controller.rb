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

  def searchbefore
    Rails.logger.debug("Inside searchbefore ")

    # remove leading and trailing whitespaces from the search string
    # returned by the view

    if not (params[:search].strip.empty?)
      # if search condition is based on username, first get the userid for that username from the
      # user table. Then, get all posts from the post table that have user_id = userid.
      # Since only posts need to be searched, the parent_id should be null for the returned posts.
      if(params[:theme]=="user")
        allusers =  User.all( :select => "id", :conditions => ['username LIKE ?', "%#{params[:search].strip}%"])
        @searchResultsLogin = Post.all(:conditions => ["user_id  in (?) and parent_id IS NULL", allusers])

        #if search condition is based on category, first search the category table for the category id using the
        # category name obtained from the view.
        # Then get the posts which have that category id in the category_id field.
      elsif(params[:theme]=="category")
        categories =  Category.all( :select => "id", :conditions => ['name LIKE ?', "%#{params[:search].strip}%"])
        @searchResultsLogin = Post.all(:conditions => ["category_id  in (?) and parent_id IS NULL", categories])
      else
        # if search is based on content, get all posts which have the matching content text in the content field
        @searchResultsLogin =  Post.all(:conditions => ['content LIKE ? and parent_id IS NULL', "%#{params[:search].strip}%"])

      end
      Rails.logger.debug(@searchResultsLogin)
    end
    render 'new'
  end
end
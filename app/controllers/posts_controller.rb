class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  helper_method :search

  def index
    Rails.logger.debug("Inside index ")
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    Rails.logger.debug("Inside show ")
  @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    respond_to do |format|
    if @post.save
      if @post.parent_id?
        parent_post = Post.find(@post.parent_id)
        parent_post.updated_at = @post.updated_at
        parent_post.save
        format.html { redirect_to parent_post, notice: 'Post was successfully created.' }
        format.json { head :no_content }
      else
        #flash[:notice] = "Successfully created post."
        #redirect_to "/posts"
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { head :no_content }
      end

    else
      #render :action => 'new'
      format.html { render action: "new" }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
      end
  end


   def showComments
     @post = Post.find(params[:id])

   end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        if @post.parent_id?
          parent_post = Post.find(@post.parent_id)
          parent_post.updated_at = @post.updated_at
          parent_post.save
          format.html { redirect_to parent_post, notice: 'Post was successfully created.' }
          format.json { head :no_content }
        else
          #flash[:notice] = "Successfully created post."
          #redirect_to "/posts"
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  # This function is used for the search functionality for posts
  # The search can be based depending on user, category or content.

   def search
     Rails.logger.debug("Inside search ")

    # remove leading and trailing whitespaces from the search string
    # returned by the view

     if not (params[:search].strip.empty?)
     # if search condition is based on username, first get the userid for that username from the
     # user table. Then, get all posts from the post table that have user_id = userid.
    # Since only posts need to be searched, the parent_id should be null for the returned posts.
      if(params[:theme]=="user")
      allusers =  User.all( :select => "id", :conditions => ['username LIKE ?', "%#{params[:search].strip}%"])
      @searchResults = Post.all(:conditions => ["user_id  in (?) and parent_id IS NULL", allusers])

        #if search condition is based on category, first search the category table for the category id using the
        # category name obtained from the view.
        # Then get the posts which have that category id in the category_id field.
    elsif(params[:theme]=="category")
      categories =  Category.all( :select => "id", :conditions => ['name LIKE ?', "%#{params[:search].strip}%"])
      @searchResults = Post.all(:conditions => ["category_id  in (?) and parent_id IS NULL", categories])
    else
      # if search is based on content, get all posts which have the matching content text in the content field
      @searchResults =  Post.all(:conditions => ['content LIKE ? and parent_id IS NULL', "%#{params[:search].strip}%"])

    end
     end

       respond_to do |format|
    format.html {render action: "index" }

    end
   end







end


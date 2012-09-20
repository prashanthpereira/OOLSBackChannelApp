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
      #flash[:notice] = "Successfully created post."
      #redirect_to "/posts"
      format.html { redirect_to @post, notice: 'Post was successfully created.' }
      format.json { head :no_content }
    else
      #render :action => 'new'
      format.html { render action: "new" }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
      end
  end

=begin
  def create
    @post = Post.new(:content => params[:post][:content], :topic_id => params[:post][:topic_id], :user_id => current_user.id)
    if @post.save
      flash[:notice] = "Successfully created post."
      redirect_to "/topics/#{@post.topic_id}"
    else
      render :action => 'new'
    end
  end
=end
   def showComments
     @post = Post.find(params[:id])

   end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

=begin
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      @topic = Topic.find(@post.topic_id)
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
=end

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

   def search
     Rails.logger.debug("Inside search ")
    #search = params[:search]

     if not (params[:search].strip.empty?)

      if(params[:theme]=="user")
      allusers =  User.all( :select => "id", :conditions => ['username LIKE ?', "%#{params[:search].strip}%"])
      @searchResults = Post.all(:conditions => ["user_id  in (?) and parent_id IS NULL", allusers])
    elsif(params[:theme]=="category")
      categories =  Category.all( :select => "id", :conditions => ['name LIKE ?', "%#{params[:search].strip}%"])
      @searchResults = Post.all(:conditions => ["category_id  in (?) and parent_id IS NULL", categories])
    else
      @searchResults =  Post.all(:conditions => ['content LIKE ? and parent_id IS NULL', "%#{params[:search].strip}%"])

    end
    end
    Rails.logger.debug(params[:search].strip)
     Rails.logger.debug(params[:theme])
    respond_to do |format|
    #format.html {redirect_to :controller => "posts", :action => 'index'}
    format.html {render action: "index" }
    end
   end





end


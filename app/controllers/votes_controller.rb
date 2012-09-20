class VotesController < ApplicationController
  # GET /votes
  # GET /votes.json
  helper_method :update_vote

  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(params[:vote])

    respond_to do |format|
      if @vote.save
        #update the last modified for the post that the vote was made for
        post = @vote.post
        post.updated_at = @vote.updated_at
        post.save
        #if the vote was for a comment update the last modified of parent post as well
        if post.parent_id?
          parent_post = Post.find(post.parent_id)
          parent_post.updated_at = post.updated_at
          parent_post.save
          format.html { redirect_to parent_post, notice: 'Vote was successfully created.' }
          format.json { head :no_content }
        else
          #flash[:notice] = "Successfully created post."
          #redirect_to "/posts"
          format.html { redirect_to post, notice: 'Vote was successfully created.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end


end

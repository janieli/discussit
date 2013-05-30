class PostsController < ApplicationController

  before_filter :require_user, only: [:new, :create, :edit, :update, :vote]

  def index
  	@posts = Post.all
  end

	def show
		@post = Post.find(params[:id])
    @comment = @post.comments.build   #creating a new in-memory comment, does not hit db
	end

# new post form
	def new
		@post = Post.new
	end

# submission of the post form
  def create
  	@post = Post.new(params[:post])
  	@post.user_id = current_user.id

  	if@post.save
  		flash[:notice] = "A new post was created!"
 			redirect_to posts_path
 		else # case of validation error
      render :new
 		end
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update_attributes(params[:post])
  		flash[:notice] = "Post was updated"
  		redirect_to posts_path(@post)
  	else #validation failure
      render :edit
  	end
  end

  def vote
    @post = Post.find(params[:id])
    @vote = Vote.new(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      if @vote.save
        flash[:notice] = "Your vote was counted."
        format.html { redirect_to posts_path }
        format.js
      end
    end
  end

end

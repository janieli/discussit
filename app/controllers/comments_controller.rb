class CommentsController < ApplicationController

 before_filter :require_user

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.new(params[:comment])
  	@comment.user_id = current_user.id

  	if @comment.save
  		flash[:notice] = "Your comment was created."
  		redirect_to posts_path(@post)
  	else
  		render 'posts/show'
  	end
  end

  def edit
    @comment = @post.comments.find(params[:comment])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Comment was updated"
      redirect_to post_path(@post)
    else #validation failure
      render :edit
    end
  end

  def vote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    Vote.create(voteable: @comment, user: current_user, vote: params[:vote])

    flash[:notice] = "Your vote was counted."
    redirect_to posts_path(@post)
  end
end
class CommentsController < ApplicationController

 before_filter :require_user

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.new(params[:comment])
  	@comment.user_id = 1 #To Do, change to real user after authentication

  	if @comment.save
  		flash[:notice] = "Your comment was created."
  		redirect_to posts_path(@post)
  	else
  		render 'posts/show'
  	end
  end
end
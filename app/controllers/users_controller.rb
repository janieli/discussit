class UsersController < ApplicationController
	def new
		@user = User.new(params[:user])
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			flash[:notice] = "Thanks for registering!"
			redirect_to root_path
		else
			render :new
		end
	end

end
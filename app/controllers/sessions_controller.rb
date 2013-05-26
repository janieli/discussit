class SessionsController < ApplicationController
	#GET /login
	def new
	end


	#POST/login
	def create
		user = User.where(username: params[:username]).first
		if user&&user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:notice] = "Welcome, you are logged in."
			redirect_to root_path
		else
			flash[:error] = "There is something wrong with your username or password."
			redirect_to new_user_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have logged out."
		redirect_to root_path
	end
end
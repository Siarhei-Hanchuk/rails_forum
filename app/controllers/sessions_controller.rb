class SessionsController < ApplicationController
	skip_before_filter :authorize
	skip_before_filter :is_admin
	def new
	end

	def create
		if user = User.auth(params[:name], params[:password])
			session[:user_id] = user.id
			redirect_to parts_url
		else
			redirect_to login_url, :alert => "Invalid user/password combination"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to parts_url, :notice => "Logged out"
	end
end

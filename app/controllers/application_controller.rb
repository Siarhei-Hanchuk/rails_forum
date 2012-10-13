class ApplicationController < ActionController::Base
	before_filter :authorize
	before_filter :is_admin
	protect_from_forgery

	protected
	def authorize
		unless User.find_by_id(session[:user_id])
			redirect_to '/login', :notice => "Please log in"
		end
	end

	def is_admin
		if session[:user_id]
			unless User.find(session[:user_id]).login=='root'
				redirect_to '/login', :notice => "You are not root"
			end
		end
		#else
		#	redirect_to '/login', :notice => "Please log in"
		#end
	end
end

class ApplicationController < ActionController::Base
	#before_filter :authorize
	#before_filter :is_admin
	#before_filter :lastvisit
	protect_from_forgery

	#before_filter :authenticate_user!, :only => [:new]
	#skip_authorize_resource :only => :new

#	private
#	def current_ability
#		if session[:user_id]
#			@current_ability = Ability.new(User.find(session[:user_id])) 
#		else
#			@current_ability = Ability.new(User.new)
#		end
#	end

	protected
	def authorize
		unless User.find_by_id(session[:user_id])
			redirect_to '/login', :notice => "Please log in"
		end
	end

	def is_admin
		if session[:user_id]
			unless User.find(session[:user_id]).is_admin
				redirect_to '/login', :notice => "You are not root"
			end
		else
			redirect_to '/login', :notice => "Please log in"
		end
	end

	def lastvisit
		if session[:user_id]
			u=User.find(session[:user_id])
			u.last_visit=DateTime.now
			u.save
		end
	end
	def isadmin
		true if session[:user_id] && User.find(session[:user_id]).is_admin
	end

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied."
		redirect_to root_url
	end
end

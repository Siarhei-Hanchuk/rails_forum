class ApplicationController < ActionController::Base
	protect_from_forgery

	def post_per_page
		5
	end

	def current_user
		User.find(session[:user_id])
	end

	private
	def current_ability
		if session[:user_id] && User.exists?(session[:user_id])
			@current_ability = Ability.new(User.find(session[:user_id])) 
		else
			@current_ability = Ability.new(User.new)
		end
	end

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied."
		redirect_to :back
	end
end

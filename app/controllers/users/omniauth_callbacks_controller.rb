class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
		begin
			@user = User.find_for_google_oauth request.env["omniauth.auth"][:extra][:raw_info]
		rescue ActiveRecord::RecordInvalid => error
			redirect_to '/', notice: error.message
			return 
		end
		if @user.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
			sign_in_and_redirect @user, :event => :authentication
			session[:user_id]=@user.id
		else
			flash[:notice] = "authentication error"
			redirect_to root_path
		end
	end

	def facebook
		begin
			@user = User.find_for_facebook_oauth request.env["omniauth.auth"]
		rescue ActiveRecord::RecordInvalid => error
			redirect_to '/', notice: error.message
			return 
		end
		if @user.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
			sign_in_and_redirect @user, :event => :authentication
			session[:user_id]=@user.id
		else
			flash[:notice] = "authentication error"
			redirect_to root_path
		end
	end

	def vkontakte
		begin
			@user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
		rescue ActiveRecord::RecordInvalid => error
			redirect_to '/', notice: error.message
			return 
		end
		if @user.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Vkontakte"
			sign_in_and_redirect @user, :event => :authentication
			session[:user_id]=@user.id
		else
			flash[:notice] = "authentication error"
			redirect_to root_path
		end
	end
end

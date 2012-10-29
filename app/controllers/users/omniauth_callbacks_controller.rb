class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def github
		common 'github'
	end

	def google_oauth2
		common 'google'
	end

	def facebook
		common 'facebook'
	end

	def vkontakte
		common 'vkontakte'
	end

	def common provider
		begin
			@user = User.__send__('find_for_'+provider+'_oauth', request.env["omniauth.auth"])
		rescue ActiveRecord::RecordInvalid => error
			redirect_to '/', notice: error.message
			return 
		end
		if @user.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider
			sign_in_and_redirect @user, :event => :authentication
			session[:user_id]=@user.id
		else
			flash[:notice] = "authentication error"
			redirect_to root_path
		end
	end
end
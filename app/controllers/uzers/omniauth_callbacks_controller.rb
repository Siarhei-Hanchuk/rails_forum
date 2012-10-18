class Uzers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@uzer = Uzer.find_for_facebook_oauth request.env["omniauth.auth"]
		if @uzer.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
			sign_in_and_redirect @uzer, :event => :authentication
		else
			flash[:notice] = "authentication error"
			redirect_to root_path
		end
	end
end

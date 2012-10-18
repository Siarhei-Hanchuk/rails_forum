class Uzers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		<hh user=user> = User.find_for_facebook_oauth request.env["omniauth.auth"]
		if <hh user=user>.persisted?
			flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
			sign_in_and_redirect <hh user=user>, :event => :authentication
		else
			flash[:notice] = "authentication error"
			redirect_to root_path
		end
	end
end

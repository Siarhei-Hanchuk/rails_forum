module UsersHelper
	def current_user2
		User.find(session[:user_id])
	end
end

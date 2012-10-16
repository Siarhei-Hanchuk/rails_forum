class UserMailer < ActionMailer::Base
	default from: "from@example.com"

	def welcome_email(user)
		@user = user
		@url  = "http://glacial-sands-4601.herokuapp.com/"
		mail(:to => user.email, :subject => "Welcome to My Awesome Site")
	end

	def ban_email(user)
		@user = user
		mail(:to => user.email, :subject => "You banned")
	end
end

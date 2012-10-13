module ApplicationHelper
	def is_admin
		true if session[:user_id] && User.find(session[:user_id]).is_admin
	end

	def logged
		session[:user_id]
	end

	def to_date ar_datetime
		ar_datetime.to_datetime.to_s.scan(/[\d-]+/)[0]
	end
end

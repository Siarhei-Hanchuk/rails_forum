module ApplicationHelper
	
	def post_per_page
		5
	end
	
	def to_date ar_datetime
		ar_datetime.to_datetime.to_s.scan(/[\d-]+/)[0]
	end

	def imgurl user, thumb=false
		return '/ava.png' if !user.ava && !user.avatar
		return user.avatar.url if user.avatar && user.avatar.url
		return user.ava if user.ava
		return '/ava.png'
	end

	def show_user_login user
		return user.username if user
		'USER REMOVED'
	end

	def liked? post
		@b=false
		post.likes.all.each { |q|
			@b=true if q.user_id==session[:user_id]
		}
		@b
	end
end

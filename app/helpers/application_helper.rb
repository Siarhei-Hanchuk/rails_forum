module ApplicationHelper

	def isadmin
		#session[:user_id]=1
		
		#if !User.exists?(session[:user_id])
		#	session[:user_id]=nil
		#end
		#true if session[:user_id] && User.find(session[:user_id]).is_admin
		true
	end

	def logged
		session[:user_id]
	end

	def to_date ar_datetime
		ar_datetime.to_datetime.to_s.scan(/[\d-]+/)[0]
	end

	def imgurl user, thumb=false
		return '/ava.png' if !user.avatar
		return user.avatar.thumb if user.avatar.url && thumb
		return user.avatar.url if user.avatar.url
		return '/ava30.png' if thumb
		return '/ava.png'
	end

	def hpe post
		true if isadmin || post.user_id==session[:user_id];
	end

	def show_user_login user
		return user.login if user
		'USER REMOVED'
	end

	def lol post
		@b=false
		post.likes.all.each { |q|
			@b=true if q.user_id==session[:user_id]
		}
		@b
	end
end

class AjaxController < ActionController::Base
	def like
		if !session[:user_id]
			@respond='0^nil'
			return
		end
		@post_id=params[:post_id]
		@post=Post.find(@post_id)
		@b=false
		@post.likes.all.each { |q|
			@b=true if q.user_id==session[:user_id]
		}
		if @b
			@post.likes.find_by_user_id(session[:user_id]).destroy
			@respond='-^+('+@post.likes.count.to_s+')'
		else
			@like=Like.new user_id: session[:user_id], post_id: params[:post_id]
			Post.find(params[:post_id]).likes.push @like
			@respond='+^+('+@post.likes.count.to_s+')'
		end
		render :ajax
	end

	def like_logins
		@respond="";
		@post=Post.find(params[:post_id])
		@post.likes.all.each { |q|
			@respond+=(User.find(q.user_id).username+', ')
		}		
		@respond[-2..-1]='  ' if @respond.size>3
		render :ajax
	end

	def comment
		@comment=Comment.new user_id: session[:user_id], post_id: params[:post_id], body: params[:comment]
		if @comment.save
			@respond=@comment.user.username+': '+@comment.body
		else
			@respond=nil
		end
		render :ajax
	end
end

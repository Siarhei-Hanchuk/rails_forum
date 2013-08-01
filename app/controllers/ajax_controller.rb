class AjaxController < ActionController::Base
	def like
		if !session[:user_id]
			@respond='0^nil'
			render :ajax
			return
		end
		@post_id = params[:post_id]
		@post=Post.find(@post_id)
		@likec = Likec.where(post_id: @post_id).first
		if !@likec
			@likec=Likec.new post_id: @post_id, count: 0
			@likec.save
		end
		@b=false
		@ext_like=@post.likes.where(post_id: @post_id, user_id: session[:user_id]).first
		if @ext_like
			@ext_like.destroy
			@likec.count-=1
			@likec.save
			@respond='-^+('+@likec.count.to_s+')'
		else
			@like=Like.new user_id: session[:user_id], post_id: params[:post_id]
			@like.save
			@likec.count+=1
			@likec.save
			Post.find(params[:post_id]).likes.push @like, nil
			@respond='+^+('+@likec.count.to_s+')'
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
		if !session[:user_id]
			render :ajax
			return
		end
		@comment=Comment.new user_id: session[:user_id], post_id: params[:post_id], body: params[:comment]
		if @comment.save
			@respond=@comment.user.username+': '+@comment.body
		else
			@respond=nil
		end
		render :ajax
	end
end

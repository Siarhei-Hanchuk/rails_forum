class AjaxController < ActionController::Base
	def index
		if !session[:user_id]
			@out='0^nil'
			return
		end
		@post_id=params[:post_id]
		@post=Post.find(@post_id)
		#@o=
		@b=false
		@post.likes.all.each { |q|
			@b=true if q.user_id==session[:user_id]
		}
		if @b
			@post.likes.find_by_user_id(session[:user_id]).destroy
			@out='-^+('+@post.likes.count.to_s+')'
		else
			@like=Like.new user_id: session[:user_id], post_id: params[:post_id]
			Post.find(params[:post_id]).likes.push @like
			@out='+^+('+@post.likes.count.to_s+')'
		end

		respond_to do |format|
			format.html
			format.json { render json: @users }
		end		
	end

	def like_logins
		@out="";
		@post=Post.find(params[:post_id])
		@post.likes.all.each { |q|
			@out+=(User.find(q.user_id).username+', ')
		}
		
		@out[-2..-1]='  ' if @out.size>3
		respond_to do |format|
			format.html
			format.json { render json: @users }
		end	
	end

	def comment
		@comment=Comment.new user_id: session[:user_id], post_id: params[:post_id], body: params[:comment]
		if @comment.save
    		@respond=@comment.user.username+': '+@comment.body#+', at '+@comment.created_at.to_datetime.to_s.scan(/[\d-]+/)[0]
    	else
    		@respond=nil
    	end
    	respond_to do |format|
    		format.html
    	end	
    end
end

class AjaxController < ActionController::Base
	def index
		if !session[:user_id]
			@out='nil'
			return
		end
		@post_id=params[:post_id]
		@post=Post.find(@post_id)
		@o=@post.likes.all
		@b=false
		@o.each { |q|
			@b=true if q.user_id==session[:user_id]
		}
		if @b
			@post.likes.find_by_user_id(session[:user_id]).destroy
			@out='-'
			#@out=@post.likes
			return
		end

		#@post.likes.clear
		@like=Like.new user_id: session[:user_id], post_id: params[:post_id]
		Post.find(params[:post_id]).likes.push @like
		@out='+'
		#@out=@post.likes

		respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @users }
      	end		
    end

    def like_logins
    	@out="";
    	@post=Post.find(params[:post_id])
    	@post.likes.all.each { |q|
			@out+=(User.find(q.user_id).login+', ')
		}
		@out[-2..-1]='  '

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

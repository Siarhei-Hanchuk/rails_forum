class NewpostController < ApplicationController
	#authorize_resource :class => false
	
	def index
		if cannot? :index, :Newpost
			redirect_to '/', notice: 'Access'	
			return
		end	
		@body=params[:body]
		@title=params[:title]
		@part_id=params[:part].keys[0]
		if @body.length<1
			redirect_to '/parts/'+@part_id.to_s, notice: 'Body is empty'
			return
		end
		@topic=Topic.new
		@topic.part_id=@part_id
		@topic.user_id=session[:user_id]
		@topic.title=@title
		@topic.save
		@post=Post.new
		@post.topic_id=@topic.id
		@post.user_id=session[:user_id]
		@post.body=@body;
		@post.save		
		redirect_to '/topics/'+@topic.id.to_s, notice: 'Topic successfully created'
	end
end

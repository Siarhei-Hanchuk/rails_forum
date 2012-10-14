class NewpostController < ApplicationController
	skip_before_filter :is_admin
	def index
		@body=params[:body]
		@title=params[:title]
		@part_id=params[:part].keys[0]
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

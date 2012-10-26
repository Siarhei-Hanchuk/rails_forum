class PostsController < ApplicationController
  load_and_authorize_resource

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id=session[:user_id]
    respond_to do |format|
      if @post.save
        format.html { redirect_to '/topics/'+@post.topic_id.to_s+'?page='+((@post.topic.posts.count-1)/post_per_page+1).to_s+'#'+@post.id.to_s, notice: 'Post was successfully created.' }
        #
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to '/topics/'+@post.topic_id.to_s, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])

    #if !(isadmin ||session[:user_id]==@post.user_id)
    #  redirect_to '/topics/'+@post.topic_id.to_s, notice: "You don't have permission to delete"
    #  return nil
    #end

    #if @post.topic.posts.first==@post
    #  @n='You can\'t remove firt post, please remove topic'
    #  redirect_to '/topics/'+@post.topic_id.to_s, notice: 'You can\'t remove firt post, please remove topic'
    #  return nil
    #end
  
    #redirect_to '/topics/'+@post.topic_id.to_s, notice: @n if @n
    #return false;

    @topic=@post.topic
    @topic_id=@post.topic_id
    @part_id=@topic.part_id
    if @topic.posts.count<2
      @topic.destroy
      @t=true
    else
      @post.destroy
    end

    #redirect_to '/'

    respond_to do |format|
      format.html { redirect_to '/topics/'+@topic_id.to_s} if !@t
      format.html { redirect_to '/parts/'+@part_id.to_s} if @t
      format.json { head :no_content }
    end
  end
end

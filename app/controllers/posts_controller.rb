class PostsController < ApplicationController
  skip_before_filter :is_admin

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if User.find(session[:user_id]).banned?
      redirect_to '/', notice: 'You banned' 
      return
    end
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if !(isadmin ||session[:user_id]==@post.user_id)
      redirect_to '/topics/'+@post.topic_id.to_s, notice: "You don't have permission to edit"
      return nil
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    if User.find(session[:user_id]).banned?
      redirect_to '/', notice: 'You banned' 
      return
    end
    @post = Post.new(params[:post])
    @post.user_id=session[:user_id]
    respond_to do |format|
      if @post.save
        format.html { redirect_to '/topics/'+@post.topic_id.to_s, notice: 'Post was successfully created.' }
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

    if !(isadmin ||session[:user_id]==@post.user_id)
      redirect_to '/topics/'+@post.topic_id.to_s, notice: "You don't have permission to delete"
      return nil
    end

    if @post.topic.posts.first==@post
      @n='You can\'t remove firt post, please remove topic'
      redirect_to '/topics/'+@post.topic_id.to_s, notice: 'You can\'t remove firt post, please remove topic'
      return nil
    end
  
    #redirect_to '/topics/'+@post.topic_id.to_s, notice: @n if @n
    #return false;

    @topic_id=@post.topic_id
    @post.destroy

    respond_to do |format|
      format.html { redirect_to '/topics/'+@topic_id.to_s}
      format.json { head :no_content }
    end
  end
end

class TopicsController < ApplicationController
  load_and_authorize_resource

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])    
    @posts=@topic.posts.page(params[:page]).per(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    @topic.part_id=params[:part]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @body=params[:body]
    @title=params[:title]
    @part_id=params[:part].keys[0]
    if @body.length<1 || @title.length<3
      #render :new, :part=>@part_id
      redirect_to '/topics/new?part='+params[:part].keys[0].to_s, notice: 'Body or Title is empty'
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

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])

    @part_id=@topic.part_id
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to '/parts/'+@part_id.to_s }
      format.json { head :no_content }
    end
  end
end

class UsersController < ApplicationController
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
#  def new
#    @user = User.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @user }
#    end
#  end

  # GET /users/1/edit
  def edit
    #if !session[:user_id]
    #  redirect_to '/', notice: 'access'
    #  return 
    #end
    @user = User.find(params[:id])
    current_user=User.find(session[:user_id])
    flag=false
    flag=true if current_user.is? :admin
    flag=true if current_user.id===@user.id

    #if !(current_user.is? :admin || current_user.id==@user.id)
    if !flag
      redirect_to '/', notice: @user.id.to_s
      return 
    end

  end

  # POST /users
  # POST /users.json
#  def create
#    @user = User.new(params[:user])
#
#    respond_to do |format|
#      if @user.save
#        format.html { redirect_to @user, notice: 'User was successfully created.' }
#        format.json { render json: @user, status: :created, location: @user }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def ban
    user=User.find(params[:user_id])
    role=params[:role]
    if user.is? role
      user.roles=user.roles-[role]
    else
      user.roles=user.roles<<role
    end
    if user.save
      #UserMailer.ban_email(user).deliver if user.email
      redirect_to '/users/'+user.id.to_s+'/edit', notice: 'Role changed'
    else
      redirect_to '/users/', notice: 'Error ban'
    end
  end

  def unban
    user=User.find(params[:user_id])
    user.role='banned'
    if user.save
      redirect_to '/users/', notice: 'User are unbanned'
    else
      redirect_to '/users/', notice: 'Error ban'
    end
  end

end

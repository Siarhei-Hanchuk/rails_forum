class UsersController < ApplicationController
  skip_before_filter :authorize#, :only => [:show,:update,:edit]
  skip_before_filter :is_admin, :except => [:index, :destroy, :ban]
  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    @users = User.paginate :page=>params[:page], :per_page=>5

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
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit    
    redirect_to '/' if session[:user_id].to_s!=params[:id]# || !is_admin
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.status=0;
    respond_to do |format|
      if @user.save
        session[:user_id]=@user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    redirect_to '/' if session[:user_id].to_s!=params[:id]# || !is_admin
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
    user.ban

    UserMailer.welcome_email(user).deliver

    redirect_to '/users/', notice: 'User are banned'
  end

  def unban
    user=User.find(params[:user_id]).unban
    redirect_to '/users/', notice: 'User are unbanned'
  end

  def change_password
    @p1=params[:pass]
    @p2=params[:pass_confirmation]
    if @p1==@p2
      u=User.find(session[:user_id])
      u.pass=@p1

    end
    if u.save
      redirect_to '/users/'+session[:user_id].to_s, notice: 'Password successfully changed'
    else
      redirect_to '/users/'+session[:user_id].to_s, notice: 'Error change password'
    end
  end

end

class UzersController < ApplicationController
  # GET /uzers
  # GET /uzers.json
  def index
    @uzers = Uzer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uzers }
    end
  end

  # GET /uzers/1
  # GET /uzers/1.json
  def show
    @uzer = Uzer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uzer }
    end
  end

  # GET /uzers/new
  # GET /uzers/new.json
  def new
    @uzer = Uzer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uzer }
    end
  end

  # GET /uzers/1/edit
  def edit
    @uzer = Uzer.find(params[:id])
  end

  # POST /uzers
  # POST /uzers.json
  def create
    @uzer = Uzer.new(params[:uzer])

    respond_to do |format|
      if @uzer.save
        format.html { redirect_to @uzer, notice: 'Uzer was successfully created.' }
        format.json { render json: @uzer, status: :created, location: @uzer }
      else
        format.html { render action: "new" }
        format.json { render json: @uzer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uzers/1
  # PUT /uzers/1.json
  def update
    @uzer = Uzer.find(params[:id])

    respond_to do |format|
      if @uzer.update_attributes(params[:uzer])
        format.html { redirect_to @uzer, notice: 'Uzer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @uzer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uzers/1
  # DELETE /uzers/1.json
  def destroy
    @uzer = Uzer.find(params[:id])
    @uzer.destroy

    respond_to do |format|
      format.html { redirect_to uzers_url }
      format.json { head :no_content }
    end
  end
end

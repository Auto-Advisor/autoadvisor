class MajorsController < ApplicationController
  # GET /majors
  # GET /majors.json
  def index
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @majors = usernow.majors.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @majors }
    end
  end

  # GET /majors/1
  # GET /majors/1.json
  def show
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @major = usernow.majors.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/new
  # GET /majors/new.json
  def new
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @major = Major.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @major }
    end
  end

  # GET /majors/1/edit
  def edit
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @major = usernow.majors.find(params[:id])
  end

  # POST /majors
  # POST /majors.json
  def create
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @major = Major.new(params[:major])
    usernow.majors << @major

    respond_to do |format|
      if @major.save
        format.html { redirect_to @major, notice: 'Major was successfully created.' }
        format.json { render json: @major, status: :created, location: @major }
      else
        format.html { render action: "new" }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /majors/1
  # PUT /majors/1.json
  def update
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @major = usernow.majors.find(params[:id])

    respond_to do |format|
      if @major.update_attributes(params[:major])
        format.html { redirect_to @major, notice: 'Major was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majors/1
  # DELETE /majors/1.json
  def destroy
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @major = usernow.majors.find(params[:id])
    @major.destroy

    respond_to do |format|
      format.html { redirect_to majors_url }
      format.json { head :no_content }
    end
  end
end

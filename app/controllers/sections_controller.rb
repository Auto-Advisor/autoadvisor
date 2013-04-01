class SectionsController < ApplicationController
  # GET /sections
  # GET /sections.json
  def index
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @sections = usernow.sections.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @section = usernow.sections.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.json
  def new
    @section = Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/1/edit
  def edit
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @section = usernow.sections.find(params[:id])
  end

  # POST /sections
  # POST /sections.json
  def create
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @section = Section.new(params[:section])
    usernow.sections << @section

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render json: @section, status: :created, location: @section }
      else
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @section = usernow.sections.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @section = usernow.sections.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_url }
      format.json { head :no_content }
    end
  end
end

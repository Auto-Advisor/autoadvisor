class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    redirect_to :controller => 'Pages', :action => 'main'
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  def transcript  
    @user = User.find(params[:id])
  end

  def schedule
    @user = User.find(params[:id])
  end
end

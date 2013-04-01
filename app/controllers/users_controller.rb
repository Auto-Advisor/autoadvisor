class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    redirect_to :controller => 'Pages', :action => 'main'
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def transcript
    @user = current_user
  end

  def schedule
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
end

class PagesController < ApplicationController
  def main
    if user_signed_in?
      usernow = User.find(session[:'warden.user.user.key'][1][0])
      @admin = usernow.admin
      @email = usernow.email
    end
  end

  def profile
    @user = User.find(session[:'warden.user.user.key'][1][0])
  end

  def transcript
    @user = User.find(params[:id])
  end

  def schedules
    @user = User.find(session[:'warden.user.user.key'][1][0])
  end

end

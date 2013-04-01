class PagesController < ApplicationController
  def main
  end

  def profile
    @user = User.find(session[:'warden.user.user.key'][1][0])
  end

  def transcript
    @user = User.find(session[:'warden.user.user.key'][1][0])
  end

  def schedules
    @user = User.find(session[:'warden.user.user.key'][1][0])
  end

end

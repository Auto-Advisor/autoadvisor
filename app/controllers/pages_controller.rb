class PagesController < ApplicationController
  def main
    if user_signed_in?
      usernow = User.find(session[:'warden.user.user.key'][1][0])
      @admin = usernow.admin
      @email = usernow.email
    end
  end

  def profile
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @email = usernow.email
    @majors = usernow.majors
    @courses = usernow.sections
    @credit = usernow.credits
  end

  def transcript
    @u = session
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @past_course = usernow.past_courses
  end
end

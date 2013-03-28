class PagesController < ApplicationController
  def main
  end

  def profile
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @email = usernow.email
    @majors = usernow.majors
    @courses = usernow.sections
    @credit = usernow.credits
  end

  def transcript
    usernow = User.find(session[:'warden.user.user.key'][1][0])
    @past_course = usernow.past_courses
  end

  def friends
	usernow = User.find(session[:'warden.user.user.key'][1][0])
	@friend = usernow.friends
	end

  def schedule
	usernow = User.find(session[:'warden.user.user.key'][1][0])
	@schedule = usernow.schedules
	end

end

class PagesController < ApplicationController
  def main
  end

  def logged_in
    render :json => signed_in?
  end
end

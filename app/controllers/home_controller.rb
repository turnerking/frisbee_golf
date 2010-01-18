class HomeController < ApplicationController
  def show
    @courses = Course.find(:all)
  end
end

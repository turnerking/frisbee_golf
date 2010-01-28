class CoursesController < ApplicationController
  def show
    @course = Course.find(params[:id])
    @scorecard = Scorecard.new(:course => @course, :user => current_user)
  end
end
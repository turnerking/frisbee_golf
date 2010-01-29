class CoursesController < ApplicationController
  def show
    @course = Course.find(params[:id])
    @scorecard = Scorecard.new(:course => @course, :user => current_user)
    @review = Review.new(:course => @course, :user => current_user)
    @reviews = Review.find_all_by_course_id(params[:id])
  end
end
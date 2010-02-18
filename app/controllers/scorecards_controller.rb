class ScorecardsController < ApplicationController
  def create
    @scorecard = Scorecard.new(params[:scorecard])
    if @scorecard.save
      redirect_to course_path(@scorecard.course_id)
    else
      @course = Course.find(@scorecard.course_id)
      @review = Review.new(:course => @course, :user => current_user)
      render :template => "courses/show"
    end
  end
end
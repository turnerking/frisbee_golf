class ReviewsController < ApplicationController
  def create
    @review = Review.create(params[:review])
    redirect_to course_path(@review.course)
  end
end
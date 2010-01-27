class Admin::CoursesController < ApplicationController
  before_filter :admin_required
  
  def index
    @courses = Course.find(:all)
  end
  
  def new
    @course = Course.new
  end
  
  def create
    Course.create(params[:course])
    redirect_to admin_courses_path
  end
  
  def destroy
    course = Course.find(params[:id])
    course.destroy
    redirect_to admin_courses_path
  end
  
  private
  
  def admin_required
    redirect_to "/" and return unless current_user && current_user.admin?
  end
end

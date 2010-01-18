class Admin::CoursesController < ApplicationController
  def index
    @courses = Course.find(:all)
  end
  
  def new
  end
  
  def create
    redirect_to admin_courses_path
  end
  
  def destroy
    course = Course.find(params[:id])
    course.destroy
    redirect_to admin_courses_path
  end
end

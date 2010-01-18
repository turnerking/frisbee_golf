require 'spec_helper'

describe Admin::CoursesController do

  context "get index" do
    it "gets all the courses" do
      @courses = mock("courses collection")
      Course.should_receive(:find).with(:all).and_return(@courses)

      get :index
  
      assigns[:courses].should == @courses
    end
  end
  
  context "delete destroy" do
    it "deletes a course from the database" do
      @course = Course.create!
      Course.should_receive(:find).with("3").and_return(@course)
      lambda do
        delete :destroy, :id => "3"
      end.should change(Course, :count).by(-1)
      response.should redirect_to admin_courses_path
    end
  end

end
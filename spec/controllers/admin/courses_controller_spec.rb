require 'spec_helper'

describe Admin::CoursesController do
  include AuthenticatedTestHelper
  fixtures :users
  
  context "not logged in as admin" do
    it "redirects the user if not logged in" do
      get :index
      
      response.should redirect_to("/")
    end
    
    it "redirects the user if not an admin" do
      login_as(:aaron)
      
      get :index
      
      response.should redirect_to("/")
    end
  end
  
  context "logged in as admin" do
    before :each do
      login_as :quentin
    end

    context "get index" do
      it "gets all the courses" do
        @courses = mock("courses collection")
        Course.should_receive(:find).with(:all).and_return(@courses)

        get :index
  
        assigns[:courses].should == @courses
      end
    end
  
    context "get new" do
    
    end
  
    context "post create" do
      it "adds a new course to the database" do
        course_params = {"name" => "stuff"}
        lambda do
          post :create, :course => course_params
        end.should change(Course, :count).by(1)
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

end

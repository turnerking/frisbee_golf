require 'spec_helper'

describe HomeController do

  context "get show" do
    it "assigns courses instance variable" do
      courses = mock("courses collection")
      Course.should_receive(:find).with(:all).and_return(courses)
      get :show
      assigns[:courses].should == courses
    end
  end

end

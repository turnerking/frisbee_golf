require 'spec_helper'

describe Review do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    review = Review.new(@valid_attributes)
    review.should be_valid
  end
  
  context "non-validated attributes" do
    it "can have a difficulty rating" do
      Review.new.should respond_to :difficulty
    end
    
    it "can have a tree interference" do
      Review.new.should respond_to :tree_interference
    end
    
    it "can have course quality" do
      Review.new.should respond_to :course_quality
    end
    
    it "can have notes" do
      Review.new.should respond_to :body
    end
  end
end

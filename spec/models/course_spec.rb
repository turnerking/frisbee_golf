require 'spec_helper'

describe Course do
  before(:each) do
    @valid_attributes = {
      :name => "New Course"
    }
  end

  it "should create a new instance given valid attributes" do
    Course.new(@valid_attributes).should be_valid
  end
  
  context "validations" do
    it "must have a name" do
      course = Course.new(@valid_attributes.merge(:name => ""))
      course.should_not be_valid
      course.errors.on(:name).should_not be_nil
    end
  end
  
  context "non-validated attributes" do
    it "can have an address" do
      Course.new.should respond_to(:address)
    end
    
    it "can have a tee_type" do
      Course.new.should respond_to(:tee_type)
    end
    
    it "can have a difficulty" do
      Course.new.should respond_to(:difficulty)
    end
    
    it "can have a tree interference" do
      Course.new.should respond_to(:tree_interference)
    end
    
    it "can have a hole type" do
      Course.new.should respond_to(:hole_type)
    end
  end
  
  context "holes" do
    it "has many holes" do
      Course.new.should respond_to(:holes)
    end
    
    it "can accept attributes for holes" do
      Course.new.should respond_to(:holes_attributes=)
    end
    
    it "doesn't accept holes with info missing" do
      course = Course.create({"holes_attributes" => 
                      {"0" => {"number" => "1", "par" => "3", "distance_in_ft" => "4"},
                       "1" => {"number" => "", "par" => "3", "distance_in_ft" => "4"},
                       "2" => {"number" => "1", "par" => "", "distance_in_ft" => "4"},
                       "3" => {"number" => "1", "par" => "3", "distance_in_ft" => ""}}
                    })
      course.holes.size.should == 1
    end
  end
end

require 'spec_helper'

describe Course do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Course.create!(@valid_attributes)
  end
  
  context "attributes" do
    it "can have a name" do
      Course.new.should respond_to(:name)
    end
    
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
end

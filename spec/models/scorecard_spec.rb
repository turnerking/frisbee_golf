require 'spec_helper'

describe Scorecard do
  before(:each) do
    @valid_attributes = {
      :temperature => "64",
      :user_id => 1,
      :course_id => 4
    }
  end

  it "creates a new instance given valid attributes" do
    Scorecard.new(@valid_attributes).should be_valid
  end
  
  context "validations" do
    it "must have a proper temperature" do
      scorecard = Scorecard.new(@valid_attributes.merge(:temperature => "abe"))
      scorecard.should_not be_valid
      scorecard.errors.on(:temperature).should_not be_nil
    end
    
    it "must have a user_id" do
      scorecard = Scorecard.new(@valid_attributes.merge(:user_id => nil))
      scorecard.should_not be_valid
      scorecard.errors.on(:user_id).should_not be_nil
    end
    
    it "must have a course_id" do
      scorecard = Scorecard.new(@valid_attributes.merge(:course_id => nil))
      scorecard.should_not be_valid
      scorecard.errors.on(:course_id).should_not be_nil
    end
    
    it "must not have a bullshit score" do
      scorecard = Scorecard.new(@valid_attributes.merge("scores_attributes" => {"0" => {"par" => "6", "shots" => "1", "number" => 1, "distance_in_ft" => 300}}))
      scorecard.should_not be_valid
      scorecard.errors.on(:base).should_not be_nil
    end
  end
  
  context "non-validated attributes" do
    it "can have weather" do
      Scorecard.new.should respond_to(:weather)
    end
    
    it "can have ground conditions" do
      Scorecard.new.should respond_to(:ground_conditions)
    end
    
    it "can have a played at time" do
      Scorecard.new.should respond_to(:played_at)
    end
    
    it "can have notes" do
      Scorecard.new.should respond_to(:notes)
    end
  end
  
  context "scores" do
    it "has many scores" do
      Scorecard.new.should respond_to(:scores)
    end
    
    it "can accept attributes for scores" do
      Scorecard.new.should respond_to(:scores_attributes=)
    end
    
    it "doesn't accept holes with info missing" do
      scorecard = Scorecard.create({"scores_attributes" => 
                      {"0" => {"number" => "1", "par" => "3", "distance_in_ft" => "4", "shots" => "3"},
                       "1" => {"number" => "", "par" => "3", "distance_in_ft" => "4", "shots" => "3"},
                       "2" => {"number" => "1", "par" => "", "distance_in_ft" => "4", "shots" => "3"},
                       "3" => {"number" => "1", "par" => "3", "distance_in_ft" => "", "shots" => "3"},
                       "4" => {"number" => "1", "par" => "3", "distance_in_ft" => "4", "shots" => ""}}
                      })
      scorecard.scores.size.should == 1
    end
  end
  
  context "top scores" do
    it "returns scorecards in order by final score" do
      scorecard = mock("scorecard", :final_score => 33)
      scorecard2 = mock("scorecard", :final_score => 2)
      Scorecard.stub!(:find).and_return([scorecard, scorecard2])
      Scorecard.top_scores(:condtions => mock("some conditions")).should == [scorecard2, scorecard]
    end
  end
end

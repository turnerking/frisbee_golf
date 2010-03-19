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
  
  context "reviews" do
    it "has many reviews" do
      Course.new.should respond_to(:reviews)
    end
    
    describe "recent" do
      before :each do
        @course = Course.create(@valid_attributes)
      end
      
      it "returns reviews from the past year" do
        review1 = Review.create(:course => @course)
        sleep(1)
        review2 = Review.create(:course => @course)
        sleep(1)
        review3 = Review.create(:course => @course)
        @course.recent_unique_reviews.should == [review3, review2, review1]
      end
      
      
      context "derived statisitics" do
        before :each do
          Review.create(:tree_interference => 2, :difficulty => 3, :course_quality => 5, :course => @course)
          Review.create(:tree_interference => 1, :difficulty => 2, :course_quality => 3, :course => @course)
          Review.create(:tree_interference => 2, :difficulty => 4, :course_quality => 5, :course => @course)
        end
        
        it "returns the community course quality" do
          @course.course_quality.should == 4.33
        end
        
        it "returns the community difficulty rating" do
          @course.community_difficulty.should == 3
        end
        
        it "returns the community tree interference" do
          @course.community_tree_interference.should == 1.67
        end
      end
    end
  end
  
  describe "scorecards" do
    it "has many scorecards" do
      Course.new.should respond_to(:scorecards)
    end
    
    describe "best scores from" do
      before :each do
        @course = Course.create(@valid_attributes)
      end
      
      it "returns an empty array when there are no scores" do
        @course.best_scores_from(1.year.ago, 2.days.from_now).should be_empty
      end
      
      it "returns the best scores from the course" do
        @scorecard1 = mock("scorecard", :final_score => +2)
        @scorecard2 = mock("scorecard", :final_score => -3)
        @scorecard3 = mock("scorecard", :final_score => -4)
        @course.scorecards.should_receive(:find).and_return([@scorecard1, @scorecard2, @scorecard3])
        @course.best_scores_from(1.year.ago, 2.days.from_now, 2).should == [@scorecard3, @scorecard2]
      end
    end
  end
  
  context "hole totals" do
    before :each do
      @course = Course.create(@valid_attributes.merge({"holes_attributes" => 
                      {"0" => {"number" => "1", "par" => "3", "distance_in_ft" => "250"},
                       "1" => {"number" => "2", "par" => "4", "distance_in_ft" => "327"},
                       "2" => {"number" => "3", "par" => "5", "distance_in_ft" => "400"},
                       "3" => {"number" => "4", "par" => "3", "distance_in_ft" => "186"}}
                    }))
    end
    
    it "totals par" do
      @course.total_par.should == 15
    end
    
    it "totals distance" do
      @course.total_distance.should == 1163
    end
  end
  
  describe "challenges" do
    it "has many challenges" do
      Course.new.should respond_to(:challenges)
    end
  end
end

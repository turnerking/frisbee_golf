require 'spec_helper'

describe Challenge do
  before(:each) do
    @users = [User.create(:name => "Turner", :email => "tk@example.com", :login => "turner", :password => "abc123", :password_confirmation => "abc123"), 
              User.create(:name => "Becky", :email => "bk@example.com", :login => "becky", :password => "abc123", :password_confirmation => "abc123")]
    @valid_attributes = {
      :organizer_id => 1,
      :play_from => 2.days.from_now,
      :play_to => 9.days.from_now,
      :submit_by => 10.days.from_now,
      :user_ids => @users.map(&:id) 
    }
  end

  it "creates a new instance given valid attributes" do
    challenge = Challenge.new(@valid_attributes)
    challenge.should be_valid
  end
  
  context 'validations' do
    it "must have an organizer" do
      challenge = Challenge.new(@valid_attributes.merge(:organizer_id => nil))
      challenge.should_not be_valid
      challenge.errors.on(:organizer_id).should_not be_nil
    end
    
    it "must have a play from date" do
      challenge = Challenge.new(@valid_attributes.merge(:play_from => nil))
      challenge.should_not be_valid
      challenge.errors.on(:play_from).should_not be_nil
    end
    
    it "must have a play to date" do
      challenge = Challenge.new(@valid_attributes.merge(:play_to => nil))
      challenge.should_not be_valid
      challenge.errors.on(:play_to).should_not be_nil
    end
    
    it "must have a submit by date" do
      challenge = Challenge.new(@valid_attributes.merge(:submit_by => nil))
      challenge.should_not be_valid
      challenge.errors.on(:submit_by).should_not be_nil
    end
    
    it "must have the dates in the correct order and in the future" do
      challenge = Challenge.new(@valid_attributes.merge(:play_from => 2.days.ago, :play_to => 7.days.ago, :submit_by => 1.day.ago))
      challenge.should_not be_valid
      challenge.errors.on_base.should include "Play From Date must be before Play To Date"
      challenge.errors.on_base.should include "Play From Date must be in the future"
    end
    
    it "must have at least two challengers" do
      challenge = Challenge.new(@valid_attributes.merge(:user_ids => [@users[0].id]))
      challenge.should_not be_valid
      challenge.errors.on(:user_ids).should_not be_nil
    end
  end
  
  describe "leaderboard" do
    it "returns scorecards in order" do
      user = User.new
      user_scorecard = mock("scorecard", :final_score => 1)
      user.should_receive(:best_score_for).and_return(user_scorecard)
      user2 = User.new
      user2_scorecard = mock("scorecard", :final_score => -1)
      user2.should_receive(:best_score_for).and_return(user2_scorecard)
      challenge = Challenge.new
      challenge.stub(:users).and_return([user, user2])
      challenge.leaderboard.should == [user2_scorecard, user_scorecard]
    end
  end
  
  describe "non scoring users" do
    it "returns the users who haven't scored yet" do
      user = User.new
      user_scorecard = mock("scorecard", :final_score => 1)
      user.should_receive(:best_score_for).and_return(user_scorecard)
      user2 = User.new
      user3 = User.new
      challenge = Challenge.new
      challenge.stub(:users).and_return([user, user2, user3])
      challenge.non_scoring_users.should == [user2, user3]
    end
  end
end

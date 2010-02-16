class Challenge < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => "challengers"
  belongs_to :course
  belongs_to :organizer, :class_name => "User"
  
  def leaderboard   
    scorecards = self.users.inject([]) do |scorecards, user|
      scorecards << user.best_score_for(play_from, play_to, course_id)
    end
    
    scorecards.compact.sort {|a,b| a.total_score <=> b.total_score}
  end
  
  def non_scoring_users
    self.users.map {|user| user.best_score_for(play_from, play_to, course_id).nil? ? user : nil }.compact
  end
  
end
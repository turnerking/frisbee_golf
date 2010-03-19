class Challenge < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => "challengers"
  belongs_to :course
  belongs_to :organizer, :class_name => "User"
  
  validates_presence_of :organizer_id
  validates_presence_of :play_from
  validates_presence_of :play_to
  validates_presence_of :submit_by
  validate :dates_are_in_order_and_in_the_future
  validates_length_of :user_ids, :minimum => 2
  
  def leaderboard   
    scorecards = self.users.inject([]) do |scorecards, user|
      scorecards << user.best_score_for(play_from, play_to, course_id)
    end
    
    scorecards.compact.sort {|a,b| a.final_score <=> b.final_score}
  end
  
  def non_scoring_users
    self.users.map {|user| user.best_score_for(play_from, play_to, course_id).nil? ? user : nil }.compact
  end
  
  def dates_are_in_order_and_in_the_future
    return if play_from.nil? || play_to.nil? || submit_by.nil?
    errors.add_to_base("Play From Date must be before Play To Date") unless play_from < play_to
    errors.add_to_base("Play To Date must be before Submit By Date") unless play_to < submit_by
    errors.add_to_base("Play From Date must be in the future") unless Time.now.to_date <= play_from.to_date
  end
  
end
class Scorecard < ActiveRecord::Base
  WEATHER_CONDITIONS = ["Sunny", "Cloudy", "Rainy", "Very Rainy", "Windy", "Very Windy", "Foggy", "Snow"]
  GROUND_CONDITIONS = ["Dry", "Normal", "Soft", "Muddy", "Very Muddy"]
  
  has_many :scores
  belongs_to :course
  belongs_to :user
  
  accepts_nested_attributes_for :scores, :reject_if => proc {|attributes| attributes["number"].blank? || attributes["par"].blank? || attributes["distance_in_ft"].blank? || attributes["shots"].blank?}
  
  validates_numericality_of :temperature, :allow_blank => true
  validates_presence_of :course_id
  validates_presence_of :user_id
  validate :not_bullshit_score
  
  def self.top_scores(args)
    all_scorecards = Scorecard.find(:all, args)
    Scorecard.sorted(all_scorecards)
  end
  
  def final_score
    total_shots - total_par
  end
  
  def total_shots
    scores.map(&:shots).sum
  end
  
  def total_par
    scores.map(&:par).sum
  end
  
  def total_distance
    scores.map(&:distance_in_ft).sum
  end
  
  def not_bullshit_score
    bull_shit = scores.map {|score| (score.par/2) + 1}.sum
    self.errors.add_to_base("There's no way you got #{total_shots} on a par #{total_par}") if total_shots < bull_shit
  end
  
  private
  
  def self.sorted(scorecards)
    return [] if scorecards.empty?
    scorecards.sort {|a,b| a.final_score <=> b.final_score}
  end
end
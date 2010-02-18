class Scorecard < ActiveRecord::Base
  WEATHER_CONDITIONS = ["Sunny", "Cloudy", "Rainy", "Very Rainy", "Windy", "Very Windy", "Foggy", "Snow"]
  GROUND_CONDITIONS = ["Dry", "Normal", "Soft", "Muddy", "Very Muddy"]
  
  has_many :scores
  belongs_to :course
  belongs_to :user
  
  accepts_nested_attributes_for :scores, :reject_if => proc {|attributes| attributes["number"].blank? || attributes["par"].blank? || attributes["distance_in_ft"].blank? || attributes["shots"].blank?}
  
  validates_numericality_of :temperature, :allow_blank => true
  validate :not_bullshit_score
  
  def total_score
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
    self.errors.add_to_base("There's no way you got #{total_score} on a par #{total_par}") if total_score < bull_shit
  end
end
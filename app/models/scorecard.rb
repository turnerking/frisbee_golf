class Scorecard < ActiveRecord::Base
  WEATHER_CONDITIONS = ["Sunny", "Cloudy", "Rainy", "Very Rainy", "Windy", "Very Windy", "Foggy", "Snow"]
  GROUND_CONDITIONS = ["Dry", "Normal", "Soft", "Muddy", "Very Muddy"]
  
  has_many :scores
  belongs_to :course
  belongs_to :user
  
  accepts_nested_attributes_for :scores, :reject_if => proc {|attributes| attributes["number"].blank? || attributes["par"].blank? || attributes["distance_in_ft"].blank? || attributes["shots"].blank?}
  
  validates_numericality_of :temperature, :allow_blank => true
  
  def total_score
    scores.map(&:shots).sum
  end
  
  def total_par
    scores.sum(&:par)
  end
  
  def total_distance
    scores.sum(&:distance_in_ft)
  end
end
class Course < ActiveRecord::Base
  TEE_TYPES = ["Gravel", "Concrete", "Sand"]
  HOLE_TYPES = ["Basket", "Target", "Mixed"]
  
  has_many :holes, :order => :number
  has_many :scorecards
  has_many :reviews, :order => "created_at DESC"
  
  accepts_nested_attributes_for :holes, :allow_destroy => true, :reject_if => proc {|attributes| attributes["number"].blank? || attributes["par"].blank? || attributes["distance_in_ft"].blank?}
  
  validates_presence_of :name
  
  def total_par
    holes.sum(&:par)
  end
  
  def total_distance
    holes.sum(&:distance_in_ft)
  end
end

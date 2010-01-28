class Scorecard < ActiveRecord::Base
  has_many :scores
  belongs_to :course
  belongs_to :user
  
  accepts_nested_attributes_for :scores
end
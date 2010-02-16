class Friendship < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :requester, :class_name => "User"
  belongs_to :approver, :class_name => "User"
  
  def approve
    self.update_attributes(:approved_at => Time.now)
    self.users << self.requester << self.approver
  end
end
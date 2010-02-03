class Friendship < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :requester, :class_name => "User"
  belongs_to :approver, :class_name => "User"
end
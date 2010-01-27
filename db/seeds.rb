# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

user = User.create!(:name => "Admin", :login => "siteadmin", :email => "turneraking@gmail.com", :password => "P@55wOrD", :password_confirmation => "P@55wOrD")
user.update_attribute(:admin, true)

Course.create!(:name => "O'Brien Park",
               :address => "O'Brien Park, Downers Grove, IL 60516",
               :tee_type => "Gravel",
               :difficulty => 1,
               :tree_interference => 2,
               :hole_type => "Basket")

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

user = User.create!(:first_name => "Admin", :last_name => "", :login => "siteadmin", :email => "turneraking@gmail.com", :password => "P@55wOrD", :password_confirmation => "P@55wOrD", :birthdate => "2010-01-13", :gender => "M", :state => "IL")
user.update_attribute(:admin, true)

#O'Brien Park, Downers Grove, IL
obrien_park_holes = 
  [ Hole.create(:number => 1, :par => 4, :distance_in_ft => 200),
    Hole.create(:number => 2, :par => 4, :distance_in_ft => 200),
    Hole.create(:number => 3, :par => 3, :distance_in_ft => 200),
    Hole.create(:number => 4, :par => 3, :distance_in_ft => 200),
    Hole.create(:number => 5, :par => 3, :distance_in_ft => 200),
    Hole.create(:number => 6, :par => 3, :distance_in_ft => 200),
    Hole.create(:number => 7, :par => 3, :distance_in_ft => 200),
    Hole.create(:number => 8, :par => 3, :distance_in_ft => 200),
    Hole.create(:number => 9, :par => 4, :distance_in_ft => 200)]

obrien_park = 
  Course.create!(:name => "O'Brien Park",
                 :address => "O'Brien Park, Downers Grove, IL 60516",
                 :tee_type => "Gravel",
                 :difficulty => 1,
                 :tree_interference => 2,
                 :hole_type => "Basket")
               
obrien_park.holes = obrien_park_holes

#Castaldo Park, Woodridge, IL
castaldo_park_holes = 
  [ Hole.create(:number => 1, :par => 4, :distance_in_ft => 280),
    Hole.create(:number => 2, :par => 4, :distance_in_ft => 300),
    Hole.create(:number => 3, :par => 5, :distance_in_ft => 405),
    Hole.create(:number => 4, :par => 3, :distance_in_ft => 185),
    Hole.create(:number => 5, :par => 3, :distance_in_ft => 235),
    Hole.create(:number => 6, :par => 4, :distance_in_ft => 255),
    Hole.create(:number => 7, :par => 4, :distance_in_ft => 275),
    Hole.create(:number => 8, :par => 4, :distance_in_ft => 250),
    Hole.create(:number => 9, :par => 4, :distance_in_ft => 330)]

castaldo_park = 
  Course.create!(:name => "Castaldo Park",
                 :address => "3024 71st St., Woodridge, IL 60517",
                 :tee_type => "Concrete",
                 :difficulty => 3,
                 :tree_interference => 3,
                 :hole_type => "Basket")
                 
castaldo_park.holes = castaldo_park_holes

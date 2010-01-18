# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

user = User.create!(:name => "Admin", :email => "turneraking@gmail.com", :password => "P@55wOrD", :password_confirmation => "P@55wOrD")
user.update_attribute(:admin, true)

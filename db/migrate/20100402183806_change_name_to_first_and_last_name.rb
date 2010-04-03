class ChangeNameToFirstAndLastName < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :limit => 100, :default => '', :null => true
    add_column :users, :last_name, :string, :limit => 100, :default => '', :null => true
    User.all.each do |user|
      user.update_attributes(:first_name => user.name)
    end
    remove_column :users, :name
  end

  def self.down
    add_column :users, :name, :string, :limit => 100, :default => '', :null => true
    User.all.each do |user|
      user.update_attributes(:name => "#{user.first_name} #{user.last_name}")
    end
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end

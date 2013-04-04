class AddGpaToUser < ActiveRecord::Migration
  def change
    add_column :users, :gpa, :float, :null => false, :default => 0.0
  end
end

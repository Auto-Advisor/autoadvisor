class UpdateCredit < ActiveRecord::Migration
  def up
    add_column :credits, :units, :decimal, :null => false, :default => 0, :precision => 8, :scale => 4
    add_column :credits, :points, :decimal, :null => false, :default => 0, :precision => 8, :scale => 4
    change_column :credits, :grade, :string

    change_column :users, :gpa, :decimal, :default => 0, :null => false, :precision => 8, :scale => 4
    add_column :users, :grade_points, :decimal, :default => 0, :null => false, :precision => 8, :scale => 4
    add_column :users, :credit_hours, :decimal, :default => 0, :null => false, :precision => 8, :scale => 4
  end

  def down
    remove_column :credits, :units
    remove_column :credits, :points
    change_column :credits, :grade, :float
    change_column :users, :gpa, :float
    remove_column :users, :grade_points
    remove_column :users, :credit_hours
  end
end

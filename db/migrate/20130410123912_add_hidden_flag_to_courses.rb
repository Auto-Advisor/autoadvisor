class AddHiddenFlagToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :hidden, :bool, :null => false, :default => false
  end
end

class AddMajorLinks < ActiveRecord::Migration
  def up
    add_column :majors, :code, :string, :null => false, :default => ''
    add_column :courses, :major_id, :integer, :null => true, :default => nil
    remove_column :courses, :major
  end

  def down
    remove_column :majors, :code
    remove_column :courses, :major_id
    add_column :courses, :major, :string, :null => false, :default => true
  end
end

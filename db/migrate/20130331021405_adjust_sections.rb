class AdjustSections < ActiveRecord::Migration
  def up
    add_column :sections, :room, :string
    add_column :sections, :units, :string, :null => false, :default => '0'
    add_column :sections, :type, :string, :null => false, :default => ''
    remove_column :sections, :primary
    change_column :sections, :class_number, :int, :null => false, :default => 0
    change_column :sections, :class_string, :string, :null => false
    change_column :sections, :section_number, :string, :null => false
    change_column :sections, :dept, :string, :null => false
  end

  def down
    remove_column :sections, :room
    remove_column :sections, :units
    remove_column :sections, :type
    add_column :sections, :primary, :boolean
    change_column :sections, :class_number, :int, :null => true, :default => nil
    change_column :sections, :class_string, :string, :null => true
    change_column :sections, :section_number, :string, :null => true
    change_column :sections, :dept, :string, :null => true
  end
end

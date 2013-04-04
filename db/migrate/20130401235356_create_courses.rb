class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :dept, :null => false, :default => 'Unknown' 
      t.text :desc, :null => true
      t.string :name, :null => false, :default => 'Unknown'
      t.integer :number, :null => false, :default => 0
      t.string :string, :null => false, :default => 'UNKNOWN'
    end

    change_table :sections do |t|
      t.references :course, :null => false, :default => 0
      t.remove :class_number
      t.remove :class_string
      t.remove :dept
      t.remove :desc
      t.remove :name
    end
  end

  def down
    drop_table :courses

    change_table :sections do |t|
      t.remove_references :course
      t.integer :class_number
      t.string :class_string
      t.string :dept
      t.text :desc, :null => true
      t.string :name
    end
  end
end

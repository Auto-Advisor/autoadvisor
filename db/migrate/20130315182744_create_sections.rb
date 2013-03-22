class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :spire_id
      t.string :dept
      t.integer :class_number
      t.string :class_string
      t.string :section_number
      t.boolean :primary
      t.string :instructor
      t.integer :size
      t.string :name
      t.text :description, :null => true
    end
  end
end

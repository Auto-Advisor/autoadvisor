class LetCreditReferenceCourse < ActiveRecord::Migration
  def up
    change_table :credits do |t|
      t.remove :name
      t.remove :dept
      t.remove :number
      t.references :course, :null => false, :default => 0
    end
  end

  def down
    change_table :credits do |t|
      t.string :name
      t.string :dept
      t.integer :number
      t.remove_references :course
    end
  end
end

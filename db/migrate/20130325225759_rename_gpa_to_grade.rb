class RenameGpaToGrade < ActiveRecord::Migration
  def up
  	rename_column :credits, :gpa, :grade
  end

  def down
  	rename_column :credits, :grade, :gpa
  end
end

class RenameDescriptionToDesc < ActiveRecord::Migration
  def up
    rename_column :sections, :description, :desc
  end

  def down
    rename_column :sections, :desc, :description
  end
end

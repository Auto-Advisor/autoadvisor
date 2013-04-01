class RenameTypeToTy < ActiveRecord::Migration
  def up
    rename_column :sections, :type, :ty
  end

  def down
    rename_column :sections, :ty, :type
  end
end

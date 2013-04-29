class CreateSectionsUsers < ActiveRecord::Migration
  def change
    create_table :sections_users, :id => false do |t|
      t.references :user
      t.references :section
    end

    add_index :sections_users, [:user_id, :section_id]
    add_index :sections_users, [:section_id, :user_id]
  end
end

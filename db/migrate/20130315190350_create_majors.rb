class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.string :degree
      t.string :dept
    end

    create_table :majors_users, :id => false do |t|
    	t.references :user
    	t.references :major
    end

    add_index :majors_users, [:user_id, :major_id]
    add_index :majors_users, [:major_id, :user_id]
  end
end

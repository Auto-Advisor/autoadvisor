class CreateSchedules < ActiveRecord::Migration
  def up
    create_table :schedules do |t|
      t.text :name
      t.references :user

      t.timestamps
    end

    create_table :schedules_sections, :id => false do |t|
      t.references :schedule
      t.references :section
    end

    add_index :schedules_sections, [:schedule_id, :section_id]
    add_index :schedules_sections, [:section_id, :schedule_id]

    add_column :users, :schedule_id, :integer, :null => true

    remove_index :sections_users, :column => [:section_id, :user_id]
    remove_index :sections_users, :column => [:user_id, :section_id]

    drop_table :sections_users
  end

  def down
    drop_table :schedules

    remove_index :schedules_sections, :schedule_id_and_section_id
    remove_index :schedules_sections, :section_id_and_schedule_id

    drop_table :schedules_sections

    remove_column :users, :schedule_id

    create_table :sections_users, :id => false do |t|
      t.references :user
      t.references :section
    end

    add_index :sections_users, [:user_id, :section_id]
    add_index :sections_users, [:section_id, :user_id]
  end
end

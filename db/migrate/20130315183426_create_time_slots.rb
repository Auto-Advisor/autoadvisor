class CreateTimeSlots < ActiveRecord::Migration
  def up
    create_table :time_slots do |t|
      t.string :days
      t.integer :beg_min
      t.integer :beg_hour
      t.integer :end_min
      t.integer :end_hour
    end

    change_table :sections do |t|
      t.references :time_slot
    end
  end

  def down
    drop_table :time_slots
    change_table :sections do |t|
      t.remove_references :time_slot
    end
  end
end

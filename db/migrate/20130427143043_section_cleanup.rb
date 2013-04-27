class SectionCleanup < ActiveRecord::Migration
  def up
    drop_table "credit_constraints"
    drop_table "time_slots"
    remove_column :sections, :time_slot_id
    remove_column :sections, :units

    add_column :sections, :days, :string, :null => false, :default => ""
    add_column :sections, :gened, :string, :null => false, :default => ""
    add_column :sections, :min_start, :integer, :null => false, :default => 0
    add_column :sections, :min_end, :integer, :null => false, :default => 0
    add_column :sections, :credit_min, :integer, :null => false, :default => 0
    add_column :sections, :credit_max, :integer, :null => false, :default => 0
  end

  def down
    create_table "credit_constraints", :force => true do |t|
      t.string   "field"
      t.string   "op"
      t.string   "value"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "time_slots", :force => true do |t|
      t.string  "days"
      t.integer "beg_min"
      t.integer "beg_hour"
      t.integer "end_min"
      t.integer "end_hour"
    end
    add_column :sections, :time_slot_id, :integer
    add_column :sections, :units, :default => "0", :null => false


    remove_column :sections, :credit_min
    remove_column :sections, :credit_max
    remove_column :sections, :days
    remove_column :sections, :gened
    remove_column :sections, :min_end
    remove_column :sections, :min_start
  end
end
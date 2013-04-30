class RemoveSingleScheduleFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :schedule_id
  end

  def down
    add_column :users, :schedule_id, :integer
  end
end

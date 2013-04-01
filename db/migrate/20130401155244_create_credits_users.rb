class CreateCreditsUsers < ActiveRecord::Migration
  def change
    create_table :credits_users do |t|
      t.references :credit
      t.references :user
    end

    add_index :credits_users, [:credit_id, :user_id]
    add_index :credits_users, [:user_id, :credit_id]
  end
end

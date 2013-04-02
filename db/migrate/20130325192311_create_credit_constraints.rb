class CreateCreditConstraints < ActiveRecord::Migration
  def change
    create_table :credit_constraints do |t|
      t.string :field
      t.string :op
      t.string :value

      t.timestamps
    end
  end
end

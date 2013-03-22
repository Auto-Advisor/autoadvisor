class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string :name
      t.string :year
      t.float :gpa
      t.string :dept
      t.string :number

      t.references :user
    end
  end
end

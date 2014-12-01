class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :city
      t.string :county
      t.string :state
      t.string :level
      t.text :notes

      t.timestamps null: false
    end
  end
end

class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :summary
      t.integer :start_year
      t.integer :end_year
      t.integer :start_month
      t.integer :end_month

      t.timestamps null: false
    end
  end
end

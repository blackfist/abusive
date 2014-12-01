class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :incident_id
      t.text :incident_summary
      t.integer :incident_year
      t.integer :incident_month
      t.integer :incident_day
      t.integer :reported_year
      t.integer :reported_month
      t.integer :reported_day
      t.text :notes

      t.timestamps null: false
    end
  end
end

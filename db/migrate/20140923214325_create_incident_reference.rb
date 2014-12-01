class CreateIncidentReference < ActiveRecord::Migration
  def change
    create_table :incident_references do |t|
      t.belongs_to :incident
      t.belongs_to :reference
      t.timestamps
    end
  end
end

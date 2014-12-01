class RemoveFieldsFromIncidents < ActiveRecord::Migration
  def change
    remove_column :incidents, :incident_day, :integer
    remove_column :incidents, :reported_day, :integer
    remove_column :incidents, :location_zip, :string
  end
end

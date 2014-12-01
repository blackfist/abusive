class AddLocationToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :location_state, :string
    add_column :incidents, :location_city, :string
    add_column :incidents, :location_county, :string
    add_column :incidents, :location_zip, :string
    add_column :incidents, :location_notes, :text
    add_column :incidents, :context, :string
  end
end

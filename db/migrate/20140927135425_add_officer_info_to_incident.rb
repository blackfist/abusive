class AddOfficerInfoToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :officer_count, :integer
    add_column :incidents, :officer_multiple_incident, :boolean
  end
end

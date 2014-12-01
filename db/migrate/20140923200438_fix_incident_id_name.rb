class FixIncidentIdName < ActiveRecord::Migration
  def change
    rename_column :incidents, :incident_id, :uuid
  end
end

class AddIncidentIdToReference < ActiveRecord::Migration
  def change
    add_column :references, :incident_id, :integer
    add_column :references, :publish_date, :date
  end
end

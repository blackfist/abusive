class RemoveNotesFromIncident < ActiveRecord::Migration
  def change
    remove_column :incidents, :notes
  end
end

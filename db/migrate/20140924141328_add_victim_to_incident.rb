class AddVictimToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :victim_count, :integer
    add_column :incidents, :victim_animal, :boolean
    add_column :incidents, :victim_notes, :text
  end
end

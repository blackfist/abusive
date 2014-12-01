class AddOutcomeDollarsToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :outcome_dollars, :integer
  end
end

class AddAbuseToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :abuse_force, :boolean
    add_column :incidents, :abuse_search, :boolean
    add_column :incidents, :abuse_misconduct, :boolean
    add_column :incidents, :abuse_intimidation, :boolean
    add_column :incidents, :abuse_sexual, :boolean
    add_column :incidents, :abuse_restrained, :boolean
    add_column :incidents, :abuse_notes, :text
  end
end

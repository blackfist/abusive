class AddStatetoContribution < ActiveRecord::Migration
  def change
    change_column :contributions, :summary, :text
    add_column :contributions, :location_state, :string
    add_column :contributions, :location_city, :string
  end
end

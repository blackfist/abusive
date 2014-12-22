class AddContributionToSource < ActiveRecord::Migration
  def change
    add_column :references, :contribution_id, :integer
  end
end

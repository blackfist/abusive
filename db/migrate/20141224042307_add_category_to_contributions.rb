class AddCategoryToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :category, :string
  end
end

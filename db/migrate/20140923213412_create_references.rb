class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :url
      t.date :date_accessed
      t.string :headline
      t.string :org_name

      t.timestamps null: false
    end
  end
end

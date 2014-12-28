class AddDepartmentToContribution < ActiveRecord::Migration
  def change
    add_column :contributions, :department_id, :integer
  end
end

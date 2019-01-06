class AddRateToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :estimate, :float, default: 100
  end
end

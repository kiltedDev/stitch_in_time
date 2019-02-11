class RemoveDefaultEstimateFromProjects < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:projects, :estimate, from: 100, to: nil)
  end
end

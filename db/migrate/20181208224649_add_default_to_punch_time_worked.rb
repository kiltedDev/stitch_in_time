class AddDefaultToPunchTimeWorked < ActiveRecord::Migration[5.1]
  def change
    change_column :punches, :time_worked, :integer, default: 0
  end
end

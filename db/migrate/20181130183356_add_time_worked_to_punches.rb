class AddTimeWorkedToPunches < ActiveRecord::Migration[5.1]
  def change
    add_column :punches, :time_worked, :integer, default: 0
  end
end

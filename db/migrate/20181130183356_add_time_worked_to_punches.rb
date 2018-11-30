class AddTimeWorkedToPunches < ActiveRecord::Migration[5.1]
  def change
    add_column :punches, :time_worked, :integer
  end
end

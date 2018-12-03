class AddLastPunchToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :last_punch, :datetime, default: Time.zone.now
  end
end

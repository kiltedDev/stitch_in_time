class CreatePunches < ActiveRecord::Migration[5.1]
  def change
    create_table :punches do |t|
      t.string :comment
      t.datetime :time_in
      t.datetime :time_out
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

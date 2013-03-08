class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :text
      t.boolean :active
      t.timestamps
    end
  end
end

class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :avatar_url
      t.timestamps
    end
  end
end

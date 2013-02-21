class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :username
      t.string :mail
      t.string :slug

      t.timestamps
    end
    add_index :users, :slug, unique: true
  end
end

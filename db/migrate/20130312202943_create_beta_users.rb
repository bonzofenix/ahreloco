class CreateBetaUsers < ActiveRecord::Migration
  def change
    create_table :beta_users do |t|
      t.string :username
      t.boolean :active
      t.string :email

      t.timestamps
    end
  end
end

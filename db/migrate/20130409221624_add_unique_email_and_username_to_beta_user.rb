class AddUniqueEmailAndUsernameToBetaUser < ActiveRecord::Migration
  def change
    add_index(:beta_users, :email, unique: true)
    add_index(:beta_users, :username, unique: true)
  end
end

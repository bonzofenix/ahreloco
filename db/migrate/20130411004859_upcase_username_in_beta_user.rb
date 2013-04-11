class UpcaseUsernameInBetaUser < ActiveRecord::Migration
  def up
    execute "UPDATE beta_users SET username= LOWER(username)"
  end

  def down
  end
end

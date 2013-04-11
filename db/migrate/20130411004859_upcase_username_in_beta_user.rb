class UpcaseUsernameInBetaUser < ActiveRecord::Migration
  def up
    execute "UPDATE beta_users SET email = LOWER(username)"
  end

  def down
  end
end

class CreateProgramsUsers < ActiveRecord::Migration
  def up
    create_table 'programs_users', :id => false do |t|
      t.references :user
      t.references :program
    end
  end
end

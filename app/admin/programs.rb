ActiveAdmin.register Program do
  form do |f|
    f.inputs "Programs" do
      f.input :name
      f.input :avatar_url
      f.input :users
      f.actions
    end
  end

  index do
    column :name
    column "Users" do |program|
      program.users.each do |p|
        p.username
      end
    end
    default_actions
  end
end

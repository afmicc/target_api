ActiveAdmin.register ContactAdmin do
  menu parent: 'Admin'
  config.per_page = [10, 50, 100]

  actions :index, :show

  index do
    id_column
    column :email
    column :message
    actions
  end

  filter :email
  filter :message
end

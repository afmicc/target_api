ActiveAdmin.register Target do
  config.sort_order = 'topic_asc'
  config.per_page = [10, 50, 100]

  actions :index, :show

  index do
    id_column
    column :title
    column :topic
    column :area_lenght
    column :user
    column :created_at
    actions
  end

  filter :title
  filter :topic, as: :select
  filter :area_lenght, as: :numeric
  filter :user
  filter :user_name_cont, label: 'User Name'
  filter :created_at
end

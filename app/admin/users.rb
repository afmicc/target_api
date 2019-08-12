ActiveAdmin.register User do
  config.sort_order = 'email_asc'
  config.per_page = [10, 50, 100]

  actions :index, :show

  index do
    id_column
    column :name
    column :gender
    column :email
    column :provider
    column :confirmed_at
    actions
  end

  filter :email
  filter :gender, as: :select
  filter :provider, as: :check_boxes, collection: proc { User.distinct.pluck(:provider) }
  filter :confirmed_at
end

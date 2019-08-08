ActiveAdmin.register Topic do
  permit_params :title
  config.sort_order = 'title_asc'

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  filter :title

  form do |f|
    f.inputs do
      f.input :title
    end
    f.actions
  end
end

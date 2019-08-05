ActiveAdmin.register GeneralInformation do
  menu parent: 'Admin'
  permit_params :key, :title, :text

  index do
    selectable_column
    id_column
    column :key
    column :title
    actions
  end

  filter :key
  filter :title
  filter :text

  form do |f|
    f.inputs do
      f.input :key
      f.input :title
      f.input :text
    end
    f.actions
  end
end

ActiveAdmin.register Notice do
  permit_params :title, :content

  index do
    selectable_column
    id_column
    column :title
    column :content
    actions
  end

  form do |f|
    f.inputs 'Notice Details' do
      f.input :title
      f.input :content
    end
    f.actions
  end
end

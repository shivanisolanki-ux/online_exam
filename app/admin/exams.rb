ActiveAdmin.register Exam do
  permit_params :user_id, :subject_id, :score

  index do
    selectable_column
    id_column
    column :user
    column :subject
    column :score
    actions
  end

  form do |f|
    f.inputs 'Exam Details' do
      f.input :user
      f.input :subject
      f.input :score
    end
    f.actions
  end
end

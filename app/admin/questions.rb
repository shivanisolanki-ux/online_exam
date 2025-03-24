ActiveAdmin.register Question do
  permit_params :subject_id, :question_text, :answer, :option1, :option2, :option3, :option4

  index do
    selectable_column
    id_column
    column :subject
    column :question_text
    column :answer
    actions
  end

  form do |f|
    f.inputs 'Question Details' do
      f.input :subject
      f.input :question_text
      f.input :answer
      f.input :option1
      f.input :option2
      f.input :option3
      f.input :option4
    end
    f.actions
  end
end

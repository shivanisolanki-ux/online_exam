ActiveAdmin.register Result do
  index do
    id_column
    column :admin_user
    column :exam
    column :total_questions
    column :correct_answers
    column :score do |result|
      "#{result.score}%"
    end
    actions
  end

  show do
    attributes_table do
      row :admin_user
      row :exam
      row :total_questions
      row :correct_answers
      row :score do |result|
        "#{result.score}%"
      end
    end
  end
end
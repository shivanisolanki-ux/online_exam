class ChangeExamIdToAllowNullInQuestions < ActiveRecord::Migration[8.0]
  def change
    change_column :questions, :exam_id, :integer, null: true
  end
end

class CreateExams < ActiveRecord::Migration[8.0]
  def change
    create_table :exams do |t|
      t.string :exam_title
      t.references :subject, null: false, foreign_key: true
      t.integer :total_score

      t.timestamps
    end
  end
end

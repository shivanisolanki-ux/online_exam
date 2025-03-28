class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.text :question_text   
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :correct_answer

      t.timestamps
    end
  end
end

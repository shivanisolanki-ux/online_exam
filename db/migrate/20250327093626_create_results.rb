class CreateResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.integer :score
      t.integer :total_questions
      t.integer :correct_answers

      t.timestamps
    end
  end
end

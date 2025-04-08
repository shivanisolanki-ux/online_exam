class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :exam_name
      t.boolean :status



      t.timestamps
    end
  end
end

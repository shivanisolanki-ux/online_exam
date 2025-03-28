class Result < ApplicationRecord
  belongs_to :admin_user
  belongs_to :exam

  def self.ransackable_associations(auth_object = nil)
    ["admin_user", "exam"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["admin_user_id", "correct_answers", "created_at", "exam_id", "id", "id_value", "score", "total_questions", "updated_at"]
  end
end

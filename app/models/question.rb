class Question < ApplicationRecord
  belongs_to :subject
  belongs_to :exam
  
  def self.ransackable_attributes(auth_object = nil)
    ["correct_answer", "created_at","id", "option_a", "option_b", "option_c", "option_d", "question_text", "subject_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["subject","exam"]
  end
end

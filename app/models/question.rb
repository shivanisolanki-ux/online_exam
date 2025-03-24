class Question < ApplicationRecord
  belongs_to :subject
  def self.ransackable_attributes(auth_object = nil)
    ["answer", "created_at", "id", "option1", "option2", "option3", "option4", "question_text", "subject_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["subject"]
  end
end

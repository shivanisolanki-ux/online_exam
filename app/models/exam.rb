class Exam < ApplicationRecord
  # belongs_to :user
  belongs_to :subject
  has_many :questions
  

  def self.ransackable_associations(auth_object = nil)
    ["exam_title", "subject", "questions", "total_score"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "exam_title","total_score", "subject_id", "updated_at"]
  end
end

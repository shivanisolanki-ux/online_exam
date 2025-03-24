class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  def self.ransackable_associations(auth_object = nil)
    ["subject", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "score", "subject_id", "updated_at", "user_id"]
  end
end

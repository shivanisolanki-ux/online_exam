class Subject < ApplicationRecord
  has_many :questions
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["questions"]
  end
end

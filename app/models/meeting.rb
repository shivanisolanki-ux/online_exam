class Meeting < ApplicationRecord
  belongs_to :admin_user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "title", "updated_at", "user_id"]
  end
end

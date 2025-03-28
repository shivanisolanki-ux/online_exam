class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Role-based enum
  enum :role, [ :student, :admin ]

  has_many :exams
  has_many :meetings

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :student
  end

  # Ransackable associations and attributes should not take arguments
  def self.ransackable_associations(_auth_object = nil)
    ["exams", "meetings"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end

  def active_for_authentication?
    super && (admin? || student?) # Allow students to log in
  end
end

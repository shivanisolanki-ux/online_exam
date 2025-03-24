class User < ApplicationRecord
  # Devise modules
  # devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Role-based enum
  # enum role: { student: 0, admin: 1 }

  has_many :exams
  has_many :meetings

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :student
  end
end

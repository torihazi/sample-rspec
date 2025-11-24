class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :description, presence: true

  belongs_to :user

  scope :search, ->(term) {
    where("LOWER(name) LIKE ?", "%#{term.downcase}%")
  }
end
class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :description, presence: true

  belongs_to :user
end
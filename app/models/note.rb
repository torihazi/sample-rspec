class Note < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :message, presence: true
end
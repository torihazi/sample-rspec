class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :projects, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end
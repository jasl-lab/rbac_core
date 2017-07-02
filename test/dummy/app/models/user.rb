class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end

class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy

  has_many :role_assignments, class_name: "RbacCore::Assignment", as: :subjectable
  has_many :roles, through: :role_assignments

  validates :name, presence: true
end

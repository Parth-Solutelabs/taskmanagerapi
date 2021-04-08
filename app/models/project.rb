class Project < ApplicationRecord
  belongs_to :organization

  validates :name, presence: true
  validates :description, presence: true
  validates :organization_id, presence: true

  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users, dependent: :destroy
  has_many :tasks, through: :project_users
  
end

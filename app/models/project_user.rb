class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :project_id,presence: true
  validates :user_id, presence: true

  has_many :tasks, dependent: :destroy
end

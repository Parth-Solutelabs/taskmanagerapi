class Task < ApplicationRecord
  belongs_to :project_users

  validates :description, presence: true
  validates :projects_user_id, presence: true
end

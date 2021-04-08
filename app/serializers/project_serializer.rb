class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users, dependent: :destroy
  has_many :tasks, through: :project_users
end

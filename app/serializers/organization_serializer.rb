class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :contact, :password
  has_many :projects, serializer: ProjectSerializer
  
end

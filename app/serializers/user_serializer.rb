class UserSerializer < ActiveModel::Serializer
  attributes :id,:contact,:name,:email,:password
end

class Organization < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :contact, length: {is: 10}, numericality: {only_integer: true}
  
  has_many :projects, dependent: :destroy
  has_many :users, dependent: :destroy


end

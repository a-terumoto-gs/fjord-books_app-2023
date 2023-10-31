class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :tasks, dependent:  :destroy
  validates :name, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/}
end

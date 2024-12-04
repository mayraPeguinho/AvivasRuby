class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :role

  validates :alias, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "no es un formato de email válido" }
  validates :tel, format: { with: /\A\+?\d*\z/, message: "solo puede contener números y el símbolo '+'", allow_blank: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

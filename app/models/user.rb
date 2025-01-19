class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :role

  validates :entry_date, presence: true
  validates :alias, presence: true, uniqueness: true, 
  format: { with: /\A[a-zA-Z0-9_-]{4,20}\z/, 
  message: "must be 4-20 characters long and can only " \
           "contain letters, numbers, hyphens, and underscores, without spaces" }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "not a valid format" }
  validates :tel, presence: true, format: { with: /\A\+?\d*\z/, message: "can only contain numbers and the '+' symbol", allow_blank: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

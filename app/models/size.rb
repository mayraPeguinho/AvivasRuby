class Size < ApplicationRecord
    has_many :products
    validates :name, presence: true, uniqueness: true, length: {  minimum:2,maximum: 20 },            format: { with: /\A[a-zA-Z\s\-']+\z/, message: "only allows letters, spaces, hyphens, and apostrophes" }
end

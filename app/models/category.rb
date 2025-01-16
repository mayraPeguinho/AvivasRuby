class Category < ApplicationRecord
    has_many :products
    validates :name, presence: true, uniqueness: true,length: {  minimum:2,maximum: 20 }
end

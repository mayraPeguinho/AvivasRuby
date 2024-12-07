class Color < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end

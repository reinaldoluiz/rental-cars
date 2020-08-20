class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, presence: true
    validates :cnpj, uniqueness: true
end

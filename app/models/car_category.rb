class CarCategory < ApplicationRecord
  has_many :car_models
  validates :name, :daily_rate, :car_insurance, :third_party_insurance, presence: {message: 'não pode ficar em branco'}
  validates :name, uniqueness: true
end

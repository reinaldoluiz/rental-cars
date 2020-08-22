class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_must_be_a_valid_number

  private
  def cnpj_must_be_a_valid_number
    if cnpj.present? && !CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'não é válido')
    end
  end
end

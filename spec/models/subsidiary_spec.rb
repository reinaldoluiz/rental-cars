require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em '\
                                                      'branco')
      expect(subsidiary.errors[:address])
        .to include('não pode ficar em branco')
    end

    it 'CNPJ must be uniq' do
      Subsidiary.create!(name: 'Itu', cnpj:'36.526.495/0001-34', address:'Rua dos anjos')
      subsidiary = Subsidiary.new(cnpj: '36.526.495/0001-34')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end
  end
end
  
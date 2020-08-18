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

    it 'name must be uniq' do
      Subsidiary.create!(name: 'Itu', cnpj:'32265659898', address:'Rua dos anjos')
      subsidiary = Subsidiary.new(cnpj: '32265659898')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end
  end
end
  
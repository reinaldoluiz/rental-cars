require 'rails_helper'

describe Client, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      client = Client.new

      client.valid?

      expect(client.errors[:name]).to include('não pode ficar em branco')
      expect(client.errors[:daily_rate]).to include('não pode ficar em '\
                                                      'branco')
      expect(client.errors[:third_party_insurance])
        .to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      Client.create!(name: 'Fulano Sicrano', cpf:'023.517.305-34', email:'teste@teste.com')
      client = Client.new(cpf:'023.517.305-34')

      client.valid?

      expect(client.errors[:cpf]).to include('já está em uso')
    end
  end
end

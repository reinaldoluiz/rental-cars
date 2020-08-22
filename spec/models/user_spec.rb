require 'rails_helper'

describe User, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      user = User.new

      user.valid?

      expect(user.errors[:name]).to include('não pode ficar em branco')
      expect(user.errors[:email]).to include('não pode ficar em branco')

    end

    it 'email must be uniq' do
      User.create!(name: 'Teste', email:'teste@teste.com', password: '12345646')
      user = User.new(email: 'teste@teste.com')

      user.valid?

      expect(user.errors[:email]).to include('já está em uso')
    end
  end
end
  
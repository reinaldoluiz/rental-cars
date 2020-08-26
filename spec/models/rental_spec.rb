require 'rails_helper'

describe Rental, type: :model do
  context 'token' do 
    it 'generate on create' do 
      client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf:'893.203.383-88')
      car_category = CarCategory.create!(name:'A', daily_rate: 1, car_insurance:1, third_party_insurance: 1)
      user = User.create!(email:'users@test.com', password: '12345678', name: 'Sicrano Fulano')
      rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user)
    
      rental.save
      rental.reload

      expect(rental.token).to be_present
      expect(rental.token.size).to eq(6)
      expect(rental.token).to match(/^[A-Z0-9]+$/) 
    end
    xit 'must be unique'do
    end
  end
  context 'validation' do
    it 'attributes cannot be blank' do
      rental = Rental.new

      rental.valid?

      expect(rental.errors[:name]).to include('não pode ficar em branco')
      expect(rental.errors[:start_date]).to include('não pode ficar em '\
                                                      'branco')
      expect(rental.errors[:end_date])
        .to include('não pode ficar em branco')
    end
  end
end

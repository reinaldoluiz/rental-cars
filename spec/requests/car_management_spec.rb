require 'rails_helper'

describe 'Car management' do 
  context 'index' do 
    it 'renders available cars' do 
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance:100, third_party_insurance: 100)
      car_model = CarModel.create!(name: 'Onix 1.0', year: 2019, manufacturer: 'Chevrolet', fuel_type: 'Flex', car_category: car_category, motorization: '1.0')
      Car.create!(license_plate:'ABC1234', color: 'Vermelho',mileage: 1000 , car_model: car_model, status: :available)
      Car.create!(license_plate:'DEF1234', color: 'Preto',mileage: 1000 , car_model: car_model, status: :available)
      Car.create!(license_plate:'GHI1234', color: 'Preto',mileage: 1000 , car_model: car_model, status: :rented)

      get '/api/v1/cars'

      expect(response).to have_http_status(200)
      expect(response.body).to include('ABC1234')
      expect(response.body).to include('DEF1234')
      expect(response.body).to_not include('GHI1234')
    end
  end
end
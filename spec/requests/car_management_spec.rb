require 'rails_helper'

describe 'Car management' do 
  context 'index' do 
    it 'renders available cars' do 
      car_model = create(:car_model)
      create(:car, license_plate: 'ABC1234', color: 'Vermelho', car_model: car_model, status: :available)
      create(:car, license_plate: 'DEF1234', color: 'Vermelho', car_model: car_model, status: :available)
      create(:car, license_plate: 'GHI1234', color: 'Vermelho', car_model: car_model, status: :rented)
      

      get '/api/v1/cars'

      expect(response).to have_http_status(200)
      expect(response.body).to include('ABC1234')
      expect(response.body).to include('DEF1234')
      expect(response.body).to_not include('GHI1234')
    end

    it 'renders empty json' do 
      get api_v1_cars_path

      response_json = JSON.parse(response.body)
      expect(response).to be_ok
      expect(response.content_type).to include('application/json')
      expect(response_json).to be_empty
    end
  end
  
  context 'GET /api/v1/car/:id' do 
    context 'record exist' do 
      let(:car) do 
        create(:car, license_plate: 'ABC1234', color:'Vermelho', status: :available)
      end
      
      it 'returns car' do 
        car = create(:car, license_plate: 'ABC1234', color:'Vermelho', status: :available)
        
        get api_v1_car_path(id: car.id)

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_ok
        expect(response_json[:license_plate]).to eq(car.license_plate)
        expect(response_json[:color]).to eq(car.color)
       
  
      end
    end  
    context 'record not exist' do 
      it 'return status code 404' do 
        get '/api/v1/cars/000'
        expect(response).to be_not_found
      end
      it 'return not found message' do 
        get '/api/v1/cars/000'

        expect(response.body).to include('Carro não encontrado')
      end
    end
  end

  context 'POST /cars' do 
    context 'with valid parameters' do 
      let(:car_model){create(:car_model)}
      let(:attributes) { attributes_for(:car, car_model_id: car_model.id) }
      
      it 'returns 201 status' do 
        post '/api/v1/cars', params: {car: attributes}

        expect(response).to be_created
      end

      it 'creates a car' do 
        post '/api/v1/cars', params: {car: attributes}

        car = JSON.parse(response.body, symbolize_names: true)
        expect(car[:id]).to be_present
        expect(car[:license_plate]).to eq(attributes[:license_plate])
        expect(car[:color]).to eq(attributes[:color])
        
      end
    end
  end 
  context 'with invalid params' do 
    it 'without car key' do 
      post '/api/v1/cars'
      
      expect(response).to have_http_status(:precondition_failed)
    end
    it 'without requested params' do 
      post '/api/v1/cars', params: {car:{foo:'bar'}}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Placa não pode ficar em branco')
      expect(response.body).to include('Cor não pode ficar em branco')
      expect(response.body).to include('Modelo de carro é obrigatório(a)')
    end
  end
end
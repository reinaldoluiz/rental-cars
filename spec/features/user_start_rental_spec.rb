require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers
feature 'User start rental' do 
  scenario 'view only category cars' do 
    schedule_user = User.create!(email:'users@test.com', password: '12345678', name: 'Sicrano Fulano')
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf:'893.203.383-88')
    car_category_a = CarCategory.create!(name:'A', daily_rate: 100, car_insurance:1, third_party_insurance: 30)
    car_category_especial = CarCategory.create!(name:'Especial', daily_rate: 500, car_insurance:1, third_party_insurance: 300)
    model_ka = CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                  car_category: car_category_a, fuel_type:'Flex')
    model_fusion = CarModel.create!(name:'Fusion', year:2020, manufacturer:'Ford', motorization:'2.0',
                                  car_category: car_category_especial, fuel_type:'Elétrico')
    user = User.create!(email:'another@test.com', password: '12345678', name: 'Outra Pessoa')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category_a, user: user) 
    car = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: model_ka, mileage:0)
    car_fusion = Car.create!(license_plate: 'XVC123', color: 'Azul', car_model: model_fusion, mileage:0)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    
    expect(page).to have_content('Ka')
    expect(page).to have_content('Prata')
    expect(page).to have_content('ABC123')
    expect(page).not_to have_content('Fusion')
    expect(page).not_to have_content('Azul')
    expect(page).not_to have_content('XVC123')
  end
  scenario 'sucessfully' do 
    schedule_user = User.create!(email:'users@test.com', password: '12345678', name: 'Sicrano Fulano')
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf:'893.203.383-88')
    car_category = CarCategory.create!(name:'A', daily_rate: 100, car_insurance:1, third_party_insurance: 30)
    car_model = CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    user = User.create!(email:'another@test.com', password: '12345678', name: 'Outra Pessoa')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: schedule_user) 
    car = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: car_model, mileage:0)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponíveis'
    fill_in 'CNH do Condutor', with: 'RJ200100-10'
    travel_to Time.zone.local(2020,10,01,12,30,45) do
      click_on 'Iniciar'
    end
    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(client.email)
    expect(page).to have_content(schedule_user.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content('RJ200100-10')
    expect(page).not_to have_link('Iniciar locação')
    expect(page).to have_content('01 de outubro de 2020, 12:30:45')
  end
end
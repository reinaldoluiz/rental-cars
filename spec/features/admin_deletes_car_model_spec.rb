require 'rails_helper'

feature 'Admin deletes Car Model' do
  scenario 'must be signed in' do 
    
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end
  scenario 'sucessfully' do 
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,third_party_insurance:200)
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex') 
    
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    login_as(user, scope: :user) 

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka'
    click_on 'Apagar'

    expect(current_path).to eq car_models_path
    expect(page).to have_content('Nenhum modelo cadastrado')                  
  end

  scenario 'and keep anothers' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,third_party_insurance:200)
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    CarModel.create!(name:'Gol', year:2009, manufacturer:'Ferrari', motorization:'1.0',
    car_category: car_category, fuel_type:'Flex')
    
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka'
    click_on 'Apagar'

    expect(current_path).to eq car_models_path
    expect(page).not_to have_content('Ka')
    expect(page).to have_content('Gol')
  end

end
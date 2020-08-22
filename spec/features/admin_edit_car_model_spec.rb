require 'rails_helper'

feature 'Admin edit Car Model' do
  scenario 'must be signed in' do 
    #Arrange

    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path 
  end
  
  scenario 'sucessfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5) 
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    
    user = User.create!(name:'João Almeida', email:'jo@email.com', password:'12345678')
    user_login()
    visit root_path
    click_on 'Modelos de carros'
    click_on 'Ka - 2019'
    click_on 'Editar'
    fill_in 'Nome', with: 'Ka2'
    fill_in 'Ano', with: '2020'
    fill_in 'Fabricante', with: 'Ford2'
    fill_in 'Motorização', with: '1.2'
    select 'Top', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Flex2'
    click_on 'Enviar'

    expect(page).to have_content('Ka2')
    expect(page).to have_content('2020')
    expect(page).to have_content('Ford2')
    expect(page).to have_content('1.2')
    expect(page).to have_content('Top')
    expect(page).to have_content('Flex2')
  end

  scenario 'and keep anothers' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    CarModel.create!(name:'Golf', year:2005, manufacturer:'Renault', motorization:'1.0',
    car_category: car_category, fuel_type:'Flex')

    user = User.create!(name:'João Almeida', email:'joo@email.com', password:'12345678')
    
    login_as(user, scope: :user)

    visit root_path
    click_on 'Modelos de carros'
    click_on 'Ka - 2019'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Fabricante', with: ''
    fill_in 'Motorização', with: ''
    fill_in 'Tipo de combustível', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

end
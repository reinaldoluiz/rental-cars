require 'rails_helper'

feature 'Admin edit Car Model' do
  
  scenario 'sucessfully' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5) 
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Ka - 2019'
    click_on 'Editar'
    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '32545646546'
    fill_in 'Endereço', with: 'Avenida Paulista'
    click_on 'Enviar'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('32545646546')
    expect(page).to have_content('Avenida Paulista')
  end

  scenario 'and keep anothers' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    CarModel.create!(name:'Golf', year:2005, manufacturer:'Renault', motorization:'1.0',
    car_category: car_category, fuel_type:'Flex')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

end
require 'rails_helper'

feature 'Admin searches rental' do
  scenario 'and find exact match' do
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf:'893.203.383-88')
    car_category = CarCategory.create!(name:'A', daily_rate: 1, car_insurance:1, third_party_insurance: 1)
    user = User.create!(email:'users@test.com', password: '12345678', name: 'Sicrano Fulano')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user) 
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user) 

    login_as user, scope: :user 
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).not_to have_content(another_rental.token)
    expect(page).to have_content(rental.client.name)
    expect(page).to have_content(rental.client.email)
    expect(page).to have_content(rental.client.cpf)
    expect(page).to have_content(rental.user.email)
    expect(page).to have_content(rental.car_category.name)
  end
  
  xscenario 'and finds nothing' do 
  
  end
  
  scenario 'finds by partial token' do 
    client = Client.create!(name: 'Fulano Sicrano', email: 'client@test.com', cpf:'893.203.383-88')
    car_category = CarCategory.create!(name:'A', daily_rate: 1, car_insurance:1, third_party_insurance: 1)
    user = User.create!(email:'users@test.com', password: '12345678', name: 'Sicrano Fulano')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user) 
    rental.update(token: 'ABC123')
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user) 
    another_rental.update(token: 'ABC567')
    rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user) 
    rental_not_to_be_found.update(token: '4865656')
    login_as user, scope: :user 
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).to have_content(another_rental.token)
    expect(page).not_to have_content(rental_not_to_be_found.token)
  end 
end
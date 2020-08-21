require 'rails_helper'

feature 'Admin register car category' do

  scenario 'must be signed in' do 
    #Arrange

    #Act
    visit root_path
    click_on 'Categorias'

    #Assert
    expect(current_path).to eq new_user_session_path 
  end

  scenario 'from index page' do
    user_login()

    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Registrar uma nova categoria',
                              href: new_car_category_path)
  end

  scenario 'successfully' do
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'

    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last)
    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_link('Voltar')
  end
end

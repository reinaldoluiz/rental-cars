require 'rails_helper'

feature 'Admin register subsidiary' do 
  scenario 'must be signed in' do 
    #Arrange

    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path 
  end
  
  scenario 'from index page' do 
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_link('Registrar uma nova filial', 
    href:new_subsidiary_path )
  end
  scenario 'Sucessfully' do 
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    
    fill_in 'Nome', with: 'Rio'
    fill_in 'CNPJ', with: '75.823.020/0001-61'
    fill_in 'Endereço', with: 'Rua das Palmeiras'
    click_on 'Enviar'
    
    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Rio')
    expect(page).to have_content('75.823.020/0001-61')
    expect(page).to have_content('Rua das Palmeiras')
    expect(page).to have_link('Voltar')
  end
end
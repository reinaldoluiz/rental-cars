require 'rails_helper'

feature 'Admin edits Subsidiary' do
  scenario 'must be signed in' do 
    #Arrange

    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path 
  end
  scenario 'sucessfully' do 
    Subsidiary.create!(name:'SaoPaulo', cnpj:'32545646546', address:'Avenida Paulista')
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'SaoPaulo'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'CNPJ', with: '545646546'
    fill_in 'Endereço', with: 'Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Paulo')
    expect(page).to have_content('545646546')
    expect(page).to have_content('Paulista')
  end

  scenario 'and keep anothers' do
    Subsidiary.create!(name:'São Paulo', cnpj:'32545646546', address:'Avenida Paulista')
    Subsidiary.create!(name:'Rio', cnpj:'5456465456', address:'Avenida Paulista')
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)

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
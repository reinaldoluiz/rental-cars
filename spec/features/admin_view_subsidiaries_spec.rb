require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'must be signed in' do 
    #Arrange

    #Act
    visit root_path
    click_on 'Filiais'

    #Assert
    expect(current_path).to eq new_user_session_path 
  end
  scenario 'successfully' do
    #Arrange -> Preparação dos Dados
    Subsidiary.create!(name: 'Itu', cnpj:'33.765.516/0001-86', address:'Rua dos anjos')
    Subsidiary.create!(name: 'Para', cnpj:'11.830.446/0001-60', address:'Avenida dos anjos')
    Subsidiary.create!(name: 'Mogi', cnpj:'89.679.603/0001-75', address:'Praça dos anjos')
    #Act -> Executar o código
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_content('Itu')
    expect(page).to have_content('Para')

  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Itu', cnpj:'33.765.516/0001-86', address:'Rua dos anjos')
    Subsidiary.create!(name: 'Para', cnpj:'11.830.446/0001-60', address:'Avenida dos anjos')
    Subsidiary.create!(name: 'Mogi', cnpj:'89.679.603/0001-75', address:'Praça dos anjos')
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Itu'
    
    expect(page).to have_content('Itu')
    expect(page).to have_content('33.765.516/0001-86')
    expect(page).to have_content('Rua dos anjos')
    expect(page).not_to have_content('Para')
    expect(page).not_to have_content('Mogi')
  end

  scenario 'and no subsidiary are created' do
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Itu', cnpj:'33.765.516/0001-86', address:'Rua dos anjos')
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
    
  end

  scenario 'and return to manufacturers page' do
    Subsidiary.create!(name: 'Itu', cnpj:'33.765.516/0001-86', address:'Rua dos anjos')
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Itu'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
   
  end
end

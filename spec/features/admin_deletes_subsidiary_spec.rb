require 'rails_helper'

feature 'Admin deletes Subsidiary' do
  scenario 'must be signed in' do 
    
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
  end
  scenario 'sucessfully' do 

    Subsidiary.create!(name: 'Itu', cnpj:'36.526.495/0001-34', address:'Rua dos anjos')

    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Filiais'
    click_on 'Itu'
    click_on 'Apagar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Nenhuma filial cadastrada')


  end

  scenario 'and keep anothers' do
    Subsidiary.create!(name: 'Itu', cnpj:'36.526.495/0001-34', address:'Rua dos anjos')
    Subsidiary.create!(name: 'São Paulo', cnpj:'33.765.516/0001-86', address:'Rua do Carmo')
    
    user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Filiais'
    click_on 'Itu'
    click_on 'Apagar'

    expect(current_path).to eq subsidiaries_path
    expect(page).not_to have_content('Itu')
    expect(page).to have_content('São Paulo')
  end

end
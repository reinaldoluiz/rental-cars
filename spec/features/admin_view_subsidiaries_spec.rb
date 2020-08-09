require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    #Arrange -> Preparação dos Dados
    Subsidiary.create!(name: 'Itu', cnpj:'32265659898', address:'Rua dos anjos')
    Subsidiary.create!(name: 'Para', cnpj:'65659898454', address:'Avenida dos anjos')
    Subsidiary.create!(name: 'Mogi', cnpj:'22656598982', address:'Praça dos anjos')
    #Act -> Executar o código
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_content('Itu')
    expect(page).to have_content('Para')

  end

  scenario 'and view details' do
    
  end

  scenario 'and no car categories are created' do
    
  end

  scenario 'and return to home page' do
    
  end

  scenario 'and return to manufacturers page' do
   
  end
end

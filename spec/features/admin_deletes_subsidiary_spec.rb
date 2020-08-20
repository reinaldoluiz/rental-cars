require 'rails_helper'

feature 'Admin deletes Car Model' do
  
  scenario 'sucessfully' do 

    Subsidiary.create!(name: 'Itu', cnpj:'32265659898', address:'Rua dos anjos')

    visit root_path
    click_on 'Filiais'
    click_on 'Itu'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Nenhuma filial cadastrada')


  end

  scenario 'and keep anothers' do
    Subsidiary.create!(name: 'Itu', cnpj:'32265659898', address:'Rua dos anjos')
    Subsidiary.create!(name: 'São Paulo', cnpj:'878265659898', address:'Rua do Carmo')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Itu'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Itu')
    expect(page).to have_content('São Paulo')
  end

end
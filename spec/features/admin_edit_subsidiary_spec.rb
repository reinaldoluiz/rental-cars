require 'rails_helper'

feature 'Admin edits Subsidiary' do
  
  scenario 'sucessfully' do 
    Subsidiary.new(name:'São Paulo', cnpj:'32545646546', address:'Avenida Paulista')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
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
    Subsidiary.new(name:'São Paulo', cnpj:'32545646546', address:'Avenida Paulista')
    Subsidiary.new(name:'Rio', cnpj:'5456465456', address:'Avenida Paulista')

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
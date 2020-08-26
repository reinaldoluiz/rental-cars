require 'rails_helper'

feature 'Admin schedule rental' do
    scenario 'sucessfully' do 
        CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance:100)
        Client.create!(name: 'Fulano Sicrano', cpf:'023.517.305-34', email:'teste@teste.com')
        user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
        click_on 'Agendar nova locação'
        fill_in 'Data de início', with: '21/08/2030'
        fill_in 'Data de término', with: '23/08/2030'
        select 'Fulano Sicrano - 023.517.305-34', from: 'Cliente'
        select 'A', from: 'Categoria de carro'
        click_on 'Agendar'

        expect(page).to have_content('21/08/2030')
        expect(page).to have_content('23/08/2030')
        expect(page).to have_content('Fulano Sicrano')
        expect(page).to have_content('023.517.305-34')
        expect(page).to have_content('teste@teste.com')
        expect(page).to have_content('A')
        expect(page).to have_content('Agendamento realizado com sucesso!')
        expect(page).to have_content('R$ 600,00')
    end

    scenario 'must fill in all fields' do 
        CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance:100)
        user = User.create!(name:'João Almeida', email:'joao@email.com', password:'12345678')
    
        login_as(user, scope: :user)
        click_on 'Locações'
        click_on 'Agendar nova locação'
        fill_in 'Data de início', with: '21/08/2030'
        fill_in 'Data de término', with: '23/08/2030'
        select 'Fulano Sicrano - 023.517.305-34', from: 'Cliente'
        select 'A', from: 'Categoria de carro'
        click_on 'Agendar'

        expect(page).to have_content('Data de início não pode ficar em branco')
        expect(page).to have_content('Data de término não pode ficar em branco')
    end

    scenario 'must be logged in to schedule rental' do 
        
        visit new_rental_path

        expect(current_path).to eq new_user_session_path
    end
end
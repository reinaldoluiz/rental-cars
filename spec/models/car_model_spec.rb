require 'rails_helper'

describe CarModel, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      carmodel = CarModel.new

      carmodel.valid?

      expect(carmodel.errors[:name]).to include('não pode ficar em branco')
      expect(carmodel.errors[:year]).to include('não pode ficar em branco')
      expect(carmodel.errors[:manufacturer]).to include('não pode ficar em branco')
      expect(carmodel.errors[:motorization]).to include('não pode ficar em branco')
      expect(carmodel.errors[:fuel_type]).to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,third_party_insurance:200)
      CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
      carmodel = CarModel.new(name:'Ka', year:2019)

      carmodel.valid?

      expect(carmodel.errors[:name, :year]).to include('já está em uso')
    end
  end
end
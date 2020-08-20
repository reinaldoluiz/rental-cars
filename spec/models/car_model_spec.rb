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
  end
end
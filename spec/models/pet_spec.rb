require "rails_helper"

require_relative '../../app/models/pet'

RSpec.describe Pet do
  describe '#initialize' do
    it 'sets the attributes correctly' do
      pet = Pet.new(id: 1, type: 'generic', tracker_type: 'unknown', owner_id: 42, in_zone: true)
      expect(pet.id).to eq(1)
      expect(pet.type).to eq('generic')
      expect(pet.tracker_type).to eq('unknown')
      expect(pet.owner_id).to eq(42)
      expect(pet.in_zone).to be true
      expect(pet.errors).to eq([])
    end
  end

  describe '#to_h' do
    it 'returns a hash of attributes' do
      pet = Pet.new(id: 1, type: 'generic', tracker_type: 'unknown', owner_id: 42, in_zone: true)
      expect(pet.to_h).to eq({
        id: 1,
        type: 'generic',
        tracker_type: 'unknown',
        owner_id: 42,
        in_zone: true
      })
    end
  end
end

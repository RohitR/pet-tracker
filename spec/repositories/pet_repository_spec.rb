require 'rails_helper'

RSpec.describe PetRepository do
  let(:repository) { PetRepository.new }

  describe '#all' do
    it 'delegates to InMemoryPetStore.all' do
      expect(InMemoryPetStore).to receive(:all).and_call_original
      repository.all
    end
  end

  describe '#where' do
    it 'filters pets by conditions' do
      InMemoryPetStore.create(type: 'cat', tracker_type: 'small', owner_id: 1)
      InMemoryPetStore.create(type: 'dog', tracker_type: 'medium', owner_id: 6)
      InMemoryPetStore.create(type: 'cat', tracker_type: 'big', owner_id: 2)

      result = repository.where(type: 'cat')
      expect(result).to be_an_instance_of(InMemoryQuery)
      expect(result.to_a.map(&:tracker_type)).to include('small', 'big')
      expect(result.to_a.map(&:tracker_type)).not_to include('medium')
    end
  end

  describe '#create' do
    it 'delegates pet creation to InMemoryPetStore' do
      pet_params = { type: 'dog', tracker_type: 'small', owner_id: 4 }
      expect(InMemoryPetStore).to receive(:create).with(pet_params).and_call_original
      pet = repository.create(pet_params)
      expect(pet.tracker_type).to eq('small')
    end
  end
end

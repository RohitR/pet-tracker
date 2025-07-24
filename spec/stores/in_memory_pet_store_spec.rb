require 'rails_helper'

RSpec.describe InMemoryPetStore do
  describe '.all' do
    it 'returns an InMemoryQuery with all pets' do
      InMemoryPetStore.create(type: 'cat', tracker_type: 'big', owner_id: 2)
      InMemoryPetStore.create(type: 'dog', tracker_type: 'small', owner_id: 5)

      result = InMemoryPetStore.all
      expect(result).to be_an_instance_of(InMemoryQuery)
      expect(result.to_a.map(&:tracker_type)).to include('big', 'small')
    end
  end

  describe '.create' do
    context 'when valid pet params are provided' do
      it 'creates and stores a Cat instance' do
        pet = InMemoryPetStore.create(type: 'cat', tracker_type: 'big', owner_id: 3)
        expect(pet).to be_a(Cat)
        expect(pet.errors).to be_empty
        expect(InMemoryPetStore.all.to_a).to include(pet)
      end

      it 'creates and stores a Dog instance' do
        pet = InMemoryPetStore.create(type: 'dog', tracker_type: 'small', owner_id: 4)
        expect(pet).to be_a(Dog)
        expect(pet.errors).to be_empty
        expect(InMemoryPetStore.all.to_a).to include(pet)
      end
    end

    context 'when an unknown pet type is provided' do
      it 'returns an object with errors' do
        pet = InMemoryPetStore.create(type: 'bird', tracker_type: 'small', owner_id: 1)
        expect(pet.errors).to include('Unknown pet type: bird')
      end
    end

    context 'when an exception is raised during creation' do
      before do
        allow_any_instance_of(InMemoryPetStore.singleton_class).to receive(:build_pet).and_raise(StandardError.new("boom"))
      end

      it 'returns an object with errors' do
        pet = InMemoryPetStore.create(type: 'cat', name: 'ErrorCat')
        expect(pet.errors).to include('boom')
      end
    end
  end
end

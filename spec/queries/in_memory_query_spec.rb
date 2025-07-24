require 'rails_helper'

RSpec.describe InMemoryQuery do
  let(:data) do
    [
      double('Cat', tracker_type: 'big', type: 'cat', owner_id: 2),
      double('Dog', tracker_type: 'small', type: 'dog', owner_id: 5),
      double('Cat', tracker_type: 'medium', type: 'cat', owner_id: 3)
    ]
  end

  subject { described_class.new(data) }

  describe '#where' do
    it 'filters the data with matching attribute values' do
      cats = subject.where(type: 'cat')
      expect(cats.to_a.size).to eq(2)
      expect(cats.to_a.map(&:tracker_type)).to contain_exactly('big', 'medium')

      older_pets = subject.where(owner_id: 5)
      expect(older_pets.to_a.map(&:tracker_type)).to eq([ 'small' ])
    end

    it 'returns a new InMemoryQuery with filtered results' do
      cats = subject.where(type: 'cat')
      expect(cats).to be_an_instance_of(InMemoryQuery)
      expect(cats.object_id).not_to eq(subject.object_id)
    end

    it 'returns empty result if no matches' do
      result = subject.where(tracker_type: 'Nonexistent')
      expect(result.to_a).to be_empty
      expect(result.count).to eq(0)
    end
  end

  describe '#to_a' do
    it 'returns the underlying data array' do
      expect(subject.to_a).to eq(data)
    end
  end

  describe '#count' do
    it 'returns number of items in the data' do
      expect(subject.count).to eq(data.size)
    end
  end
end

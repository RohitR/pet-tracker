require "rails_helper"

require_relative '../../app/models/dog'
require_relative '../../app/enums/tracker_type'

RSpec.describe Dog do
  let(:valid_tracker) { 'medium' }
  let(:invalid_tracker) { 'tiny' }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'sets attributes correctly including bark_volume accessor (default nil)' do
        dog = Dog.new(id: 1, tracker_type: valid_tracker, owner_id: 3, in_zone: true)
        expect(dog.id).to eq(1)
        expect(dog.type).to eq('dog')
        expect(dog.tracker_type).to eq(valid_tracker)
        expect(dog.owner_id).to eq(3)
        expect(dog.in_zone).to be true
        expect(dog.bark_volume).to be_nil
        expect(dog.errors).to be_empty
      end
    end

    context 'with invalid tracker_type' do
      it 'adds an error message' do
        dog = Dog.new(id: 2, tracker_type: invalid_tracker)
        expect(dog.errors).to include("Invalid tracker type for dog: #{invalid_tracker}. Valid types are: #{TrackerType.all_for('dog').join(', ')}")
      end
    end
  end

  describe '#to_h' do
    it "includes type 'dog' in the hash" do
      dog = Dog.new(id: 1, tracker_type: valid_tracker)
      expected_hash = {
        id: 1,
        type: 'dog',
        tracker_type: valid_tracker,
        owner_id: nil,
        in_zone: false
      }
      expect(dog.to_h).to eq(expected_hash)
    end
  end
end

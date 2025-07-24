require "rails_helper"
require_relative '../../app/models/cat'
require_relative '../../app/enums/tracker_type'

RSpec.describe Cat do
  let(:valid_tracker) { 'small' }
  let(:invalid_tracker) { 'giant' }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'sets attributes correctly including lost_tracker' do
        cat = Cat.new(id: 1, tracker_type: valid_tracker, owner_id: 5, in_zone: true, lost_tracker: true)
        expect(cat.id).to eq(1)
        expect(cat.type).to eq('cat')
        expect(cat.tracker_type).to eq(valid_tracker)
        expect(cat.owner_id).to eq(5)
        expect(cat.in_zone).to be true
        expect(cat.lost_tracker).to be true
        expect(cat.errors).to be_empty
      end
    end

    context 'with invalid tracker_type' do
      it 'adds an error message' do
        cat = Cat.new(id: 2, tracker_type: invalid_tracker)
        expect(cat.errors).to include("Invalid tracker type for cat: #{invalid_tracker}. Valid types are: #{TrackerType.all_for('cat').join(', ')}")
      end
    end
  end

  describe '#to_h' do
    it 'returns a hash including type and lost_tracker' do
      cat = Cat.new(id: 1, tracker_type: valid_tracker, lost_tracker: false)
      expected_hash = {
        id: 1,
        type: 'cat',
        tracker_type: valid_tracker,
        owner_id: nil,
        in_zone: false,
        lost_tracker: false
      }
      expect(cat.to_h).to eq(expected_hash)
    end
  end
end

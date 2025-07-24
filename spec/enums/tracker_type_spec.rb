require "rails_helper"

require_relative '../../app/enums/tracker_type'

RSpec.describe TrackerType do
  describe '.valid_for?' do
    context "when type is 'cat'" do
      it 'returns true for valid tracker types' do
        expect(TrackerType.valid_for?('cat', 'small')).to be true
        expect(TrackerType.valid_for?('cat', 'big')).to be true
      end

      it 'returns false for invalid tracker types' do
        expect(TrackerType.valid_for?('cat', 'medium')).to be false
        expect(TrackerType.valid_for?('cat', 'tiny')).to be false
      end
    end

    context "when type is 'dog'" do
      it 'returns true for valid tracker types' do
        expect(TrackerType.valid_for?('dog', 'small')).to be true
        expect(TrackerType.valid_for?('dog', 'medium')).to be true
        expect(TrackerType.valid_for?('dog', 'big')).to be true
      end

      it 'returns false for invalid tracker types' do
        expect(TrackerType.valid_for?('dog', 'giant')).to be false
      end
    end

    context 'when type is unknown' do
      it 'returns false' do
        expect(TrackerType.valid_for?('parrot', 'small')).to be false
      end
    end
  end

  describe '.all_for' do
    it "returns valid types array for 'cat'" do
      expect(TrackerType.all_for('cat')).to eq(%w[small big])
    end

    it "returns valid types array for 'dog'" do
      expect(TrackerType.all_for('dog')).to eq(%w[small medium big])
    end

    it 'returns empty array for unknown types' do
      expect(TrackerType.all_for('rabbit')).to eq([])
    end
  end
end

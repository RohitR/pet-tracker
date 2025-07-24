class Dog < Pet
  attr_accessor :bark_volume

  def initialize(id:, tracker_type:, owner_id: nil, in_zone: false)
    super(id: id, type: "dog", tracker_type: tracker_type, owner_id: owner_id, in_zone: in_zone)

    unless  TrackerType.valid_for?("dog", tracker_type)
      @errors << "Invalid tracker type for dog: #{tracker_type}. Valid types are: #{TrackerType.all_for('dog').join(', ')}"
    end
  end

  def to_h
    super.merge({ type: "dog" })
  end
end

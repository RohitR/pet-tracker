class Cat < Pet
  attr_accessor :lost_tracker
  def initialize(id:, tracker_type:, owner_id: nil, in_zone: false, lost_tracker: false)
    super(id: id, type: "cat", tracker_type: tracker_type, owner_id: owner_id, in_zone: in_zone)
    @lost_tracker = lost_tracker

    unless TrackerType.valid_for?("cat", tracker_type)
      @errors << "Invalid tracker type for cat: #{tracker_type}. Valid types are: #{TrackerType.all_for('cat').join(', ')}"
    end
  end

  def to_h
    super.merge({ type: "cat", lost_tracker: @lost_tracker })
  end
end

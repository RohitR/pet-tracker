class Pet
  attr_accessor :id, :type, :tracker_type, :owner_id, :in_zone, :errors

  def initialize(id:, type:, tracker_type:, owner_id: nil, in_zone: false)
    @id = id
    @type = type
    @tracker_type = tracker_type
    @owner_id = owner_id
    @in_zone = in_zone
    @errors = []
  end

  def to_h
    {
      id: @id,
      type: @type,
      tracker_type: @tracker_type,
      owner_id: @owner_id,
      in_zone: @in_zone
    }
  end
end

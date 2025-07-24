module TrackerType
  CAT_TYPES = %w[small big].freeze
  DOG_TYPES = %w[small medium big].freeze

  def self.valid_for?(type, tracker_type)
    case type
    when 'cat'
      CAT_TYPES.include?(tracker_type)
    when 'dog'
      DOG_TYPES.include?(tracker_type)
    else
      false
    end
  end

  def self.all_for(type)
    case type
    when 'cat'
      CAT_TYPES
    when 'dog'
      DOG_TYPES
    else
      []
    end
  end
end

class InMemoryQuery
  def initialize(data)
    @data = data
  end

  def where(conditions)
    filtered = @data.select do |item|
      conditions.all? { |key, value| (item.respond_to? key) && item.public_send(key) == value }
    end
    self.class.new(filtered)
  end

  def to_a
    @data
  end

  def count
    @data.size
  end
end

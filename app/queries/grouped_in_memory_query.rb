class GroupedInMemoryQuery
  def initialize(data, group_by)
    @data = data
    @group_by = group_by
  end

  def count
    counts = Hash.new(0)
    @data.each do |item|
      key = @group_by.map { |field| item.public_send(field) }
      counts[key] += 1
    end
    counts
  end
end

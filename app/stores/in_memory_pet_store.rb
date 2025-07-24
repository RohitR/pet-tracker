class InMemoryPetStore
  @pets = {}
  @id_sequence = 0

  class << self
    def all
      InMemoryQuery.new(@pets.values)
    end

    def create(pet_params)
      pet_params = pet_params.to_h.symbolize_keys
      pet_id = next_id
      type = pet_params[:type]
      params = pet_params.reject { |k| k == :type }.merge(id: pet_id).to_h
      pet = build_pet(type, params)

      if pet.errors.empty?
        @pets[pet_id] = pet
      end

      pet
    rescue => e
      pet ||= Struct.new(:errors).new([])
      pet.errors << e.message
      pet
    end

    private

    def next_id
      @id_sequence += 1
    end

    def build_pet(type, params)
      case type
      when "cat"
        Cat.new(**params)
      when "dog"
        Dog.new(**params)
      else
        raise ArgumentError, "Unknown pet type: #{type}"
      end
    end
  end
end

class PetRepository
  def all
    InMemoryPetStore.all
  end

  def where(conditions)
    InMemoryPetStore.all.where(conditions)
  end

  def create(pet_params)
    InMemoryPetStore.create(pet_params)
  end
end

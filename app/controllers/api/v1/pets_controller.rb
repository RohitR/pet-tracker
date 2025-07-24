class Api::V1::PetsController < ApplicationController
  def create
    @pet = pet_repo.create(pet_params)
    if @pet.errors.any?
      render json: { error: "Failed to create pet due to #{@pet.errors.join(',')}" }, status: :unprocessable_entity
      return
    end
    render json: @pet, status: :created
  end

  def search
    @pets = pet_repo.where(pet_params.to_h).to_a
    if @pets.empty?
      render json: { error: "No pets found" }, status: :not_found
    else
      render json: @pets, status: :ok
    end
  end

  def pets_count
    @pets_count_and_details = pet_repo.where(in_zone: false).group(:type, :tracker_type).count
    render json: @pets_count_and_details, status: :ok
  end

  private

  def pet_params
    params.require(:pet).permit(:type, :tracker_type, :owner_id, :in_zone, :lost_tracker)
  end

  def pet_repo
    @pet_repo ||= PetRepository.new
  end
end

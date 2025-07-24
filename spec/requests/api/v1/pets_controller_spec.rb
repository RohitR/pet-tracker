require 'rails_helper'

RSpec.describe 'Api::V1::PetsController', type: :request do
  let(:pet_repo) { instance_double(PetRepository) }

  before do
    allow_any_instance_of(Api::V1::PetsController).to receive(:pet_repo).and_return(pet_repo)
  end

  describe 'POST /api/v1/pets' do
    let(:valid_params) do
      {
        pet: {
          type: 'cat',
          tracker_type: 'small',
          owner_id: "1",
          in_zone: "true",
          lost_tracker: "false"
        }
      }
    end

    context 'when pet is created successfully' do
      let(:pet) do
        instance_double(
          'Cat',
          errors: [],
          as_json: valid_params[:pet].merge(id: 123)
        )
      end

      it 'returns status created and pet json' do
        expect(pet_repo).to receive(:create).with(ActionController::Parameters.new(valid_params[:pet]).permit!).and_return(pet)

        post '/api/v1/pets', params: valid_params

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('type' => 'cat', 'tracker_type' => 'small', 'owner_id' => "1")
      end
    end

    context 'when pet creation fails due to errors' do
      let(:pet) do
        instance_double(
          'Cat',
          errors: [ 'type can\'t be blank', 'invalid tracker' ],
          as_json: {}
        )
      end

      it 'returns unprocessable entity with error message' do
        expect(pet_repo).to receive(:create).and_return(pet)

        post '/api/v1/pets', params: valid_params

        expect(response).to have_http_status(422)
        body = JSON.parse(response.body)
        expect(body['error']).to include("Failed to create pet")
        expect(body['error']).to include("type can't be blank")
      end
    end
  end

  describe 'GET /api/v1/pets/search' do
    let(:query_params) do
      {
        pet: {
          type: 'dog',
          in_zone: 'false'
        }
      }
    end

    context 'when pets are found' do
      let(:pets) do
        [
          instance_double('Dog', as_json: { id: 1, type: 'dog', in_zone: false, owner_id: 10 }),
          instance_double('Dog', as_json: { id: 2, type: 'dog', in_zone: false, owner_id: 15 })
        ]
      end

      it 'returns ok with pets json' do
        query_result = double('InMemoryQuery', to_a: pets)
        expect(pet_repo).to receive(:where).with(hash_including("type" => "dog", "in_zone" => "false")).and_return(query_result)

        get '/api/v1/pets/search', params: query_params

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body.size).to eq(2)
        expect(body[0]['type']).to eq('dog')
      end
    end

    context 'when no pets are found' do
      it 'returns not found with error message' do
        query_result = double('InMemoryQuery', to_a: [])
        expect(pet_repo).to receive(:where).and_return(query_result)

        get '/api/v1/pets/search', params: query_params

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('No pets found')
      end
    end
  end

  describe 'GET /api/v1/pets/pets_count' do
    it 'returns pet counts grouped by type and tracker_type' do
      counts_hash = {
        { type: 'cat', tracker_type: 'small' } => 3,
        { type: 'dog', tracker_type: 'big' } => 5
      }

      expect(pet_repo).to receive(:where).with(in_zone: false).and_return(double('Relation', group: double('GroupedRelation', count: counts_hash)))

      get '/api/v1/pets/pets_count'

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)

      expect(body.length).to eq(2)
      expect(body.any? { |k, _| k.include?('cat') || k.include?('dog') }).to be true
    end
  end
end

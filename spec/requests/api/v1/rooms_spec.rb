require 'swagger_helper'

RSpec.describe 'api/my', type: :request do
  describe 'Room API' do
    path '/api/v1/rooms' do
      get 'Get all rooms' do
        tags 'Rooms'
        consumes 'application/json'
        response '200', ' All rooms' do
          # return an array of rooms (test)
          after do |example|
            example.metadata[:response][:examples] =
              { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
          end
          run_test!
        end
      end

      post 'Create a room' do
        tags 'Rooms'
        consumes 'application/json'
        parameter name: :room, in: :body, schema: {
          type: :object,
          properties: {
            description: { type: :string },
            num: { type: :integer },
            room_type: { type: :string },
            night_cost: { type: :integer },
            image: { type: :string },
            booked: { type: :boolean },
            booked_end: { type: :date },
            user_id: { type: :integer }
          },
          required: %w[description num room_type night_cost image user_id]
        }
        response '201', 'room created' do
          let(:room) do
            { description: 'test', num: 1, room_type: 'test', night_cost: 1.0, image: 'test', booked: false, booked_end: nil,
              user_id: 1 }
          end
          run_test!
        end
        response '422', 'invalid request' do
          let(:room) { { description: 'test', num: 1, room_type: 'test' } }
          run_test!
        end
      end
    end
    path '/api/v1/rooms/{id}' do
      get 'Get a room' do
        tags 'Rooms'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        response '200', 'room found' do
          let(:id) do
            Room.create(description: 'test', num: 1, room_type: 'test', night_cost: 1.0, image: 'test', booked: false,
                        booked_end: nil, user_id: 1).id
          end
          run_test!
        end
        response '404', 'room not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end

      put 'Update a room' do
        tags 'Rooms'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :room, in: :body, schema: {
          type: :object,
          properties: {
            description: { type: :string },
            num: { type: :integer },
            room_type: { type: :string },
            night_cost: { type: :integer },
            image: { type: :string },
            booked: { type: :boolean },
            booked_end: { type: :date },
            user_id: { type: :integer }
          },
          required: %w[description num room_type night_cost image user_id]
        }
        response '200', 'room updated' do
          let(:id) do
            Room.create(description: 'test', num: 1, room_type: 'test', night_cost: 1.0, image: 'test', booked: false,
                        booked_end: nil, user_id: 1).id
          end
          let(:room) do
            { description: 'test', num: 1, room_type: 'test', night_cost: 1.0, image: 'test', booked: false, booked_end: nil,
              user_id: 1 }
          end
          run_test!
        end
        response '404', 'room not found' do
          let(:id) { 'invalid' }
          let(:room) do
            { description: 'test', num: 1, room_type: 'test', night_cost: 1.0, image: 'test', booked: false, booked_end: nil,
              user_id: 1 }
          end
          run_test!
        end
      end

      delete 'Delete a room' do
        tags 'Rooms'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        response '200', 'room deleted' do
          let(:id) do
            Room.create(description: 'test', num: 1, room_type: 'test', night_cost: 1.0, image: 'test', booked: false,
                        booked_end: nil, user_id: 1).id
          end
          run_test!
        end
        response '404', 'room not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end

require "swagger_helper"

RSpec.describe "api/my", type: :request do
  describe "Reservation API" do
    path "/api/v1/reservations?user_id=1" do
      get "Get all reservations" do
        tags "Reservations"
        consumes "application/json"
        response "200", " All reservations" do
          # return an array of reservations (test)
          after do |example|
            example.metadata[:response][:examples] = { "application/json" => JSON.parse(response.body, symbolize_names: true) }
          end
          run_test!
        end
      end

      post "Create a reservation" do
        tags "Reservations"
        consumes "application/json"
        parameter name: :reservation, in: :body, schema: {
                    type: :object,
                    properties: {
                      start: { type: :datetime },
                      end: { type: :datetime },
                      nights: { type: :integer },
                      cost: { type: :decimal },
                      room_id: { type: :integer },
                      user_id: { type: :integer },
                    },
                    required: ["start", "end", "nights", "cost", "room_id", "user_id"],
                  }
        response "201", "reservation created" do
          let(:reservation) { { start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1, user_id: 1 } }
          run_test!
        end
        response "422", "invalid request" do
          let(:reservation) { { start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1 } }
          run_test!
        end
      end
    end
    path "/api/v1/reservations/{id}" do
      get "Get a reservation" do
        tags "Reservations"
        consumes "application/json"
        parameter name: :id, in: :path, type: :string
        response "200", "reservation found" do
          let(:id) { Reservation.create(start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1, user_id: 1).id }
          run_test!
        end
        response "404", "reservation not found" do
          let(:id) { "invalid" }
          run_test!
        end
      end

      put "Update a reservation" do
        tags "Reservations"
        consumes "application/json"
        parameter name: :id, in: :path, type: :string
        parameter name: :reservation, in: :body, schema: {
          type: :object,
          properties: {
            start: { type: :datetime },
            end: { type: :datetime },
            nights: { type: :integer },
            cost: { type: :decimal },
            room_id: { type: :integer },
            user_id: { type: :integer },
          },
          required: ["start", "end", "nights", "cost", "room_id", "user_id"],

        }
        response "200", "reservation updated" do
          let(:id) { Reservation.create(start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1, user_id: 1).id }
          let(:reservation) { { start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1, user_id: 1 } }
          run_test!
        end
        response "404", "reservation not found" do
          let(:id) { "invalid" }
          let(:reservation) { { start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1, user_id: 1 } }
          run_test!
        end
      end

      delete "Delete a reservation" do
        tags "Reservations"
        consumes "application/json"
        parameter name: :id, in: :path, type: :string
        response "200", "reservation deleted" do
          let(:id) { Reservation.create(start: "2021-05-01 00:00:00", end: "2021-05-02 00:00:00", nights: 1, cost: 1.0, room_id: 1, user_id: 1).id }
          run_test!
        end
        response "404", "reservation not found" do
          let(:id) { "invalid" }
          run_test!
        end
      end
    end
  end
end

require "swagger_helper"

RSpec.describe "api/my", type: :request do
  describe "User API" do
    path "/users" do
      post "Sign-up User" do
        tags "Users"
        consumes "application/json"
        parameter name: :user, in: :body, schema: {
                    type: :object,
                    properties: {
                      email: { type: :string },
                      password: { type: :string },
                      password_confirmation: { type: :string },
                    },
                    required: ["email", "password", "password_confirmation"],
                  }

        response "201", "user created" do
          let(:user) { { email: "mov@test.com", password: "123456", password_confirmation: "123456" } }
          run_test!

          # it 'returns the user' do
          #     data = JSON.parse(response.body)
          #     expect(data['email']).to eq('mov@test')
          # end
        end

        response "422", "invalid request" do
          let(:user) { { email: "test" } }
          run_test!

          # it 'returns a validation failure message' do
          #     data = JSON.parse(response.body)
          #     expect(data['message']).to eq("Validation failed: Password can't be blank")
          # end
        end
      end
    end
    path "/users/sign_in" do
      post "Sign-in User" do
        tags "Users"
        consumes "application/json"
        parameter name: :user, in: :body, schema: {
                    type: :object,
                    properties: {
                      email: { type: :string },
                      password: { type: :string },
                    },
                    required: ["email", "password"],
                  }
        response "201", "successfuly loged in" do
          let(:user) { { email: "mov@test.com", password: "123456"}}
          run_test!

          # it 'returns the user' do
          #     data = JSON.parse(response.body)
          #     expect(data['email']).to eq('mov@test')
          # end
        end

        response "422", "invalid request" do
          let(:user) { { email: "test" } }
          run_test!

          # it 'returns a validation failure message' do
          #     data = JSON.parse(response.body)
          #     expect(data['message']).to eq("Validation failed: Password can't be blank")
          # end
        end
      end
    end
  end
end

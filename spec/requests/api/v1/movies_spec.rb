# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V1::Movies' do
  describe 'GET /index' do
    path '/api/v1/movies' do
      post 'Creates a movie' do
        tags 'Movies'
        consumes 'application/json'
        parameter name: :movie, in: :body, schema: {
          type: :object,
          properties: {
            course_id: { type: :integer },
            url: { type: :string }
          },
          required: %w[course_id url]
        }

        response '201', :created do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   course_id: { type: :integer },
                   url: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id course_id url]
          let(:movie) do
            {
              course_id: Course.create(title: 'foo', description: 'bar', end_on: Time.zone.today.to_fs(:db)).id,
              url: 'bar'
            }
          end
          run_test!
        end

        response '422', :invalid_request do
          let(:movie) { { course_id: 'foo' } }
          run_test!
        end
      end
    end
  end
end

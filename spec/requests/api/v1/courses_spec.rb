# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'courses' do
  path '/api/v1/courses' do
    post 'Creates a course' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          end_on: { type: :string }
        },
        required: %w[title description end_on]
      }

      response '201', :created do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 description: { type: :string },
                 end_on: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id title description end_on]
        let(:course) { { title: 'foo', description: 'bar', end_on: Time.zone.today.to_fs(:db) } }
        run_test!
      end

      response '422', :invalid_request do
        let(:course) { { title: 'foo' } }
        run_test!
      end
    end

    get 'list courses' do
      tags 'Courses'
      consumes 'application/json'

      let(:create_courses) do
        Course.create(title: 'foo', description: 'bar', end_on: Time.zone.today.to_fs(:db))
        Course.create(title: 'bar', description: 'foo', end_on: Time.zone.today.to_fs(:db))
      end

      response 200, :success do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string },
                   end_on: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   movies: {
                     type: :array,
                     items: {
                       properties: {
                         id: { type: :integer },
                         course_id: { type: :integer },
                         url: { type: :string }
                       }
                     }
                   }
                 },
                 required: %w[id title description end_on]
               }
        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    get 'Retrieves a course' do
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', :success do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 description: { type: :string },
                 end_on: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id title description end_on]

        let(:id) { Course.create(title: 'foo', description: 'bar', end_on: Time.zone.today.to_fs(:db)).id }
        run_test!
      end

      response '404', :not_found do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update course by id' do
      tags 'Courses'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          end_on: { type: :string }
        },
        required: %w[title description end_on]
      }
      response '200', :success do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 description: { type: :string },
                 end_on: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id title description end_on]
        let(:id) { Course.create(title: 'foo', description: 'bar', end_on: Time.zone.today.to_fs(:db)).id }
        let(:course) { { title: 'bar', description: 'foo', end_on: Time.zone.today.to_fs(:db) } }
        run_test!
      end

      response '404', :not_found do
        let(:course) { { title: 'bar', description: 'foo', end_on: Time.zone.today.to_fs(:db) } }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end

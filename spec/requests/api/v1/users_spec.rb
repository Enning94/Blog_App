# require 'swagger_helper'

# end
# spec/requests/blogs_spec.rb
require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
describe 'Posts API' do

  path '/posts' do

    post 'Creates a post' do
      tags 'Posts'
      consumes 'application/json'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string }
        },
        required: [ 'title', 'text' ]
      }

      response '201', 'post created' do
        let(:post) { { title: 'foo', content: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:post) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/posts/{id}' do

    get 'Retrieves a post' do
      tags 'Posts', 'Another Tag'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'post found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            text: { type: :string }
          },
          required: [ 'id', 'title', 'text' ]

        let(:id) { Post.create(title: 'foo', text: 'bar').id }
        run_test!
      end

      response '404', 'post not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end
end
# # spec/controllers/api/v1/users_controller_spec.rb

# require 'rails_helper'

# RSpec.describe Api::V1::UsersController, type: :controller do
#   let(:valid_attributes) {
#     { name: 'John Doe', email: 'john@example.com', bio: 'Sample bio' }
#   }

#   let(:invalid_attributes) {
#     { name: '', email: 'invalid_email', bio: 'Sample bio' }
#   }

#   let(:valid_session) { {} }

#   describe 'GET #index' do
#     it 'returns a JSON response with a list of users' do
#       user = User.create!(valid_attributes)
#       get :index, params: {}, session: valid_session
#       expect(response).to be_successful
#       expect(response.content_type).to eq('application/json; charset=utf-8')
#       expect(JSON.parse(response.body)).to eq([user.as_json(only: %i[id name email bio])])
#     end
#   end

#   describe 'GET #show' do
#     it 'returns a JSON response with a user' do
#       user = User.create!(valid_attributes)
#       get :show, params: { id: user.to_param }, session: valid_session
#       expect(response).to be_successful
#       expect(response.content_type).to eq('application/json; charset=utf-8')
#       expect(JSON.parse(response.body)).to eq(user.as_json(only: %i[id name email bio]))
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid params' do
#       it 'creates a new User' do
#         expect {
#           post :create, params: { user: valid_attributes }, session: valid_session
#         }.to change(User, :count).by(1)
#       end

#       it 'renders a JSON response with the new user' do
#         post :create, params: { user: valid_attributes }, session: valid_session
#         expect(response).to have_http_status(:created)
#         expect(response.content_type).to eq('application/json; charset=utf-8')
#         expect(JSON.parse(response.body)).to eq(User.last.as_json(only: %i[id name email bio]))
#       end
#     end

#     context 'with invalid params' do
#       it 'renders a JSON response with errors' do
#         post :create, params: { user: invalid_attributes }, session: valid_session
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.content_type).to eq('application/json; charset=utf-8')
#         expect(JSON.parse(response.body)).to include('name' => ["can't be blank"])
#       end
#     end
#   end

#   describe 'PUT #update' do
#     context 'with valid params' do
#       let(:new_attributes) {
#         { name: 'New Name' }
#       }

#       it 'updates the requested user' do
#         user = User.create!(valid_attributes)
#         put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
#         user.reload
#         expect(user.name).to eq(new_attributes[:name])
#       end

#       it 'renders a JSON response with the user' do
#         user = User.create!(valid_attributes)
#         put :update, params: { id: user.to_param, user: valid_attributes }, session: valid_session
#         expect(response).to be_successful
#         expect(response.content_type).to eq('application/json; charset=utf-8')
#         expect(JSON.parse(response.body)).to eq(user.reload.as_json(only: %i[id name email bio]))
#       end
#     end

#     context 'with invalid params' do
#       it 'renders a JSON response with errors' do
#         user = User.create!(valid_attributes)
#         put :update, params: { id: user.to_param, user: invalid_attributes }, session: valid_session
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.content_type).to eq('application/json; charset=utf-8')
#         expect(JSON.parse(response.body)).to include('name' => ["can't be blank"])
#       end
#     end
#   end

#   describe

# frozen_string_literal: true
require 'rails_helper'
require 'rspec_api_documentation/dsl'
require 'faker'

resource 'Users' do
  explanation 'Users resource'

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:current_user) { nil }
  before do
    if current_user
      header 'Authorization', "Bearer #{Knock::AuthToken.new(payload: { sub: current_user.id }).token}"
    end
  end

  get '/sellers' do
    parameter :name, 'Full or part of seller name'
    parameter :page, 'Pagination'

    let!(:sellers) { create_list(:seller, 4) }

    example_request 'Getting a list of sellers' do
      expect(status).to eq(200)
      response_hash = JSON.parse response_body
      expect(response_hash['users'].count).to eq(4)
    end
  end

  get '/users/me' do
    let(:current_user) { create(:buyer) }

    example_request 'Getting data of current login user' do
      expect(status).to eq(200)
    end
  end

  post '/users' do
    with_options scope: :user, with_example: true do
      parameter :name, 'Name of user', required: true
      parameter :role, 'Role of user (buyer or seller)', require: true
      parameter :email, required: true
      parameter :password, required: true
    end

    let(:user) { build(:buyer) }

    let(:name) { user.name }
    let(:email) { user.email }
    let(:password) { '12345678' }
    let(:role) { user.role }

    let(:raw_post) { params.to_json }

    example_request 'Registration of new user' do
      expect(status).to eq(200)
    end
  end

  post '/user_token' do
    with_options scope: :auth, with_example: true do
      parameter :email, 'Email of user that login', required: true
      parameter :password,'Password of user that login', required: true
    end
    let!(:buyer) { create(:buyer, password: '12345678') }

    let(:email) { buyer.email }
    let(:password) { '12345678' }

    let(:raw_post) { params.to_json }

    example_request 'Log In user' do
      expect(status).to eq(201)
    end
  end

  patch '/users/me' do
    with_options scope: :user, with_example: true do
      parameter :name
      parameter :email
      parameter :password
      parameter :avatar
      parameter :location
    end

    let(:current_user) { create(:buyer) }

    let(:name) { 'new name' }
    let(:location) { 'Lviv, Ukraine' }

    let(:raw_post) { params.to_json }

    example_request 'Upadate user' do
      expect(status).to eq(200)
    end
  end
end

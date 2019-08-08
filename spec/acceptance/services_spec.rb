# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'
require 'faker'

resource 'Services' do
  explanation 'Services resource'

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:current_user) { create(:seller) }
  before do
    if current_user
      header 'Authorization', "Bearer #{Knock::AuthToken.new(payload: { sub: current_user.id }).token}"
    end
  end

  get '/services' do
    parameter :page

    let!(:services) { create_list(:service, 4) }

    example_request 'Getting services list' do
      expect(status).to eq(200)
    end
  end

  get '/services/:id' do
    let(:service) { create(:service) }
    let(:id) { service.id }

    example_request 'Getting service' do
      expect(status).to eq(200)
    end
  end

  post '/services' do
    with_options scope: :service, with_example: true do
      parameter :title, 'Name of service', required: true
      parameter :description
      parameter :price_cents, 'Service price', required: true
    end

    let(:service) { build(:service) }

    let(:title) { service.title }
    let(:description) { service.description }
    let(:price_cents) { service.price_cents }

    let(:raw_post) { params.to_json }

    example_request 'Creating new service' do
      expect(status).to eq(200)
    end
  end

  patch '/services/:id' do
    with_options scope: :service, with_example: true do
      parameter :title, 'Name of service', required: true
      parameter :description
      parameter :price_cents, 'Service price', required: true
    end

    let(:service) { create(:service, seller: current_user) }
    let(:new_service) { build(:service) }

    let(:id) { service.id }

    let(:title) { new_service.title }
    let(:description) { new_service.description }
    let(:price_cents) { new_service.price_cents }

    let(:raw_post) { params.to_json }

    example_request 'Update require service' do
      expect(status).to eq(200)
    end
  end

  delete '/services/:id' do
    let(:service) { create(:service, seller: current_user) }
    let(:id) { service.id }

    example_request 'Deleting an service' do
      expect(status).to eq(200)
    end
  end
end

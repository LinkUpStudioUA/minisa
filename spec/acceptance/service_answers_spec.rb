# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'
require 'faker'

resource 'Service Answers' do
  explanation 'Service answers resource'

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:current_user) { create(:seller) }
  before do
    if current_user
      header 'Authorization', "Bearer #{Knock::AuthToken.new(payload: { sub: current_user.id }).token}"
    end
  end

  post '/service_requests/:service_request_id/service_answers' do
    with_options scope: :service_answer, with_example: true do
      parameter :text, 'Message from seller', required: true
      parameter :service_request_id, 'ID of require service request', required:true
      parameter :video, 'Some attached video'
    end

    let(:service_request) {
      create(:service_request,
             service: create(:service, seller: current_user),
             status: :submitted)
    }

    let(:text) { 'jkhj hjkhjk' }
    let(:service_request_id) { service_request.id }

    let(:raw_post) { params.to_json }

    example_request 'Add service answer' do
      expect(status).to eq(200)
    end
  end
end

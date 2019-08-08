# frozen_string_literal: true

class ServiceRequestsController < ApplicationController
  before_action :authenticate_user
  before_action :find_service_request,
                only: %i[update destroy show submit deny cancel]

  def create
    result = Requests::Create.new.call(
      params: request_params.merge(buyer: current_user),
      promo_code: params[:service_request][:promo_code]
    )
    if result.success?
      render json: result.success[:service]
    else
      render json: result.failure, status: :unprocessable_entity
    end
  end

  def show
    render json: @service_request
  end

  def submit
    result = Requests::Submit.new.call(service_request: @service_request)
    if result.success?
      head :ok
    else
      render json: { errors: result.failure }, status: :unprocessable_entity
    end
  end

  def deny
    # TODO: implement
  end

  def cancel
    # TODO: implement
  end

  private

  def request_params
    params.require(:service_request).permit(:text, :video, :service_id)
  end

  def find_service_request
    authorize @service_request = ServiceRequest.find(params[:id])
  end
end

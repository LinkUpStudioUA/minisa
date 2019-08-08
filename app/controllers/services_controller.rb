# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :find_service, only: %i[update destroy show]
  before_action :authenticate_user, except: %i[index show]

  ServiceReducer = Rack::Reducer.new(
    Service.all,
    ->(page: 1) { page(page) },
  )

  def index
    render json: ServiceReducer.apply(params)
  end

  def show
    render json: @service
  end

  def create
    authorize Service

    service = current_user.services.new(service_params)
    if service.save
      render json: service
    else
      render json: service.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      render json: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    head :ok
  end

  private

  def service_params
    params.require(:service).permit(
      :title, :price_cents, :description, :image, :video
    )
  end

  def find_service
    authorize @service = Service.find(params[:id])
  end
end

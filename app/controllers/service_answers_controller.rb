# frozen_string_literal: true

class ServiceAnswersController < ApplicationController
  before_action :authenticate_user
  before_action :find_service_request, only: :create

  def create
    authorize @service_request, :answer?

    result =
      Answers::Create.new.call(
        params: answer_params.merge(service_request: @service_request)
      )
    if result.success?
      head :ok
    else
      render json: result.failure, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:service_answer).permit(:text, :video, :service_request_id)
  end

  def find_service_request
    @service_request = ServiceRequest.find(answer_params[:service_request_id])
  end
end

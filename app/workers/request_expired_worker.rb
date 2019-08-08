class RequestExpiredWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    current_request = ServiceRequest.find_by(id: id)
    if current_request && current_request.status.submitted?
      # TODO: implement
    end
  end
end

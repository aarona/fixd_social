class ApplicationController < ActionController::API
  protected

  def render_error(status, message, data = nil)
    response = {
      errors: [message]
    }
    response = response.merge(data) if data
    render json: response, status: status
  end
end

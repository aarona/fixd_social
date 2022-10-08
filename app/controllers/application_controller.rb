class ApplicationController < ActionController::API
  protected

  def render_error(status, errors, data = nil)
    response = {
      errors: Array(errors)
    }
    response = response.merge(data) if data
    render json: response, status: status
  end
end

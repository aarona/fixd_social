class ApplicationController < ActionController::API
  protected

  def render_error(status, errors, data = nil)
    response = {
      errors: Array(errors)
    }
    response = response.merge(data) if data
    render json: response, status: status
  end

  def render_response(status = :ok, options = nil)
    reponse = {
      formats: :json,
      handlers: :jbuilder,
      status: status
    }

    response = response.merge(options) if options

    render response  
  end
end

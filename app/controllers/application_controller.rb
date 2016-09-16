class ApplicationController < ActionController::API
  attr_reader :current_user
  before_action :authenticate_request

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).user
    render_error 'Unauthorized', :unauthorized unless @current_user
  end
end

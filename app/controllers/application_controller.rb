class ApplicationController < ActionController::API
  include Authority::Controller
  attr_reader :current_user

  before_action :verify_authenticate_token

  def current_or_null_user
    if current_user.nil?
      User.new
    else
      current_user
    end
  end

  protected

  def render_success(message = '', options = {}, status = :ok)
    render status: status,
           json: {
             success: true,
             message: message
           }.merge(options)
  end

  def render_error(message, status = :unprocessable_entity)
    logger.error(message)
    render status: status,
           json: {
             success: false,
             message: message
           }
  end

  private

  def verify_authenticate_token
    @current_user = AuthorizeApiRequest.call(headers: request.headers).user
    render_error 'Unauthorized', :unauthorized unless @current_user
  end
end

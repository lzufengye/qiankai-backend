class ApiController < ApplicationController
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found_exception
  rescue_from UnauthorizedException, with: :handle_unauthorized_exception

  private
  def handle_record_not_found_exception(exception)
    logger.info("Record not found: #{exception.message}")
    render json: {message: "record not found:  #{exception.message}"}.to_json, status: 404
  end

  def handle_unauthorized_exception(exception)
    logger.info("Not authorized to this operation: #{exception.message}")
    render json: {message: exception.message}.to_json, status: 401
  end
end

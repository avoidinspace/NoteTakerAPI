class ApplicationController < ActionController::API
  before_action :authenticate_with_http_header

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private
  def authenticate_with_http_header
    api_key = request.headers['X-API-KEY']
    key = ApiKey.find_by_access_token(api_key)
    unless key
      head status: :unauthorized
    end
  end

  def not_found
    head status: 404
  end
end

class Api::ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound do
    render json: {}, status: 500
  end

  def current_user
    @current_user ||=
      authenticate_or_request_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
  end

  private

  def authenticate!
    current_user
  end
end

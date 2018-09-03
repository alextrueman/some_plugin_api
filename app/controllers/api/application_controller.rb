class Api::ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  helper_method :current_user

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(auth_token: token)
    end
  end

  private

  def authenticate!
    current_user
  end
end

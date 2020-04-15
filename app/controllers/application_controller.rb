class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ErrorsCatcher

  http_basic_authenticate_with name: "admin", password: "password"
end

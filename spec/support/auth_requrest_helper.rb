module AuthRequestHelper
  def http_login_header
    { 'HTTP_AUTHORIZATION': ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'password') }
  end
end

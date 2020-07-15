module ScimRails
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include Response

    before_action :doorkeeper_authorize!
    before_action :validate_jwt_token!
    before_action :set_current_site

    private

    def set_current_site
      @site ||= Site.find(@token_payload['aud'])
    end

    def validate_jwt_token!
      @token_payload = ::JWT.decode(
        doorkeeper_token.token,
        OpenSSL::PKey::RSA.new(File.read(Doorkeeper::JWT.configuration.secret_key_path)),
        true,
        { algorithm: Doorkeeper::JWT.configuration.encryption_method.to_s.upcase }
      ).first
    rescue DecodeError
      # TODO: Revoke the token
      head :unauthorized
    end
  end
end

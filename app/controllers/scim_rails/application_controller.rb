module ScimRails
  class ApplicationController < ActionController::API
    include Authenticable
    include ExceptionHandler
    include Response

    before_action :set_current_site

    private

    def set_current_site
      @site ||= Site.find(@token_payload['aud'])
    end
  end
end

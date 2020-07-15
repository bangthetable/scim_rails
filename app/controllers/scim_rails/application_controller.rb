module ScimRails
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include Response

    before_action :doorkeeper_authorize!
    before_action :set_current_site

    private

    def set_current_site
      @site ||= Site.first
    end
  end
end

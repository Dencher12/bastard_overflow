require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_url, alert: e.message
  end  
end

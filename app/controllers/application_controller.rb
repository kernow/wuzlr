# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  layout "default"
  
  before_filter :leagues, :wup_wup_playaz
  
  def leagues
    @leagues = current_user.leagues if signed_in?
  end
  
  def wup_wup_playaz
    @wup_wup_playaz = User.wup_wup_playaz
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "default"
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'f353a74eafb9c036c862a5b75a041f85'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :set_selected
  
  
  protected
  
    def set_selected
      @selected = "all"
    end
    
    def set_paginate
      params[:page].nil? ? @page = 1 : @page = params[:page]
      @per_page = PER_PAGE
    end
    
end

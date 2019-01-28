class ApplicationController < ActionController::Base
	
	#controller specific configuration
	
	#force_ssl
	protect_from_forgery with: :exception
	include ApplicationHelper

end

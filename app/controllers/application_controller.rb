class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :set_cache_headers

  def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform that action"
			redirect_to root_path
		end
	end

	def require_admin
		if !current_user.admin?
				flash[:danger] = "You must be logged in as admin to perform that action"
				redirect_to root_path
		end
	end

	private
  	def set_cache_headers
	    response.headers["Cache-Control"] = "no-cache, no-store"
	    response.headers["Pragma"] = "no-cache"
	    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  	end

end

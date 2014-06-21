class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def api_authenticate
    api_authenticate_token || api_unauthorized
  end

  def api_authenticate_token
    authenticate_with_http_token do |token, options|
      @email = options['email']
      @user = User.where("auth_token = ? and email = ?", token, @email)
      return true if @user.exists?
    end
  end

  def api_unauthorized
    #self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def unauthorized
    redirect_to root_path, alert: "Unauthorized access"
  end

  def require_admin
    redirect_to root_path, alert: "Unauthorized access" if !current_user.is_admin
  end
end

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  respond_to :html, :json
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_sessions
  skip_before_filter :verify_authenticity_token, :only => [:options]

  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :reject_locked!, if: :devise_controller?

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :search_the_sales
    devise_parameter_sanitizer.for(:sign_up) << :fetch_my_fashion
    devise_parameter_sanitizer.for(:sign_up) << :gender_id
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :gender_id
    devise_parameter_sanitizer.for(:account_update) << :push_token
    devise_parameter_sanitizer.for(:account_update) << :quiz_results
  end

  def authenticate_current_user
    render json: {}, status: :unauthorized if get_current_user.nil?
  end

  def get_current_user
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse cookies[:auth_headers]
    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_user = User.find_by uid: auth_headers["uid"]
    if current_user &&
       current_user.tokens.has_key?(auth_headers["client"]) &&
       expiration_datetime > DateTime.now
      @current_user = current_user
    end
    @current_user
  end

  # # Redirects on successful sign in
  # def after_sign_in_path_for(_resource)
  #   inside_path
  # end

  # Auto-sign out locked users

  # Only permits admin users
  def require_admin!
    authenticate_current_user

    if get_current_user && !get_current_user.admin?
      redirect_to root_path
    end
  end
  helper_method :require_admin!
end

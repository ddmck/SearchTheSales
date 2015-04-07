class PasswordResetsController < ApplicationController
  before_action :set_params, only: [:create]
  respond_to :json
  def create
    if @user
      # if get_current_user.nil?
      #   respond_with(status: :unauthorized)
      # else
        @user.password_reset_token = SecureRandom.urlsafe_base64
        @user.save
        respond_with(@user, status: 200)
      # end
    else
      respond_with(@user, status: 400)
    end
  end

  def set_params
    @user = User.find(params[:userId])
  end
end

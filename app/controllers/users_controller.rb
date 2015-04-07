require 'bcrypt'

class UsersController < ApplicationController
  respond_to :json
  def update
    @user = User.find(params[:id])

    # user_identity = Identity.find_by_email(@user.email)
    unencrypted_password = params[:password].to_s
    token = params[:password_reset_token].to_s

    if token == @user.password_reset_token
      password_digest = BCrypt::Password.create(unencrypted_password)
      @user.encrypted_password = password_digest
      @user.save!
      respond_with(status: 200)
    else
      respond_with(status: 400)
    end
  end
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end
end

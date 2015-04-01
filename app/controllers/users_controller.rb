require 'bcrypt'

class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])

    # user_identity = Identity.find_by_email(@user.email)
    unencrypted_password = params[:password].to_s
    password_digest = BCrypt::Password.create(unencrypted_password)
    @user.encrypted_password = password_digest
    @user.save!
  end
end

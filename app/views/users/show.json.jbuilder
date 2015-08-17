if @user
  json.extract! @user, :id, :name, :gender, :email, :provider
end

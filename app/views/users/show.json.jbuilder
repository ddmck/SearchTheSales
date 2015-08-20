if @user
  json.extract! @user, :id, :name, :email, :provider
  json.gender @user.gender_string
end

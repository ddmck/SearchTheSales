if @user
  json.extract! @user, :id, :name, :email, :provider, :quiz_results
  json.gender @user.gender_string
end

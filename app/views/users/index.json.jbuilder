if @users
  json.array!(@users) do |user|
  	json.extract! user, :id, :name, :email, :replied_to
	end
end

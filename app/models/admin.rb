class Admin < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
end

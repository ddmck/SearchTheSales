class Admin < ActiveRecord::Base
	devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable,
         :omniauthable
         
  include DeviseTokenAuth::Concerns::User
  has_many :messages
end

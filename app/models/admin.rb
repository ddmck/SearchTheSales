class Admin < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
	devise :database_authenticatable, :recoverable,
				:trackable, :validatable, :registerable,
				:omniauthable
  has_many :users
  has_many :messages, through: :users
end

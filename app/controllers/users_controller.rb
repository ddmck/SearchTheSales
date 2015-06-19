class UsersController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_user, only: [:show]

	respond_to :json

	def index
		@users = User.page(params[:page])
		respond_with(@users)
	end

	def show
		respond_with(@user)
	end


	private

	def set_user
		@user = User.find(params[:id])
	end
end
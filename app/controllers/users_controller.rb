require 'will_paginate/array'

class UsersController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_user, only: [:show]

	respond_to :json

	def index
		@users = User.most_recent.paginate(page: params[:page], per_page: 25)
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

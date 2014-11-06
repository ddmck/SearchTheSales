class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @colors = Color.all
    respond_with(@colors)
  end

  def show
    respond_with(@color)
  end

  def new
    @color = Color.new
    respond_with(@color)
  end

  def edit
  end

  def create
    @color = Color.new(color_params)
    @color.save
    respond_with(@color)
  end

  def update
    @color.update(color_params)
    respond_with(@color)
  end

  def destroy
    @color.destroy
    respond_with(@color)
  end

  private
    def set_color
      @color = Color.find(params[:id])
    end

    def color_params
      params.require(:color).permit(:name)
    end
end

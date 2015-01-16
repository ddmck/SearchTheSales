class SizesController < ApplicationController
  before_action :set_size, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sizes = Size.all
    respond_with(@sizes)
  end

  def show
    respond_with(@size)
  end

  def new
    @size = Size.new
    respond_with(@size)
  end

  def edit
  end

  def create
    @size = Size.new(size_params)
    @size.save
    respond_with(@size)
  end

  def update
    @size.update(size_params)
    respond_with(@size)
  end

  def destroy
    @size.destroy
    respond_with(@size)
  end

  private
    def set_size
      @size = Size.find(params[:id])
    end

    def size_params
      params.require(:size).permit(:name)
    end
end

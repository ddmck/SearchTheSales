class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @styles = Style.all
    respond_with(@styles)
  end

  def show
    respond_with(@style)
  end

  def new
    @style = Style.new
    respond_with(@style)
  end

  def edit
  end

  def create
    @style = Style.new(style_params)
    @style.save
    respond_with(@style)
  end

  def update
    @style.update(style_params)
    respond_with(@style)
  end

  def destroy
    @style.destroy
    respond_with(@style)
  end

  private

  def set_style
    @style = Style.find(params[:id])
  end

  def style_params
    params.require(:style).permit(:name)
  end
end

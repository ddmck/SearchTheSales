class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  respond_to :json
  def index
    @materials = Material.featured
    respond_with(@materials)
  end

  def show
    respond_with(@material)
  end

  def new
    @material = Material.new
    respond_with(@material)
  end

  def edit
  end

  def create
    @material = Material.new(material_params)
    @material.save
    respond_with(@material)
  end

  def update
    @material.update(material_params)
    respond_with(@material)
  end

  def destroy
    @material.destroy
    respond_with(@material)
  end

  private

  def set_color
    @material = Material.find(params[:id])
  end

  def color_params
    params.require(:material).permit(:name)
  end
end

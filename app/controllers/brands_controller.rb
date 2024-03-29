class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  
  respond_to :html, :json

  def index
    @brands = Brand.featured
    respond_with(@brands)
  end

  def show
    respond_with(@brand)
  end

  def new
    @brand = Brand.new
    respond_with(@brand)
  end

  def edit
  end

  def create
    @brand = Brand.new(brand_params)
    @brand.save
    respond_with(@brand)
  end

  def update
    @brand.update(brand_params)
    respond_with(@brand)
  end

  def destroy
    @brand.destroy
    respond_with(@brand)
  end

  private

  def set_brand
    @brand = Brand.friendly.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name, :feature_text, :image_url)
  end
end

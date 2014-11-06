class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_collections, only: [:new, :edit]

  respond_to :html, :json

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.save
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def get_collections
    @categories = Category.all
    @stores = Store.all
    @brands = Brand.all
    @colors = Color.all
  end

  def product_params
    params.require(:product).permit(:name, :rrp, :sale_price, :brand_id, :store_id, :category_id, {color_ids: []}, :url, :image_url, :description, :gender)
  end
end

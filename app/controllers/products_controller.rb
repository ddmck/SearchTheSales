class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_collections, only: [:new, :edit]

  respond_to :html, :json

  def index
    if params["gender"]
      @gender = Gender.find_by_name(params["gender"])
      if params[:category]
        @products = Product.where(category_id: params[:category], gender_id: @gender.id)
      else
        @products = @gender.products
      end
    elsif params[:category]
      @category = Category.find(params[:category])
      @products = @category.products
    else  
      @products = Product.all
    end
    if params[:search_string]
      @products = @products.basic_search(name: params[:search_string])
    end
    @products = @products.paginate(page: params[:page], per_page: 52)
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
    @sub_categories = SubCategory.all
    @stores = Store.all
    @brands = Brand.all
    @colors = Color.all
    @trends = Trend.all
  end

  def product_params
    params.require(:product).permit(:name, :rrp, :sale_price, :brand_id, :store_id, :category_id, { sub_category_ids: [] }, { color_ids: [] }, { trend_ids: [] }, :url, :image_url, :description, :gender)
  end
end

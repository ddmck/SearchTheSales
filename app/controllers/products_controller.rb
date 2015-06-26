class ProductsController < ApplicationController
  include Aggregations
  include SearchBuilder
  include MoreLikeThis
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy, :wish, :more_like_this]
  before_action :get_collections, only: [:new, :edit]
  respond_to :html, :json

  def index
    result = search_products
    @products = result[0]
    @aggs = result[1]
    respond_with(@products, @aggs)
  end

  def show
    if @product
      respond_with(@product)
    else
      render :json => {:response => "The Product you're looking for is no longer available"}, status: 404
      #respond_with(@product, response: "Test", status: :not_found)
    end
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
    if @product
      @product.update(product_params)
      respond_with(@product)
    else
      respond_with(@product, status: :not_found)
    end
  end

  def destroy
    if @product
      @product.destroy
      respond_with(@product)
    else
      respond_with(@product, status: :not_found)
    end
  end

  def destroy_by_url
    @product = Product.find_by_url(params[:url])
    if @product.try(:delete)
      respond_with(@product, status: 200)
    else
      respond_with(status: 500)
    end
  end

  def buy
    if @product
      redirect_to(@product.url)
    else
      respond_with(@product, status: :not_found)
    end
  end

  def wish
    if @product
      @product.add_to_wishlist(get_current_user)
      respond_with(@product, status: 200)
    else
      respond_with(@product, status: :not_found)
    end
  end

  private

  def set_product
    @product = Product.find_by_id(params[:id])
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
    params.require(:product).permit(:name, 
                                    :rrp, 
                                    :sale_price, 
                                    :brand_id, 
                                    :store_id, 
                                    :category_id, 
                                    { sub_category_ids: [] }, 
                                    { color_ids: [] }, 
                                    { trend_ids: [] }, 
                                    :url, 
                                    :image_url, 
                                    :description, 
                                    :gender_id)
  end

  def convert_filters_to_hash(param_filters)
    puts param_filters.class
    if param_filters.class == ActionController::Parameters
      filters = param_filters
    elsif param_filters.class == Array || param_filters.class == String

      filters = JSON.parse(param_filters)
    else
      filters = {}
    end
    return filters
  end
end

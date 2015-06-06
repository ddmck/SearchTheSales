class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy, :wish, :more_like_this]
  before_action :get_collections, only: [:new, :edit]
  respond_to :html, :json

  def index
    if params["search_string"] 
      hash = {query: {
                      query_string: {
                        default_field: "reference_name",
                        query: build_search_string(params)
                        }
                      }, size: 200}
      if params[:sort]
        args = params[:sort].split(", ")
        hash[:sort] = [{args[0] => args[1]}]
      end
      @products = Product.__elasticsearch__.search(hash).page(params[:page]).records
    else
      hash = build_match_all
      @products = Product.__elasticsearch__.search(hash).page(params[:page]).records
    end
    respond_with(@products)
  end

  def show
    if @product
      respond_with(@product)
    else
      respond_with(status: 404)
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
      respond_with(status: 404)
    end
  end

  def destroy
    if @product
      @product.destroy
      respond_with(@product)
    else
      respond_with(status: 404)
    end
  end

  def more_like_this
    hash = build_more_like_this
    puts hash
    @products = Product.__elasticsearch__.search(hash).records
    respond_with(@products)
  end

  def build_match_all
    hash = {}
    hash[:query] = {match_all: {}}

    if params[:filters]
      where_opts = JSON.parse(params[:filters])
    else
      where_opts = {"brand_id" => @product.brand_id, "category_id" => @product.category_id, "gender_id" => @product.gender_id}
    end
    where_opts = where_opts.map {|key, v| {term: {key.to_sym => v}}}
    hash[:filter] = { and: where_opts}

    if params[:sort]
      args = params[:sort].split(", ")
      hash[:sort] = [{args[0] => args[1]}]
    end
    puts hash
    hash
  end

  def build_match_must
    hash = {}
    
    if @product.gender_id && @product.category_id
      where_opts = {"gender_id" => @product.gender_id, "category_id" => @product.category_id}
    elsif @product.gender_id
      where_opts = {"gender_id" => @product.gender_id}
    elsif @product.category_id
      where_opts = {"category_id" => @product.category_id}
    end
    
    where_opts = where_opts.map {|key, v| {match: {key.to_sym => v}}}
    hash = where_opts
    hash
  end

  def build_match_should
    hash = {}

    if @product.color_id && @product.brand_id
      where_opts = {"color_id" => @product.color_id, "brand_id" => @product.brand_id}
    elsif @product.color_id
      where_opts = {"color_id" => @product.color_id}
    elsif @product.brand_id
      where_opts = {"brand_id" => @product.brand_id}
    end

    where_opts = where_opts.map {|key, v| {match: {key.to_sym => v}}}
    hash = where_opts
    hash
  end

  def build_more_like_this
    hash = {}
    hash = {query: {bool: {
              must: build_match_must,
              should: build_match_should
              }}, size: 25}
    hash
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
      respond_with(status: 404)
    end
  end

  def wish
    if @product
      @product.add_to_wishlist(get_current_user)
      respond_with(@product, status: 200)
    else
      respond_with(status: 404)
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
                                    :gender)
  end

  def build_search_string(params)
    filters = params[:filters] ? JSON.parse(params[:filters]) : {}
    string = params[:search_string].try(:downcase).try(:strip) || '*'
    if filters["category_id"]
      curr_category = Category.find(filters["category_id"])
      string = string.remove(curr_category.name).remove(curr_category.name.singularize).strip 
    end
    if string.strip == ""
      string = params[:search_string].downcase.strip
    end
    string = string.downcase.split(" ").join("^2 ") + '^2' + ' OR ' + string.downcase.split(" ").join("~1 ") + '~1' 
    if !filters.empty?
      string = build_filters(string, filters)
    end
    string
  end

  def build_filters(string, filters)
    filters.each do |key, val|
      string += ' AND ' + key + ': ' + val.try(:to_s) if val
    end
    puts string
    string
  end
end

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy, :wish]
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
      sorters = {
        "first_letter, asc" => "name ASC",
        "first_letter, desc" => "name DESC",
        "display_price, asc" => "display_price ASC",
        "display_price, desc" => "display_price DESC"
      }
      ord_string = sorters[params[:sort]] || ""
      where_opts = JSON.parse(params[:filters])
      where_opts[:out_of_stock] = false
      @products = Product.includes(:sizes).where(where_opts).order(ord_string).paginate(page: params[:page])
    end
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

  def destroy_by_url
    @product = Product.find_by_url(params[:url])
    if @product.try(:delete)
      respond_with(@product, status: 200)
    else
      respond_with(status: 500)
    end
  end

  def buy
    redirect_to(@product.url)
  end

  def wish
    @product.add_to_wishlist(get_current_user)
    respond_with(@product, status: 200)
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
    string += " AND out_of_stock: false"
    string
  end

  def build_filters(string, filters)
    filters.each do |key, val|
      string += ' AND ' + key + ': ' + val.to_s
    end
    puts string
    string
  end
end

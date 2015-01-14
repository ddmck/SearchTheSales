class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy, :wish]
  before_action :get_collections, only: [:new, :edit]
  skip_before_filter :verify_authenticity_token
  # before_action :authenticate_current_user, only: [:wish]
  respond_to :html, :json

  def index
    if params[:search_string]
      @products = Product.__elasticsearch__.search(query: {
                                                    query_string: {
                                                      default_field: "reference_name",
                                                      query: build_search_string(params)
                                                    }}, size: 200).page(params[:page]).records
    else
      if params["gender"]
        @gender = Gender.find_by_name(params["gender"])
        if params[:category]
          @products = Product.where(category_id: params[:category], gender_id: @gender.id)
          if params[:sub_category]
            @products = @products.where(sub_category_id: params[:sub_category])
          end
        else
          @products = @gender.products
        end
      elsif params[:category]
        @category = Category.find(params[:category])
        @products = @category.products
        if params[:sub_category]
          @products = @products.where(sub_category_id: params[:sub_category])
        end
      else  
        @products = Product.all
        
      end
      @products = @products.paginate(page: params[:page])
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
    url = params[:url]
    @product = Product.find_by_url(url)
    @product.delete
    render :status => 200
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
    string = params[:search_string].downcase.strip
    if params[:category]
      curr_category = Category.find(params[:category])
      string = string.remove(curr_category.name).remove(curr_category.name.singularize).strip 
    end
    if string.strip == ""
      string = params[:search_string].downcase.strip
    end
    string = string.downcase.split(" ").join("^2 ") + '^2' + ' OR ' + string.downcase.split(" ").join("~1 ") + '~1' 
    string += ' AND category_id: ' + params[:category] if params[:category]
    string += ' AND sub_category_id: ' + params[:sub_category]  if params[:sub_category]
    if params[:gender]
      @gender = Gender.find_by_name(params[:gender])
      string += " AND gender_id: #{@gender.id}"
    end
    string
  end
end

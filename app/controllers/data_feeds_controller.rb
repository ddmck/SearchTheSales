class DataFeedsController < ApplicationController
  before_action :set_data_feed, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @data_feeds = DataFeed.all
    respond_with(@data_feeds)
  end

  def show
    respond_with(@data_feed)
  end

  def new
    @stores = Store.all
    @data_feed = DataFeed.new
    respond_with(@data_feed)
  end

  def edit
    @stores = Store.all
  end

  def create
    @data_feed = DataFeed.new(data_feed_params)
    @data_feed.save
    respond_with(@data_feed)
  end

  def update
    @data_feed.update(data_feed_params)
    respond_with(@data_feed)
  end

  def destroy
    @data_feed.destroy
    respond_with(@data_feed)
  end

  private
  def set_data_feed
    @data_feed = DataFeed.find(params[:id])
  end

  def data_feed_params
    params.require(:data_feed).permit(:feed_url, 
                                      :store_id, 
                                      :name_column, 
                                      :description_column, 
                                      :rrp_column, 
                                      :sale_price_column, 
                                      :link_column, 
                                      :image_url_column, 
                                      :brand_column, 
                                      :size_column, 
                                      :color_column, 
                                      :gender_column, 
                                      :category_column)
  end
end

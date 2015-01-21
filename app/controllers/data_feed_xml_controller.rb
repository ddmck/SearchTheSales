class DataFeedXmlController < ApplicationController
  before_action :set_data_feed_xml, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @data_feed_xmls = DataFeedXml.all
    respond_with(@data_feed_xmls)
  end

  def show
    respond_with(@data_feed_xml)
  end

  def new
    @stores = Store.all
    @data_feed_xml = DataFeedXml.new
    respond_with(@data_feed_xml)
  end

  def edit
    @stores = Store.all
  end

  def create
    @data_feed_xml = DataFeedXml.new(data_feed_params)
    @data_feed_xml.save
    respond_with(@data_feed_xml)
  end

  def update
    @data_feed_xml.update(data_feed_params)
    respond_with(@data_feed_xml)
  end

  def destroy
    @data_feed_xml.destroy
    respond_with(@data_feed_xml)
  end

  def get_feed_url
    @data_feed_xmls = DataFeedXml.all
    respond_with(@data_feed_xmls.pluck(:feed_url))
  end

  private
  def set_data_feed_xml
    @data_feed = DataFeedXml.find(params[:id])
  end

  def data_feed_params
    params.require(:data_feed_xml).permit(:feed_url, 
                                      :store_id, 
                                      :name_column, 
                                      :description_column, 
                                      :rrp_column, 
                                      :sale_price_column, 
                                      :link_column, 
                                      :image_url_column,
                                      :large_image_url_column,
                                      :brand_column, 
                                      :size_column, 
                                      :color_column, 
                                      :gender_column, 
                                      :category_column)
  end
end

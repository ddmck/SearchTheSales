class FeatureLinksController < ApplicationController
  before_action :set_feature
  before_action :set_feature_link, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @feature_links = FeatureLink.all
    respond_with(@feature_links)
  end

  def show
    respond_with(@feature_link)
  end

  def new
    @feature_link = @feature.feature_links.build
    respond_with([@feature, @feature_link])
  end

  def edit
  end

  def create
    @feature_link = @feature.feature_links.build(feature_link_params)
    @feature_link.save
    respond_with(@feature)
  end

  def update
    @feature_link.update(feature_params)
    respond_with(@feature_link)
  end

  def destroy
    @feature_link.destroy
    respond_with(@feature_link)
  end

  private
  def set_feature
    @feature = Feature.friendly.find(params[:feature_id])
  end

  def set_feature_link
    @feature_link = FeatureLink.find(params[:id])
  end

  def feature_link_params
    params.require(:feature_link).permit(:name, :link_url)
  end
end
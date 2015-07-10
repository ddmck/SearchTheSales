class RecommendationItemsController < ApplicationController
  before_action :set_recommendation_item, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @recommendation_items = RecommendationItem.all
    respond_with(@recommendation_items)
  end

  def show
    respond_with(@recommendation_item)
  end

  def new
    @recommendation_item = RecommendationItem.new
    respond_with(@recommendation_item)
  end

  def edit
  end

  def create
    puts params
    @recommendation_item = Recommendation.find(params[:recommendation_id]).recommendation_items.build(recommendation_item_params)
    puts @recommendation_item.attributes
    @recommendation_item.save
    respond_with(@recommendation_item, status: 201)
  end

  def update
    @recommendation_item.update(recommendation_item_params)
    respond_with(@recommendation_item)
  end

  def destroy
    @recommendation_item.destroy
    respond_with(@recommendation_item)
  end

  private
    def set_recommendation_item
      @recommendation_item = RecommendationItem.find(params[:id])
    end

    def recommendation_item_params
      params.require(:recommendation_item).permit(:product_id, :recommendation_id, :description, :index, :liked)
    end
end

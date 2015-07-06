class RecommendationsController < ApplicationController
  before_action :set_recommendation, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    if current_user
      @recommendations = current_user.recommendations
      respond_with(@recommendations, status: 200)
    else
      respond_with([], status: 401)
    end
  end

  def show
    respond_with(@recommendation)
  end

  def show_recommendations
    @recommendations = User.find(params[:id]).recommendations
    respond_with(@recommendations)
  end

  def new
    @recommendation = Recommendation.new
    respond_with(@recommendation)
  end

  def edit
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.save
    respond_with(@recommendation)
  end

  def update
    @recommendation.update(recommendation_params)
    respond_with(@recommendation)
  end

  def destroy
    @recommendation.destroy
    respond_with(@recommendation)
  end

  private
    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end

    def recommendation_params
      params.require(:recommendation).permit(:user_id, :sender_id, :product_id, :description, :title)
    end
end

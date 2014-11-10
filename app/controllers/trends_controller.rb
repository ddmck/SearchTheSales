class TrendsController < ApplicationController
  before_action :set_trend, only: [:show, :edit, :update, :destroy]

  def index
    @trends = Trend.all
    respond_with(@trends)
  end

  def show
    respond_with(@trend)
  end

  def new
    @trend = Trend.new
    respond_with(@trend)
  end

  def edit
  end

  def create
    @trend = Trend.new(trend_params)
    @trend.save
    respond_with(@trend)
  end

  def update
    @trend.update(trend_params)
    respond_with(@trend)
  end

  def destroy
    @trend.destroy
    respond_with(@trend)
  end

  private

  def set_trend
    @trend = Trend.find(params[:id])
  end

  def trend_params
    params.require(:trend).permit(:name)
  end
end

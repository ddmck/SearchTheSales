class ColorTagsController < ApplicationController
  before_action :set_color_tag, only: [:show, :edit, :update, :destroy]

  def index
    @color_tags = ColorTag.all
    respond_with(@color_tags)
  end

  def show
    respond_with(@color_tag)
  end

  def new
    @color_tag = ColorTag.new
    respond_with(@color_tag)
  end

  def edit
  end

  def create
    @color_tag = ColorTag.new(color_tag_params)
    @color_tag.save
    respond_with(@color_tag)
  end

  def update
    @color_tag.update(color_tag_params)
    respond_with(@color_tag)
  end

  def destroy
    @color_tag.destroy
    respond_with(@color_tag)
  end

  private

  def set_color_tag
    @color_tag = ColorTag.find(params[:id])
  end

  def color_tag_params
    params.require(:color_tag).permit(:color_id, :product_id)
  end
end

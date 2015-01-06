class WishlistItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :html, :json

  def index
    items = WishlistItem.where(user_id: get_current_user.id)
    respond_with(items)
  end

  def create
    item = WishlistItem.new(item_params)
    item.user_id = get_current_user.id
    puts "Items attributes: #{item.attributes}"
    if item.save
      respond_with(item, status: 200)
    else
      respond_with(item, status: 500)
    end
  end

  def destroy
    item = WishlistItem.find(params[:id])
    if item.destroy
      respond_with(item, status: 200)
    else
      respond_with(item, status: 500)
    end
  end

  private

  def item_params
    params.require(:wishlist_item).permit(:product_id)
  end

end
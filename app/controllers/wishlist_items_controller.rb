class WishlistItemsController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  respond_to :html, :json

  def index
    if current_user

      @wishlist_items = current_user.wishlist_items.includes(:product)
      respond_with(@wishlist_items, status: 200)
    else
      @wishlist_items = []
      respond_with(@wishlist_items, status: 401)
    end
  end

  def create
    @wishlist_item = current_user.wishlist_items.build(item_params)
    puts @wishlist_item
    # puts @wishlist_item_params
    if @wishlist_item.save
      respond_with(@wishlist_item, status: 200)
    else
      respond_with(@wishlist_item, status: 500)
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
    params.require(:params).permit(:product_id)
  end

end

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @orders = Order.where(user_id: current_user.id)
    respond_with(@orders)
  end

  def show
    respond_with(@order)
  end

  def new
    @order = Order.new
    respond_with(@order)
  end

  def edit
  end

  def create
    user = current_user
    if user
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
      unless user.stripe_customer_id
        resp = Stripe::Customer.create(
          :description => "Customer for #{user.email}",
          :card => order_params[:token]
        )
        user.stripe_customer_id = resp.id
        user.save
      end
      
      @order = current_user.orders.build(address: order_params[:address])
      @order.save
      order_params[:basket].each do |product|
        oi = @order.order_items.build(product_id: product[:productId], size_id: product[:sizeId])
        oi.save
      end
      @order.order_items.each do |oi|
        oi.create_invoice_item
      end
      order_params[:deliveries].each do |delivery|
        @order.create_delivery_invoice_item(delivery)
      end

      respond_with(@order)
    end
  end

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit!
    end
end

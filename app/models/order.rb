class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  serialize :address, Hash

  def total
    sum = 0
    order_items.each{|oi| sum += oi.product.display_price}
    sum
  end

  def display_order_items
    order_items.map do |oi|
      {
        product_id: oi.product.id,
        name: oi.product.name,
        image_url: oi.product.image_url,
        display_price: oi.product.display_price
      }
    end
  end
end

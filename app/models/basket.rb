class Basket < ActiveRecord::Base
  belongs_to :user
  has_many :basket_items
  has_many :products, through: :basket_items

  def create_basket_item(product)
    BasketItem.create(basket_id: self.id, product_id: product.id)
  end

  def total_price
    total = 0
    products.each do |product|
      total += product.sale_price
    end
    total
  end
end

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :size

  def create_invoice_item
    Stripe::InvoiceItem.create(
      :customer => self.order.user.stripe_customer_id,
      :amount => (self.product.display_price * 100).to_i,
      :currency => "gbp",
      :description => "#{self.product.name.titleize} Size: #{self.size.name}, url: #{self.product.url}",
      :metadata => {
        :name => self.product.name.titleize,
        :size => self.size.name,
        :url => self.product.url,
        :id => "#{self.product.id}"
      }
    )
  end
end

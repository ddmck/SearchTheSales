class WishlistItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :product_id, uniqueness: { scope: :user_id }

  def product_json
    attrb = product.attributes
    attrb[:brand_name] = product.brand.name
    attrb
  end

end

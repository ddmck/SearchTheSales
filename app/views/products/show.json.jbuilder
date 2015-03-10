json.extract! @product, :id, :brand_id, :store_id, :url, :image_url, :large_image_url, :image_urls, :description, :gender, :sizes, :display_price
json.name @product.name.titleize
json.brand_name @product.pretty_brand_name
json.brand_slug @product.brand.slug
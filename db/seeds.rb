##Start of Seed for backend setup
category_list = [
  ["shoes", false],
  ["accessories", false],
  ["jackets", false],
  ["shorts", false],
  ["suits", false],
  ["underwear", false],
  ["sweats", false],
  ["knitwear", false],
  ["tops", false],
  ["tees", false],
  ["bags", false],
  ["jeans", false],
  ["trousers", false],
  ["polos", false],
  ["swimwear", false],
  ["hoodies", false],
  ["lingerie", true],
  ["playsuits", true],
  ["blouses", true],
  ["dresses", true],
  ["skirts", true],
]

Gender.create(name: "male")
Gender.create(name: "female")
Store.create(name: "Urban Outfitters")

category_list.each do |name, female_only|
  Category.create(name: name, female_only: female_only)
end

DataFeed.create(feed_url: "http://datafeed.api.productserve.com/datafeed/download/apikey/5ceb2936022c9df973e19221f267ec28/cid/97,98,142,144,146,129,595,539,147,149,613,626,135,163,168,159,169,161,167,170,137,171,548,174,183,178,179,175,172,623,139,614,189,194,141,205,198,206,203,208,199,204,201/fid/2077/columns/aw_product_id,merchant_product_id,merchant_category,aw_deep_link,merchant_image_url,search_price,description,product_name,rrp_price,display_price,specifications,brand_name,size,colour/format/csv/delimiter/,/compression/zip/adultcontent/0/", 
                store_id: "1", 
                name_column: "product_name",   
                description_column: "description",
                rrp_column: "rrp_price",
                sale_price_column: "display_price",
                link_column: "aw_deep_link",
                image_url_column: "merchant_image_url",
                brand_column: "brand_name",
                size_column: "size",
                color_column: "color",
                gender_column: "merchant_category",
                category_column: "merchant_category",
                large_image_url_column: "merchant_image_url",
                image_assets: "UrbanOutfittersImageImporter" )

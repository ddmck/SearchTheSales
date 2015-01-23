json.array!(@data_feed_xmls) do |data_feed|
  json.extract! data_feed, :id, :file, :host, :user_name, :password, :store_id, :name_column, :description_column, :rrp_column, :sale_price_column, :link_column, :image_url_column, :brand_column, :size_column, :color_column
  json.url data_feed_xml_url(data_feed, format: :json)
end

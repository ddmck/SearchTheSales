class ReissImageImporter
  def import
    s = Store.find(56)

    prod = s.products.where(image_urls: nil)

    prod.each do |p|
      image_urls = generate_image_urls(p)
      p.image_urls = image_urls
      p.save
    end
  end
  handle_asynchronously :import, :queue => 'data_feeds'

  def generate_image_urls(p)
    image_urls = []
    
    base_url = p.image_url

    accessories = Category.find_by_name("accessories")


    if p.category_id == accessories.id
      image_urls << get_image_url(base_url, 1)
      return image_urls
    else
      (1..5).each do |i|
        image_urls << get_image_url(base_url, i)
      end
      return image_urls
    end
    return image_urls
  end

  def get_image_url(url, count)
    return url.to_s.gsub(/-1/, "-#{count}")
  end
end
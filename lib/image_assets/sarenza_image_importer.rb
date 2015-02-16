class SarenzaImageImporter
  def import
    s = Store.find_by_name("sarenza")

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

    (3..9).each do |i|
      image_urls << get_image_url(base_url, i)
    end

    return image_urls 
  end

  def get_imgage_url(url, count)
    return url.to_s.gsub(/_09/, "_0#{count}")
  end
end
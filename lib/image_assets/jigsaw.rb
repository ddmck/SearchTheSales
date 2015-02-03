class Jigsaw
  def self.import
    s = Store.find_by_name("jigsaw")

    prod = s.products

    prod.each do |p|
      image_urls = generate_image_urls(p)
      p.image_urls = image_urls
      p.save
    end
  end

  def self.generate_image_urls(p)
    image_urls = []
    
    base_url = p.image_url

    image_urls << grab_image_url(base_url)

    return image_urls 
  end

  def self.grab_image_url(url)
    return url.gsub(/_1/, '_2').to_s
  end
end

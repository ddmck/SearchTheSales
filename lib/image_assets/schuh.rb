class Schuh
  def self.import
    s = Store.find_by_name("schuh")

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

    image_urls << main_to_zm(base_url)

    (1..7).each do |i|
      image_urls << main_to_zm_numb(base_url, i)
    end

    return image_urls 
  end

  def self.main_to_zm_numb(url, count)
    return url.to_s.gsub(/_main/, "m#{count}_zm")
  end

  def self.main_to_zm(url)
    return url.gsub(/_main/, '_zm').to_s
  end
end

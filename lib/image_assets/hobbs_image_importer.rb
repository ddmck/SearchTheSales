class HobbsImageImporter
  def import(import_all=false)
    s = Store.find(68)

    if import_all
      prod = s.products
    else
      prod = s.products.where(image_urls: nil)
    end
    
    prod.each do |p|
      p.image_urls = generate_image_urls(p)
      p.save
    end
  end
  # handle_asynchronously :import, :queue => 'data_feeds'

  def generate_image_urls(p)
    image_urls = []
    base_url = p.image_url

    (1..3).each do |i|
      image_urls << extract_images(base_url, i)
    end
    image_urls
  end

  def extract_images(url, count)
    return url.gsub(/_01_/, "_0#{count}_")
  end
end
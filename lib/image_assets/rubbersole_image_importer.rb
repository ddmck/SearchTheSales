class RubbersoleImageImporter
  def import(import_all=false)
    s = Store.find(11)

    if import_all
      prod = s.products
    else
      prod = s.products.where(image_urls: nil)
    end
    
    prod.each do |p|
      image_urls = generate_image_urls(p)
      p.image_urls = image_urls
      p.save
    end
  end
  handle_asynchronously :import, :queue => 'data_feeds'

  def generate_image_urls(p)
    image_urls = []
    normArr = ['A','B','C','D','E','F','G']

    base_url = p.image_url

    normArr.each do |i|
      image_urls << get_image_url(base_url, i)
    end

    return image_urls 
  end

  def get_image_url(url, count)
    return url.to_s.gsub(/_A/, "_#{count}")
  end
end

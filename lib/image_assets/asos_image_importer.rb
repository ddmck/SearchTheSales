class AsosImageImporter
  def import
    s = Store.find(1)

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

    image_urls << grab_larger_image(base_url)

    (2..4).each do |i|
      image_urls << grab_larger_image_numb(base_url, i)
    end

    return image_urls 
  end

  def grab_larger_image_numb(url, count)
    return url.gsub(/\/\w+\/\w+\d\w+.\w+$/, "\/image#{count}xxl.jpg").to_s
  end

  def grab_larger_image(url)
    return  url.to_s.gsub(/image1xl/, 'image1xxl')
  end
end
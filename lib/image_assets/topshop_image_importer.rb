class TopshopImageImporter
  def import(import_all=false)
    s = Store.find(49)

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
    base_url = p.image_url

    bags = Category.find_by_name("bags")
    shoes = Category.find_by_name("shoes")
    accessories = Category.find_by_name("accessories")

    image_urls << normal_to_large(base_url)

    if p.category_id == accessories.id
      return image_urls
    elsif p.category_id == bags.id || p.category_id == shoes.id
      (2..3).each do |i|
        image_urls << extract_images(base_url, i)
      end
      return image_urls
    else 
      (2..4).each do |i|
        image_urls << extract_images(base_url, i)
      end
      return image_urls 
    end
  end

  def normal_to_large(url)
    return url.gsub(/_normal/, '_large').to_s
  end

  def extract_images(url, count)
    return url.gsub(/_normal/, "_#{count}_large")
  end
end
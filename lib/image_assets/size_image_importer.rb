class SizeImageImporter
  def import(import_all=false)
    s = Store.find(50)

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

    normArr = ['a','b']
    charArr = ['a','b','c','d']
    
    base_url = p.image_url

    tees = Category.find_by_name("tees")
    shoes = Category.find_by_name("shoes")
    jackets = Category.find_by_name("jackets")

    if p.category_id == tees.id
      return image_urls
    elsif p.category_id != shoes.id || jackets.id
      normArr.each do |i|
        image_urls << change_char_value(base_url, i)
      end
      return image_urls
    else 
      charArr.each do |i|
        image_urls << change_char_value(base_url, i)
      end
      return image_urls 
    end
  end

  def change_char_value(url, char)
    return url.to_s.gsub(/_a\?/, "_#{char}\?")
  end
end
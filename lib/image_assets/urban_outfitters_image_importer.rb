class UrbanOutfittersImageImporter
  def import
    s = Store.find(33)

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


    normArr = ['a','b','d','e']
    charArr = ['a','b','d','e']
    
    base_url = p.image_url

    accessories = Category.find_by_name("accessories")

    if p.category_id == accessories.id
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
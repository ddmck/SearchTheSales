class FrenchConnectionImageImporter
  def import
    s = Store.find_by_name("french connection")

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

    image_urls << model_to_blank(base_url)

    (2..3).each do |i|
      image_urls << model_to_numb(base_url, i)
    end

    return image_urls
  end

  def model_to_numb(url, count)
    return url.to_s.gsub(/_model/, "_#{count}")
  end

  def model_to_blank(url)
    return url.gsub(/_model/, '').to_s
  end
end
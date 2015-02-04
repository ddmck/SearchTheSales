class Hobbs
  def import
    s = Store.find_by_name("Topshop")

    prod = s.products.where(image_urls: nil)

    prod.each do |p|
      image_urls = generate_image_urls(p)
      p.image_urls = image_urls
      p.save
    end
  end
  handle_asynchronously :import, :queue => 'data_feeds'

  def self.generate_image_urls(p)
    image_urls = []
    base_url = p.image_url

      (2..3).each do |i|
        image_urls << extract_images(base_url, i)
      end
  end

  def self.extract_images(url, count)
    return url.gsub(/_01_/, "_0#{count}_")
  end
end
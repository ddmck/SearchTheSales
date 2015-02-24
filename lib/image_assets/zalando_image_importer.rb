require 'net/http'

class ZalandoImageImporter
  def import
    s = Store.find(30)

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
    count = 1
    base_url = p.image_url

    (1..15).each do |i|
      next if i != count
      res = grab_res(base_url, i)
      if res.code == "200"
        image_urls << grab_image_url(base_url, i)
        count += 1
      else
        count += 2
      end
    end
    return image_urls 
  end

  def grab_image_url(url, count)
    return url.to_s.gsub(/\@\d+/, "\@#{count}")
  end

  def grab_uri(base_url, count)
    return URI.parse(grab_image_url(base_url, count))
  end

  def grab_res(base_url, i)
    uri = grab_uri(base_url, i)
    return Net::HTTP.get_response(uri)
  end
end

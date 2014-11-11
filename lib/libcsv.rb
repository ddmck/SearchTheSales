class CSVParser

  def self.import(file)
    SmarterCSV.process(file, {chunk_size: 100 }) do |chunk|
      chunk.map! do |row|
        data = {
          store: row[:merchant_name].to_s,
          brand: row[:brand].to_s,
          category: row[:category],
          sub_categories: (row[:subcategory].try(:split,',') || []).map! {|e| e.strip},
          colors: (row[:colour].try(:split,',') || []).map! {|e| e.strip},
          name: row[:name],
          description: row[:description],
          url: row[:deep_link],
          image_url: row[:image_url],
          rrp: row[:rrp_price],
          sale_price: row[:display_price],
          gender: row[:gender]
        }
        data
      end
      Resque.enqueue(ProductImporter, chunk)
    end
  end

end
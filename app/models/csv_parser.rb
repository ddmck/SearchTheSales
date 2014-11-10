class CSVParser
  
  def self.import(file)
    start_time = Time.now
    SmarterCSV.process(file, {chunk_size: 2 }) do |chunk|
      chunk.each do |row|
        puts row
        data = {
          store: row[:merchant_name].to_s,
          brand: row[:brand].to_s,
          category: row[:category],
          sub_categories: row[:subcategory].try(:split,',') || [],
          colors: row[:colour].try(:split,',') || [],
          name: row[:name],
          description: row[:description],
          url: row[:deep_link],
          image_url: row[:image_url],
          rrp: row[:rrp_price],
          sale_price: row[:display_price],
          gender: row[:gender]
        }
        ProductImport.import(data)
      end
    end
    end_time = Time.now

    puts "Time taken: #{end_time - start_time}"
  end


end
class ProductImporter
  @queue = :importer_queue

  def self.perform(chunk)
    ProductImport.import_chunk(chunk)
  end
end

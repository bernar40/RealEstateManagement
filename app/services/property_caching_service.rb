class PropertyCachingService
  def self.cache_all_properties
    # Logic to fetch and cache all properties
    updated_properties = Property.all.load
    Rails.cache.write('all_properties', updated_properties, expires_in: 1.hour)
  end
end

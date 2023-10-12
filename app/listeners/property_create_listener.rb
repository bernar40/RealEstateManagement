class PropertyCreateListener
  def property_created(property)
    PropertyCachingService.cache_all_properties

    Rails.logger.info("\nNotification: New Property added to catalog - #{property.name}\n")
  end
end

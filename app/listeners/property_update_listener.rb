class PropertyUpdateListener
  def property_updated(property)
    PropertyCachingService.cache_all_properties

    Rails.logger.info("\nNotification: Property #{property.name} was updated\n")
  end
end

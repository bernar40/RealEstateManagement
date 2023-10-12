class PropertyDeletionListener
  def property_deleted(property)
    PropertyCachingService.cache_all_properties

    Rails.logger.info("\nNotification: Property #{property.name} was deleted from catalog\n")
  end
end

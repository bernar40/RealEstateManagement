class PropertyAssignedListener
  def property_assigned(property, agent)
    PropertyCachingService.cache_all_properties

    Rails.logger.info("\nNotification: Property #{property.name} was assigned to #{agent.fullname}\n")
  end
end

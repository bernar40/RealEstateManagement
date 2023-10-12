Rails.application.reloader.to_prepare do
  Wisper.subscribe(PropertyAssignedListener.new)
  Wisper.subscribe(PropertyDeletionListener.new, PropertyUpdateListener.new, PropertyCreateListener.new)
end
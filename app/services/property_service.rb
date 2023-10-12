class PropertyService
  include Wisper::Publisher

  def initialize(property_repository)
    @property_repository = property_repository
  end

  def find_all_properties
    Rails.cache.fetch('all_properties', expires_in: 1.hour) do
      @property_repository.all
    end
  end

  def create_property(property_params)
    property = @property_repository.new_entity(property_params)
  
    if @property_repository.save(property)
      broadcast(:property_created, property)
    end

    property
  end
  

  def assign_property_to_agent(property, agent)
    @property_repository.assign_to_agent(property, agent)
    if @property_repository.save(property)
      broadcast(:property_assigned, property, agent)
    end

    property
  end

  def update_property(property, property_params)
    @property_repository.update(property, property_params)
    if @property_repository.save(property)
      broadcast(:property_updated, property)
    end

    property
  end

  def destroy_property(property)
    if @property_repository.delete(property)
      broadcast(:property_deleted, property)
    end

    property
  end
end

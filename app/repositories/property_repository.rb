class PropertyRepository
  def all
    Property.all.load
  end

  def find(id)
    Property.find(id)
  end

  def new_entity(attrs = nil)
    Property.new(attrs)
  end

  def save(property)
    property.save
  end

  def delete(property)
    property.destroy
  end

  def update(property, params)
    property.update(params)
  end

  def assign_to_agent(property, agent)
    property.update(agent: agent)
  end
end

require 'rails_helper'

RSpec.describe PropertyRepository do
  let(:repository) { PropertyRepository.new }

  describe '#all' do
    it 'returns all properties' do
      property1 = create(:property, name: 'Property 1', location: 'Location 1', price: 100, status: 'Available')
      property2 = create(:property, name: 'Property 2', location: 'Location 2', price: 200, status: 'Sold')

      properties = repository.all

      expect(properties).to include(property1)
      expect(properties).to include(property2)
    end
  end

  describe '#find' do
    it 'finds a property by ID' do
      property = create(:property, name: 'Test Property', location: 'Test Location', price: 300, status: 'Available')
      found_property = repository.find(property.id)

      expect(found_property).to eq(property)
    end
  end

  describe '#new_entity' do
    it 'creates a new property entity with attributes' do
      attrs = { name: 'New Property', location: 'New Location', price: 400, status: 'Available' }
      property = repository.new_entity(attrs)

      expect(property).to be_an_instance_of(Property)
      expect(property.name).to eq(attrs[:name])
      expect(property.location).to eq(attrs[:location])
      expect(property.price).to eq(attrs[:price])
      expect(property.status).to eq(attrs[:status])
    end
  end

  describe '#save' do
    it 'saves a property' do
      property = build(:property, name: 'Save Property', location: 'Save Location', price: 500, status: 'Available')
      repository.save(property)

      expect(property.persisted?).to be true
    end
  end

  describe '#delete' do
    it 'deletes a property' do
      property = create(:property, name: 'Delete Property', location: 'Delete Location', price: 600, status: 'Available')
      repository.delete(property)

      expect(Property.find_by(id: property.id)).to be_nil
    end
  end

  describe '#update' do
    it 'updates a property with new attributes' do
      property = create(:property, name: 'Update Property', location: 'Update Location', price: 700, status: 'Available')
      new_attrs = { name: 'Updated Property', price: 800 }
      repository.update(property, new_attrs)

      property.reload

      expect(property.name).to eq(new_attrs[:name])
      expect(property.price).to eq(new_attrs[:price])
    end
  end

  describe '#assign_to_agent' do
    it 'assigns a property to an agent' do
      property = create(:property, name: 'Agent Property', location: 'Agent Location', price: 900, status: 'Available')
      agent = create(:agent, first_name: 'John', last_name: 'Doe')
      repository.assign_to_agent(property, agent)
      repository.save(property)
      
      property.reload

      expect(property.agent).to eq(agent)
    end
  end
end

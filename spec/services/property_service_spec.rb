require 'rails_helper'

RSpec.describe PropertyService do
  let(:property_repository) { double('PropertyRepository') }
  let(:property_service) { PropertyService.new(property_repository) }
  let(:property_params) { { name: 'Test Property', location: 'Test Location', price: 300, status: 'Available' } }
  let(:property_params_error) { { name: 'Test Property', location: 'Test Location', price: 300, status: 'Error' } }
  let(:property_params_sold) { { name: 'Test Property', location: 'Test Location', price: 300, status: 'Sold' } }
  let(:property) { build(:property, property_params) }
  let(:property_error) { build(:property, property_params_error) }
  let(:property_sold) { build(:property, property_params_sold) }
  let(:agent) { build(:agent) }

  describe '#find_all_properties' do
    it 'returns all properties from the repository' do
      properties = [property, build(:property, name: 'Property 2')]
      allow(property_repository).to receive(:all).and_return(properties)

      result = property_service.find_all_properties

      expect(result).to eq(properties)
    end
  end

  describe '#create_property' do
    it 'creates a new property and returns a property object' do
      allow(property_repository).to receive(:new_entity).with(property_params).and_return(property)
      allow(property_repository).to receive(:save).with(property).and_return(true)
      expect(property_service).to receive(:broadcast).with(:property_created, property)
    
      result = property_service.create_property(property_params)
    
      expect(result).to be_an_instance_of(Property)
    end

    it 'creates a new property and returns false if unsuccessful' do
      allow(property_repository).to receive(:new_entity).with(property_params_error).and_return(property_error)
      allow(property_repository).to receive(:save).with(property_error).and_return(false)

      result = property_service.create_property(property_params_error)

      expect(result.valid?).to be false
    end
  end

  describe '#assign_property_to_agent' do
    it 'assigns a property to an agent and returns the property object if successful' do
      allow(property_repository).to receive(:assign_to_agent).with(property, agent)
      allow(property_repository).to receive(:save).with(property).and_return(true)
      expect(property_service).to receive(:broadcast).with(:property_assigned, property, agent)

      result = property_service.assign_property_to_agent(property, agent)

      expect(result).to eq(property)
    end

    it 'assigns a property to an agent and returns the property object if unsuccessful' do
      allow(property_repository).to receive(:assign_to_agent).with(property_sold, agent)
      allow(property_repository).to receive(:save).with(property_sold).and_return(false)

      result = property_service.assign_property_to_agent(property_sold, agent)

      expect(result).to eq(property_sold)
    end
  end

  describe '#update_property' do
    it 'updates a property and returns the property object if successful' do
      property_params = { name: 'Updated Property' }
      allow(property_repository).to receive(:update).with(property, property_params)
      allow(property_repository).to receive(:save).with(property).and_return(true)
      expect(property_service).to receive(:broadcast).with(:property_updated, property)

      result = property_service.update_property(property, property_params)

      expect(result).to eq(property)
    end

    it 'updates a property and returns the property object if unsuccessful' do
      property_params = { name: 'Updated Property' }
      allow(property_repository).to receive(:update).with(property, property_params)
      allow(property_repository).to receive(:save).with(property).and_return(false)

      result = property_service.update_property(property, property_params)

      expect(result).to eq(property)
    end
  end

  describe '#destroy_property' do
    it 'destroys a property and returns the property object if successful' do
      allow(property_repository).to receive(:delete).with(property).and_return(true)
      expect(property_service).to receive(:broadcast).with(:property_deleted, property)

      result = property_service.destroy_property(property)

      expect(result).to eq(property)
    end

    it 'destroys a property and returns the property object if unsuccessful' do
      allow(property_repository).to receive(:delete).with(property).and_return(false)

      result = property_service.destroy_property(property)

      expect(result).to eq(property)
    end
  end
end

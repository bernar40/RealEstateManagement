require 'rails_helper'

RSpec.describe Property, type: :model do
  it 'is valid with valid attributes' do
    property = build(:property) # Using the factory to create a property
    expect(property).to be_valid
  end

  it 'is not valid without a name' do
    property = build(:property, name: nil)
    expect(property).to_not be_valid
  end

  it 'is not valid without a location' do
    property = build(:property, location: nil)
    expect(property).to_not be_valid
  end

  it 'is not valid without a price' do
    property = build(:property, price: nil)
    expect(property).to_not be_valid
  end

  it 'is not valid without a status' do
    property = build(:property, status: nil)
    expect(property).to_not be_valid
  end

  it 'belongs to an agent' do
    association = Property.reflect_on_association(:agent)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'does not allow assignment when status is Sold' do
    property = create(:property, status: 'Available') # Create a property with an available status
    property.status = 'Sold' # Change the status to Sold
    property.agent_id = 1 # Change the agent_id
    expect(property).not_to be_valid
  end

  it 'allows assignment when status is not Sold' do
    property = create(:property, status: 'Available') # Create a property with an available status
    property.agent_id = 1 # Change the agent_id without changing the status
    expect(property).to be_valid
  end
end

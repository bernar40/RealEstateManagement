require 'rails_helper'

RSpec.describe Agent, type: :model do
  it 'is valid with valid attributes' do
    agent = build(:agent) # Using the factory to create an agent
    expect(agent).to be_valid
  end

  it 'is not valid without a first name' do
    agent = build(:agent, first_name: nil)
    expect(agent).to_not be_valid
  end

  it 'is not valid without a last name' do
    agent = build(:agent, last_name: nil)
    expect(agent).to_not be_valid
  end

  it 'is not valid without an email' do
    agent = build(:agent, email: nil)
    expect(agent).to_not be_valid
  end

  it 'has many properties' do
    association = Agent.reflect_on_association(:properties)
    expect(association.macro).to eq(:has_many)
  end
end

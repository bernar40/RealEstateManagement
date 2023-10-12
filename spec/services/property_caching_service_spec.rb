require 'rails_helper'

RSpec.describe PropertyCachingService, type: :service do
  it 'caches all properties for 1 hour' do
    # Create some properties for testing
    properties = create_list(:property, 3) # Use your factory method

    # Ensure the cache is initially empty
    expect(Rails.cache.fetch('all_properties')).to be_nil

    # Cache the properties using the service
    PropertyCachingService.cache_all_properties

    # Check if the cache exists
    expect(Rails.cache.exist?('all_properties')).to be_truthy

    # Check if the cache will expire in approximately 1 hour
    expect(Rails.cache.fetch('all_properties', expires_in: 1.hour)).to match_array(properties)
  end
end

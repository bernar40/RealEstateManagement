require 'rails_helper'

RSpec.describe 'Cache', type: :model do
  it 'stores and retrieves data from the cache' do
    # Define a cache key and value
    cache_key = 'test_cache_key'
    cache_value = 'test_cache_value'

    # Store data in the cache
    Rails.cache.write(cache_key, cache_value, expires_in: 5.second)

    # Retrieve data from the cache
    retrieved_value = Rails.cache.read(cache_key)

    # Assert that the retrieved data matches the expected value
    expect(retrieved_value).to eq(cache_value)
  end
end

require 'swagger_helper'

RSpec.describe 'Properties API', type: :request do
  path '/properties' do
    get 'Retrieves a list of properties' do
      tags 'Properties'
      produces 'application/json'

      response '200', 'List of properties' do
        run_test!
      end
    end

    post 'Creates a property' do
      tags 'Properties'
      consumes 'application/json'
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          location: { type: :string },
          price: { type: :number },
          status: { type: :string },
        },
        required: ['name', 'location', 'price', 'status']
      }

      response '201', 'Property created' do
        let(:property) { create(:property) }
        run_test!
      end

      response '422', 'Property not created' do
        let(:property) { { name: 'Property without required fields' } } # Invalid property data
        run_test!
      end
    end
  end

  path '/properties/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a specific property by ID' do
      tags 'Properties'
      produces 'application/json'

      response '200', 'Property found' do
        let(:id) { create(:property).id }
        run_test!
      end

      response '404', 'Property not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end

    put 'Updates a property by ID' do
      tags 'Properties'
      consumes 'application/json'
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          location: { type: :string },
          price: { type: :number },
          status: { type: :string },
        },
        required: []
      }

      response '200', 'Property updated' do
        let(:id) { create(:property).id }
        let(:property) { { name: 'Updated Property' } }
        run_test!
      end

      response '404', 'Property not found' do
        let(:property) { {} } # Declare the 'property' parameter, even if it's empty or not used
        let(:id) { 'nonexistent_id' }
        run_test!
      end

      response '422', 'Property not updated' do
        let(:property) { { name: nil } } # Invalid property data
        let(:id) { create(:property).id }
        run_test!
      end
    end

    delete 'Deletes a property by ID' do
      tags 'Properties'
      response '204', 'Property deleted' do
        let(:id) { create(:property).id }
        run_test!
      end

      response '404', 'Property not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end

      response '422', 'Property not deleted' do
        let(:id) { create(:property).id }
        before do
          allow_any_instance_of(PropertyService).to receive(:destroy_property).and_return(false)
        end
        run_test!
      end
    end
  end
end

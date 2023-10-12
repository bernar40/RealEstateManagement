require 'swagger_helper'

RSpec.describe 'PropertyAssignments', type: :request do
  path '/property_assignments' do
    post 'Assign a property to an agent' do
      tags 'Property Assignments'
      consumes 'application/json'
      parameter name: :property_id, in: :query, type: :integer, required: true
      parameter name: :agent_id, in: :query, type: :integer, required: true

      context 'when the property and agent are valid' do
        response '200', 'Property assigned successfully' do
          let(:property) { create(:property) } # Create a valid property
          let(:agent) { create(:agent) } # Create a valid agent
          let(:property_id) { property.id }
          let(:agent_id) { agent.id }

          run_test!
        end
      end

      context 'when the property is invalid' do
        response '404', 'Property not found' do
          let(:property_id) { 'invalid' } # Invalid property ID
          let(:agent_id) { 1 } # Valid agent ID

          run_test!
        end
      end

      context 'when the agent is invalid' do
        response '404', 'Agent not found' do
          let(:property) { create(:property) } # Create a valid property
          let(:agent_id) { 'invalid' } # Invalid agent ID
          let(:property_id) { property.id }

          run_test!
        end
      end

      context 'when both property and agent are invalid' do
        response '404', 'Property not found' do
          let(:property_id) { 'invalid' } # Invalid property ID
          let(:agent_id) { 'invalid' } # Invalid agent ID

          run_test!
        end
      end

      context 'when the property status is "Sold"' do
        response '422', 'Property status is Sold' do
          let(:property) { create(:property, status: 'Sold') } # Create a property with status "Sold"
          let(:agent) { create(:agent) } # Create a valid agent
          let(:property_id) { property.id }
          let(:agent_id) { agent.id }

          run_test!
        end
      end
    end
  end
end

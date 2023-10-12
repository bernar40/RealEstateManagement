# agent_repository_spec.rb

require 'rails_helper'

RSpec.describe AgentRepository, type: :repository do
  describe '#find' do
    it 'returns an agent by ID' do
      agent = create(:agent)
      agent_repository = AgentRepository.new
      found_agent = agent_repository.find(agent.id)

      expect(found_agent).to eq(agent)
    end

    it 'returns nil if the agent is not found' do
      agent_repository = AgentRepository.new
    
      # Use an ID that does not exist in your database
      expect { agent_repository.find(999) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

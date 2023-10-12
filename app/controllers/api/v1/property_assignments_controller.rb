# app/controllers/api/v1/property_assignments_controller.rb

module Api
  module V1
    class PropertyAssignmentsController < ApplicationController
      def create
        property = property_repository.find(params[:property_id])
        agent = agent_repository.find(params[:agent_id])

        property = property_service.assign_property_to_agent(property, agent)
        if property.errors.empty?
          render json: { message: 'Property assigned successfully' }, status: :ok
        else
          render json: { error: 'Property assignment failed - Cannot assign property that is already sold' }, status: :unprocessable_entity
        end
      end

      private

      def property_service
        @property_service ||= PropertyService.new(property_repository)
      end

      def property_repository
        @property_repository ||= PropertyRepository.new
      end

      def agent_repository
        @agent_repository ||= AgentRepository.new
      end
    end
  end
end

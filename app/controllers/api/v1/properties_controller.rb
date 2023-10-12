module Api
  module V1
    class PropertiesController < ApplicationController
      before_action :set_property, only: %i[show update destroy]

      def index
        properties = property_service.find_all_properties
        render json: properties
      end

      def show
        render json: @property
      end

      def create
        property = property_service.create_property(property_params)
        if property.errors.empty?
          render json: property, status: :created
        else
          render json: property.errors, status: :unprocessable_entity
        end
      end

      def update
        property = property_service.update_property(@property, property_params)
        if property.errors.empty?
          render json: property, status: :ok
        else
          render json: property.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if property_service.destroy_property(@property)
          head :no_content
        else
          render json: @property.errors, status: :unprocessable_entity
        end
      end

      private

      def property_params
        params.require(:property).permit(:name, :location, :price, :status)
      end

      def set_property
        @property = property_repository.find(params[:id])
      end

      def property_repository
        @property_repository ||= PropertyRepository.new
      end

      def property_service
        @property_service ||= PropertyService.new(property_repository)
      end
    end
  end
end
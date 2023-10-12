# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON/YAML files are generated
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.3', # Change the OpenAPI version to match your specification
      info: {
        title: 'Real Estate Management API V1',
        version: 'v1'
      },
      servers: [
        {
          url: 'http://localhost:3000/api/v1', # Set the URL to your API
          description: 'Local development server'
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  config.swagger_format = :yaml # You can choose :json if preferred
end

# RealEstateManagement

[![Ruby Version](https://img.shields.io/badge/Ruby-3.2.2-brightgreen.svg)](https://www.ruby-lang.org)
[![Rails Version](https://img.shields.io/badge/Rails-7.1.1-brightgreen.svg)](https://rubyonrails.org)

**RealEstateManagement** is a robust Ruby on Rails application tailored for efficient real estate property management. It offers a comprehensive, RESTful API for seamless property administration. This project is Docker-ready, fully tested, and boasts 100% test coverage. Additionally, it leverages Swagger for effortless API documentation.

## Getting Started

To get your RealEstateManagement application up and running, follow these simple steps. You have two options: using Docker or running it directly without Docker.

### Using Docker

1. Clone this repository:

   ```bash
   git clone https://github.com/bernar40/RealEstateManagement.git
   ```

2. Navigate to the project directory:

   ```bash
   cd RealEstateManagement
   ```

3. Build the Docker containers:

   ```bash
   docker-compose build
   ```

4. Run the Docker containers:

   ```bash
   docker-compose up
   ```

5. Access the application at [http://localhost:3000](http://localhost:3000).

6. Explore the Swagger documentation at [http://localhost:3000/api-docs/index.html](http://localhost:3000/api-docs/index.html).

7. For those looking to deploy the production environment, ensure you run the database seed task:

   ```bash
   docker-compose run web bin/rails db:seed
   ```

### Running Without Docker

1. Clone this repository:

   ```bash
   git clone https://github.com/bernar40/RealEstateManagement.git
   ```

2. Navigate to the project directory:

   ```bash
   cd RealEstateManagement
   ```

3. Install the required gems:

   ```bash
   bundle install
   ```

4. You don't need to set up the database separately if you're using the pre-existing one in the repository. However, if needed, you can set up your own:

   ```bash
   bin/rails db:setup
   ```

5. Start the Rails server:

   ```bash
   bin/rails s
   ```

6. Access the application at [http://localhost:3000](http://localhost:3000).

7. Explore the Swagger documentation at [http://localhost:3000/api-docs/index.html](http://localhost:3000/api-docs/index.html).

## Database

RealEstateManagement uses SQLite3 as its database, and the database file is already included in the repository. There's no need to set up a separate database server.

## Development Database IDs for Agent

In the development database, you can use the following IDs for agents when testing or interacting with the application:

| Agent ID | First Name | Last Name | Email                |
|----------|------------|-----------|----------------------|
| 8        | Agent1     | Smith     | agent1@example.com   |
| 9        | Agent2     | Johnson   | agent2@example.com   |
| 10       | Agent3     | Williams  | agent3@example.com   |

These agents are pre-populated in the development database to facilitate testing and interactions with the application during development.

## Test Coverage

Our application boasts comprehensive testing, ensuring 100% code coverage. For a deeper understanding, you can check the `coverage/index.html` folder, generated using the SimpleCov gem.

## License

This project is open-source and available under the [MIT License](LICENSE).
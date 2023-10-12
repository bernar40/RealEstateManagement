# Use the official Ruby image
FROM ruby:3.2.2-slim

# Set production environment variables
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle"

# Create a directory for your Rails app
WORKDIR /rails

# Install essential packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libsqlite3-0 libvips curl

# Copy Gemfile and Gemfile.lock to install gems
COPY Gemfile Gemfile.lock ./

# Install application gems
RUN bundle install --jobs "$(nproc)" --retry 3

# Copy the rest of your application code
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rake assets:precompile

# Expose the port on which your Rails app runs (default is 3000)
EXPOSE 3000

# Start your Rails application with Puma (or your preferred server)
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

FROM circleci/ruby:2.7.4-node-browsers

WORKDIR /code

# Uncomment this line if docker return any permission errors when trying to
# run commands for building or running the image.
USER root

COPY Gemfile* ./
RUN gem install bundler:"$(tail -n 1 Gemfile.lock)"
RUN bundle install

EXPOSE 3000

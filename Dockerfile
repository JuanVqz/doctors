FROM circleci/ruby:3.0.3-node-browsers

ARG BUNDLE_GEMFILE=Gemfile

WORKDIR /code

# Uncomment this line if docker return any permission errors when trying to
# run commands for building or running the image.
USER root

COPY .ruby-version Gemfile* ./
RUN gem install bundler:"$(tail -n 1 Gemfile.lock)" && gem install foreman
RUN BUNDLE_GEMFILE=${BUNDLE_GEMFILE} bundle install

EXPOSE 3000

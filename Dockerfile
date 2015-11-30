FROM ruby:latest
MAINTAINER Alexander Rhett Crammer <Alexander2475914@gmail.com>

# ENV Variables
ENV HOME /home/rails/eximius

# Dependencies required by Rails and RubyGems
RUN apt-get update -qq \
 && apt-get install -y \
      build-essential \
      nodejs

WORKDIR $HOME/

# Install gems
COPY Gemfile* $HOME/
RUN bundle install --jobs 20

# Add the apps' directory
ADD . $HOME

# Main command to execute when
# the container is started
CMD ["rails", "server", "-b", "0.0.0.0"]


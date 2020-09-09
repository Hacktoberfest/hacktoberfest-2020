FROM ruby:2.5-slim AS base

RUN apt-get update && apt-get install -y apt-transport-https bash curl git gnupg2 build-essential libpq-dev \
&& curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
&& echo 'deb https://deb.nodesource.com/node_12.x jessie main' > /etc/apt/sources.list.d/nodesource.list

RUN apt-get update \
  && apt-get install -y \
    nodejs \ 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . ./

RUN gem install bundler -v 2.1.4

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

###############################
FROM ruby:2.5

COPY --from=base /usr/bin/node /usr/bin/node
COPY --from=base /usr/local/bundle /usr/local/bundle

WORKDIR /app

COPY --from=base /app /app

# Pull in the rails environment
ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-development}

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
ARG RUBY_VERSION=2.6.6
FROM ruby:$RUBY_VERSION-slim as base

ARG NODEJS_MAJOR=12

WORKDIR /els

# Configure ruby & bundler
ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      gnupg2 \
      curl \
    && rm -rf /var/lib/apt/lists/*

# Add PostgreSQL to the sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' > /etc/apt/sources.list.d/pgdg.list

# Add NodeJS to the sources list
RUN curl -sSL https://deb.nodesource.com/setup_${NODEJS_MAJOR}.x | bash -

# Add Yarn to the sources list
RUN curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Application dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libpq-dev \
      postgresql-client \
      nodejs \
      yarn \
      libvips42 \
      wait-for-it \
    && rm -rf /var/lib/apt/lists/*

# Production stage
FROM base

COPY Gemfile Gemfile.lock ./
RUN bundle config set without development test && \
    bundle install

COPY . .

RUN NODE_ENV=production RAILS_ENV=production SECRET_KEY_BASE=`rails secret` \
    rails assets:precompile && yarn cache clean

# STAGE 1
# Build base container, install packages ins base image
FROM ruby:3.3.6-alpine AS base

RUN apk add --update --no-cache build-base postgresql-dev

# STAGE 2
# Build Ruby app base, install gems, and bundle check
FROM base AS dependencies

COPY Gemfile Gemfile.lock .ruby-version ./

ARG APP_ENV
ARG BUNDLER_VERSION
ARG BUNDLE_WITHOUT
    
RUN gem install bundler -v ${BUNDLER_VERSION} && \
    bundle config set without ${BUNDLE_WITHOUT} && \
    bundle check || bundle install --jobs=3 --retry=3 

# STAGE 3
# Build app image
FROM ruby:3.3.6-alpine

RUN adduser -D app-user
USER app-user

WORKDIR /home/app-user

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --chown=app-user . ./

CMD ["bundle", "exec", "rackup"]
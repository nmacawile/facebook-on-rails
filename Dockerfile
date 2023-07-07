FROM ruby:2.7.8-alpine AS builder
RUN apk add \
  build-base \
  libpq-dev \
  git
COPY Gemfile* .
RUN gem install bundler
RUN bundle install

FROM ruby:2.7.8-alpine AS runner
RUN apk add \
    tzdata \
    libpq-dev \
    nodejs \
    git
WORKDIR /app
COPY . .
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

ENV RAILS_ENV=production

# dummy value
ENV SECRET_KEY_BASE=1

RUN rails assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

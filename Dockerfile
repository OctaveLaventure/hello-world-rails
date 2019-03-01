FROM ruby:2.5.3-alpine

EXPOSE 3000
RUN adduser -s /bin/sh -D rails
WORKDIR /usr/src/app
RUN chown rails: /usr/src/app
COPY Gemfile* ./

# install nodejs
RUN apk add --no-cache \
	tzdata \
	nodejs \
	libxml2 \
	libxslt \
	sqlite-libs && \
	apk add --no-cache --virtual .build-deps \
	ca-certificates \
	ruby-dev \
	libc-dev \
	libxml2-dev \
	libxslt-dev \
	sqlite-dev \
	gcc \
	make && \
	su rails -c "bundle config build.nokogiri --use-system-libraries" && \
	su rails -c "bundle install" && \
	apk del .build-deps

COPY . .

RUN chown rails: /usr/src/app/db /usr/src/app/log
USER rails

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.3.1

# Add Yarn's repository and Node.js 16.x setup script
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install dependencies, including Node.js 16.x
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client yarn default-mysql-client

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
#COPY package.json /app/package.json
#COPY yarn.lock /app/yarn.lock
RUN gem install bundler -v '2.2.15'
RUN bundle install
RUN #yarn install --check-files
COPY . /app
EXPOSE 3000

COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

#CMD ["rails", "server", "-b", "0.0.0.0"]

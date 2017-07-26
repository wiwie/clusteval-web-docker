FROM ruby:2.2.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev sudo

USER root
RUN git clone https://github.com/wiwie/clustevalWebsite
WORKDIR /clustevalWebsite/clustevalWebsite
ADD ./database.yml ./config/
RUN bundle install
RUN rake assets:precompile
RUN RAILS_ENV=production rake assets:precompile
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/bin/wait-for-it.sh
RUN chmod +x /usr/bin/wait-for-it.sh

FROM ruby:2.3.1

ENV APP_ROOT /usr/src/app
ENV DOCKERIZE_VERSION v0.3.0
ENV ENTRYKIT_VERSION 0.4.0

RUN apt-get update && \
    apt-get install -y nodejs \
                       mysql-client \
                       postgresql-client \
                       sqlite3 \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN bundle config --global build.nokogiri --use-system-libraries \
        # dockerize
        && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        # entrykit
        && wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
        && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
        && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
        && mv entrykit /bin/entrykit \
        && chmod +x /bin/entrykit \
        && entrykit --symlink

WORKDIR $APP_ROOT

ENTRYPOINT [ \
  "prehook", "bundle install -j3", "--", \
  "prehook", "dockerize -timeout 60s -wait tcp://database:3306", "--" \
]

EXPOSE  3000
CMD ["rails", "server", "-b", "0.0.0.0"]

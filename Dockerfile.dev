FROM ruby:2.5.1

ENV LANG C.UTF-8
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update
RUN apt-get install -y nodejs build-essential mysql-client libopencv-dev --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*

ENV ENTRYKIT_VERSION 0.4.0
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app
RUN bundle config build.nokogiri --use-system-libraries

ENTRYPOINT [ \
    "prehook", "ruby -v", "--", \
    "prehook", "bundle install -j3 --quiet", "--"]

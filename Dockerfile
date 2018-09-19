FROM debian:stretch-slim

WORKDIR /root

RUN apt-get update \
    && apt-get -y install \
       vim less tree ack carton curl build-essential sqlite3 libmodule-install-perl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# carton chokes if you dont install this manually
RUN cpanm Menlo::CLI::Compat && rm -rf ~/.cpanm/work/*

RUN useradd --create-home --home-dir /home/johndoe \
            --user-group --shell /bin/bash johndoe

COPY --chown=johndoe:johndoe . /home/johndoe/pue

USER johndoe

WORKDIR /home/johndoe/pue/frontend
RUN npm install
RUN npm run build

WORKDIR /home/johndoe/pue/backend
RUN carton install && rm -rf ~/.cpanm/work/*
RUN sqlite3 pue.db < pue.sql

EXPOSE 8080
EXPOSE 8081
CMD ["carton", "exec", "bin/pue.pl"]

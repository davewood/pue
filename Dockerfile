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

RUN useradd --create-home --home-dir /home/johndoe        \
            --user-group --shell /bin/bash johndoe        \
    && mkdir -p /home/johndoe/pue/backend                 \
    && mkdir -p /home/johndoe/pue/frontend                \
    && chown -R johndoe:johndoe /home/johndoe/pue/backend \
    && chown -R johndoe:johndoe /home/johndoe/pue/frontend

USER johndoe

# install backend libs
COPY --chown=johndoe:johndoe ./backend/cpanfile* /home/johndoe/pue/backend/
WORKDIR /home/johndoe/pue/backend
RUN carton install --deployment && rm -rf ~/.cpanm/work/*

# install frontend libs
COPY --chown=johndoe:johndoe ./frontend/package*.json /home/johndoe/pue/frontend/
WORKDIR /home/johndoe/pue/frontend
RUN npm install

COPY --chown=johndoe:johndoe . /home/johndoe/pue

# build frontend app
WORKDIR /home/johndoe/pue/frontend
RUN npm run build

# init database
WORKDIR /home/johndoe/pue/backend
RUN rm -rf pue.db && sqlite3 pue.db < pue.sql

EXPOSE 8080
EXPOSE 8081
CMD ["carton", "exec", "bin/pue.pl"]

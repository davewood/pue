FROM debian:buster-slim

# create man dirs manually because otherwise psql won't install on debian-slim
RUN for i in {1..8}; do mkdir -p "/usr/share/man/man$i"; done

WORKDIR /root

RUN apt-get update \
    && apt-get -y install \
       vim less tree ack carton curl build-essential libpq-dev \
       cpanminus postgresql-client-11 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

ARG CONTAINER_UID=1000
RUN useradd --create-home --home-dir /home/pue \
            --uid $CONTAINER_UID --user-group --shell /bin/bash pue

RUN touch /home/pue/.pg_service.conf                  && \
    chown pue:pue /home/pue/.pg_service.conf          && \
    echo "[pue]"        >> /home/pue/.pg_service.conf && \
    echo "host=pue-db"  >> /home/pue/.pg_service.conf && \
    echo "user=pue"     >> /home/pue/.pg_service.conf && \
    echo "password=pue" >> /home/pue/.pg_service.conf && \
    echo "dbname=pue"   >> /home/pue/.pg_service.conf

USER pue

WORKDIR /home/pue/pue_app

EXPOSE 8080
EXPOSE 8081

CMD ["bash", "./docker_entrypoint.sh"]

FROM debian:buster-slim

WORKDIR /root

RUN apt update
RUN apt -y install nodejs npm unzip carton wget build-essential sqlite3

RUN wget https://github.com/davewood/pue/archive/master.zip
RUN unzip master.zip
RUN mv pue-master pue

WORKDIR /root/pue/frontend
RUN npm install
RUN npm run build

WORKDIR /root/pue/backend

# carton chokes if you dont install this manually
RUN cpanm Menlo::CLI::Compat

RUN carton install
RUN sqlite3 pue.db < pue.sql

EXPOSE 8080
CMD ["carton", "exec", "bin/pue.pl"]

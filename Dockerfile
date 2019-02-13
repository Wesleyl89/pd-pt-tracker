# PT-Tracker
#
# build with --build-arg PTT_VERSION=2.2 to define the version number to build
#

FROM ubuntu:latest

ARG PTT_VERSION=${PTT_VERSION:-2.2.3}
ENV PTT_VERSION ${PTT_VERSION}
ENV PTT_FILENAME=PtTracker.v${PTT_VERSION}.Linux.zip

# install tools
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /pt-tracker

WORKDIR /pt-tracker

RUN wget https://github.com/bTayFla/PtTracker/releases/download/${PTT_VERSION}/${PTT_FILENAME}

# unzip the app
RUN unzip -j ${PTT_FILENAME} \
  ; rm ${PTT_FILENAME} \
  ; chmod +x PtTracker

RUN chmod +x /pt-tracker/PtTracker

# tidy up
RUN rm -rf /tmp/* /var/cache/apk/*

# expose our default runtime port
EXPOSE 3000

# run it
ENTRYPOINT ["./PtTracker"]

# PT-Tracker
#
# build with --build-arg PTT_VERSION=2.2 to define the version number to build
#

FROM alpine:latest

ARG PTN_VERSION

ENV PTN_FILENAME=PtTracker-linux.zip

# install tools
RUN apk add --update wget bash

RUN mkdir -p /pt-tracker

WORKDIR /pt-tracker

RUN wget https://github.com/bTayFla/PtTracker/releases/download/${PTN_VERSION}/${PTN_FILENAME}

# unzip the app
RUN unzip ${PTN_FILENAME} -j \
  ; rm ${PTN_FILENAME} \
  ; chmod +x PtTracker

# add the application source to the image
COPY start /pt-notifications
RUN chmod +x /pt-notifications/PtTracker

# tidy up
RUN rm -rf /tmp/* /var/cache/apk/*

# expose our default runtime port
EXPOSE 3000

# run it
ENTRYPOINT ["PtTracker"]
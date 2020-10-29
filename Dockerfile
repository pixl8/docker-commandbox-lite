FROM adoptopenjdk/openjdk11:jdk-11.0.6_10-alpine-slim

LABEL maintainer "Dominic Watson <dominic.watson@pixl8.co.uk>"
LABEL repository "https://github.com/pixl8/docker-commandbox-lite"

ENV COMMANDBOX_VERSION 5.1.1
ENV COMMANDBOX_HOME=/usr/lib/CommandBox

RUN apk update && apk add curl && \
    rm -f /var/cache/apk/*

RUN curl -k  -o /usr/bin/box -location "https://downloads.ortussolutions.com/ortussolutions/commandbox/${COMMANDBOX_VERSION}/box-light" && \
    chmod 755 /usr/bin/box && \
    echo "commandbox_home=${COMMANDBOX_HOME}" > /usr/bin/commandbox.properties && \
    echo "Installed $( box version )" && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules_app/coldbox-commands && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules_app/contentbox-commands && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules_app/cachebox-commands && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules_app/logbox-commands && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules_app/games-commands && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules_app/wirebox-commands && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules/cfscriptme-command && \
    rm -rf /usr/lib/CommandBox/cfml/system/modules/cb-module-template


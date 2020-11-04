FROM adoptopenjdk/openjdk11:jdk-11.0.6_10-alpine-slim

LABEL maintainer "Dominic Watson <dominic.watson@pixl8.co.uk>"
LABEL repository "https://github.com/pixl8/docker-commandbox-lite"

ENV COMMANDBOX_VERSION 5.1.1
ENV COMMANDBOX_HOME=/usr/lib/CommandBox
ENV TESTBOX_VERSION=be

RUN apk update && apk add curl gettext bash && \
    rm -f /var/cache/apk/*

RUN curl -k  -o /usr/bin/box -location "https://downloads.ortussolutions.com/ortussolutions/commandbox/${COMMANDBOX_VERSION}/box-light" && \
    chmod 755 /usr/bin/box && \
    echo "commandbox_home=${COMMANDBOX_HOME}" > /usr/bin/commandbox.properties && \
    echo "Installed $( box version )" && \
    curl -o $COMMANDBOX_HOME/engine/cfml/cli/lucee-server/deploy/esapi-extension-2.1.0.18.lex https://ext.lucee.org/esapi-extension-2.1.0.18.lex && \
    curl -o $COMMANDBOX_HOME/engine/cfml/cli/lucee-server/deploy/lucee.image.extension-1.0.0.35.lex https://ext.lucee.org/lucee.image.extension-1.0.0.35.lex && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/coldbox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/contentbox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/cachebox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/logbox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/games-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/wirebox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules/cfscriptme-command && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules/cb-module-template

COPY ServerEngineService.cfc ${COMMANDBOX_HOME}/cfml/system/services/ServerEngineService.cfc

RUN box install commandbox-cfconfig && \
    cd $COMMANDBOX_HOME/cfml/system/modules_app/testbox-commands && box install testbox@${TESTBOX_VERSION}

RUN box artifacts clean --force && \
    rm -rf $COMMANDBOX_HOME/temp/* && \
    rm -rf $COMMANDBOX_HOME/logs/* && \
    rm -rf $COMMANDBOX_HOME/cfml/system/mdCache/* && \
    rm -rfv $COMMANDBOX_HOME/cfml/system/config/server-icons/*.* && \
    rm -rf $COMMANDBOX_HOME/engine/cfml/cli/lucee-server/felix-cache/*



FROM foundeo/minibox:2022.12

## This really is some simple extension to
## Pete Freitag's excellent work on minibox:
## https://github.com/foundeo/minibox/
##
## It adds some essentials for running various
## box related Github

LABEL maintainer "Dominic Watson <dominic.watson@pixl8.co.uk>"
LABEL repository "https://github.com/pixl8/docker-commandbox-lite"

ENV COMMANDBOX_HOME=/root/.CommandBox

RUN apk update && apk add curl gettext && \
    rm -f /var/cache/apk/*

RUN curl -o $COMMANDBOX_HOME/engine/cfml/cli/lucee-server/deploy/esapi-extension.lex https://ext.lucee.org/esapi-extension-2.2.4.13.lex && \
    curl -o $COMMANDBOX_HOME/engine/cfml/cli/lucee-server/deploy/lucee.image.extension.lex https://ext.lucee.org/lucee.image.extension-1.0.0.51.lex && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/coldbox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/contentbox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/cachebox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/logbox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/games-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules_app/wirebox-commands && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules/cfscriptme-command && \
    rm -rf $COMMANDBOX_HOME/cfml/system/modules/cb-module-template

RUN box install commandbox-cfconfig && \
    cd $COMMANDBOX_HOME/cfml/system/modules_app/testbox-commands && box install testbox@be

RUN box artifacts clean --force && \
    rm -rf $COMMANDBOX_HOME/temp/* && \
    rm -rf $COMMANDBOX_HOME/logs/* && \
    rm -rf $COMMANDBOX_HOME/cfml/system/mdCache/* && \
    rm -rfv $COMMANDBOX_HOME/cfml/system/config/server-icons/*.* && \
    rm -rf $COMMANDBOX_HOME/engine/cfml/cli/lucee-server/felix-cache/*

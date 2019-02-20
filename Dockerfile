FROM node:10.15-alpine

RUN apk add --no-cache curl jq

COPY --chown=root:root files/entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

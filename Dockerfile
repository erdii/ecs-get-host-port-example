FROM alpine:3.9

# install dependencies
RUN apk add --no-cache curl jq

# install our custom entrypoint script
COPY --chown=root:root files/entrypoint.sh /

# make entrypoint script executable - this is not needed, when entrypoint.sh already was executable before copying
RUN chmod +x /entrypoint.sh

# run our entrypoint script when docker starts
ENTRYPOINT [ "/entrypoint.sh" ]

# pass your "real" entrypoint and args in CMD and /entrypoint.sh will execute it
CMD [ "/usr/bin/env" ]

FROM prom/snmp-exporter:latest as snmp_exporter

# Use alpine image
FROM alpine:3.8

# Create different user
RUN addgroup -S prometheus && \
    adduser -S prometheus -G prometheus -s /bin/ash

# Install dumb-init for process forking
RUN apk add --upgrade --no-cache \
    su-exec \
    tini

# Copy snmp_exporter binary
COPY --from=snmp_exporter /bin/snmp_exporter /bin/snmp_exporter

# Copy SNMP template
COPY snmp.yaml /etc/snmp_exporter/snmp.yml

# Copy entrypoint
COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh

# Expose port
EXPOSE 9116

# Set Docker entrypoint
ENTRYPOINT ["tini", "-v", "--", "/docker-entrypoint.sh"]

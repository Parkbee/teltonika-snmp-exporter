FROM prom/snmp-exporter:latest

COPY snmp.yml /etc/snmp_exporter/snmp.yml

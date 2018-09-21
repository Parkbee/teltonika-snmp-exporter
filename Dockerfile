FROM prom/snmp-exporter:latest

COPY snmp-full.yml /etc/snmp_exporter/snmp.yml

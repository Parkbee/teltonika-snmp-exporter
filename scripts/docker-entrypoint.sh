#!/usr/bin/env sh

snmpCommunityString="${SNMP_COMMUNITY_STRING:-public}"
snmpDefaultRetries="${SNMP_DEFAULT_RETRIES:-3}"
snmpDefaultTimeout="${SNMP_DEFAULT_TIMEOUT:-30s}"

sed -i "s/%%snmpCommunityString%%/${snmpCommunityString}/g" /etc/snmp_exporter/snmp.yml
sed -i "s/%%snmpDefaultRetries%%/${snmpDefaultRetries}/g" /etc/snmp_exporter/snmp.yml
sed -i "s/%%snmpDefaultTimeout%%/${snmpDefaultTimeout}/g" /etc/snmp_exporter/snmp.yml

chown -R prometheus:prometheus /etc/snmp_exporter

exec su-exec prometheus /bin/snmp_exporter --config.file=/etc/snmp_exporter/snmp.yml

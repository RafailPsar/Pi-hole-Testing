*** Settings ***
Documentation    Common keywords and variables for Pi-hole testing
Library    RequestsLibrary
Library    Collections
Variables  ../config/variables.py

*** Variables ***
# API Endpoints
${AUTH_PATH}             /api/auth
${DNS_BLOCKING_PATH}     /api/dns/blocking
${NETWORK_DEVICES_PATH}  /api/network/devices

# Metrics & Statistics Endpoints
${STATS_SUMMARY_PATH}    /api/stats/summary
${TOP_CLIENTS_PATH}      /api/stats/top_clients
${TOP_DOMAINS_PATH}      /api/stats/top_domains

# System & FTL Information Endpoints
${SYSTEM_INFO_PATH}      /api/info/system
${VERSION_PATH}          /api/info/version
${FTL_INFO_PATH}         /api/info/ftl
${UPTIME_PATH}           /api/info/uptime

# API Response Keys
${CLIENTS_KEY}           clients
${TOTAL_QUERIES_KEY}     total_queries
${STATE_ENABLED}         enabled
${STATE_DISABLED}        disabled

# HTTP Status Codes
${SUCCESS_STATUS}        200
${NO_CONTENT_STATUS}     204

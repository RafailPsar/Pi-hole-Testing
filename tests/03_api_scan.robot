*** Settings ***
Documentation       validates system metrics, client activity
...    and network discovery using official FTL endpoints
Resource            ../resources/common.resource
Test Tags           discovery

*** Test Cases ***
Verify System Uptime and Memory
    [Documentation]    Tests the /info/system endpoint which has a nested structure
    [Tags]    smoke    system
    ${response}=      GET On Session    pihole    url=${SYSTEM_INFO_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    # According to docs: response -> system -> uptime
    ${uptime}=        Set Variable    ${response.json()}[system][uptime]
    Should Be True    ${uptime} > 0
    
    # Check Memory Usage Percentage
    ${mem_used}=      Set Variable    ${response.json()}[system][memory][ram][%used]
    Log    System Uptime: ${uptime}s | RAM Usage: ${mem_used}%    level=INFO

Verify Top Clients Data
    [Documentation]    Ensures the API provides data about active clients and query counts
    [Tags]    metrics
    ${response}=      GET On Session    pihole    url=${TOP_CLIENTS_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    # Verify the keys we actually found in the debug log
    Dictionary Should Contain Key    ${response.json()}    ${CLIENTS_KEY}
    Dictionary Should Contain Key    ${response.json()}    ${TOTAL_QUERIES_KEY}
    
    ${total}=         Set Variable    ${response.json()}[${TOTAL_QUERIES_KEY}]
    Log    Top Clients verified. Total queries processed: ${total}

Verify Network Devices Discovery
    [Documentation]    Checks the /network/devices endpoint for local network info
    [Tags]    network
    ${response}=      GET On Session    pihole    url=${NETWORK_DEVICES_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    # Check if the 'devices' list exists
    Dictionary Should Contain Key    ${response.json()}    devices
    ${device_count}=  Get Length    ${response.json()}[devices]
    Log    Total discovered devices: ${device_count}
*** Settings ***
Documentation       Performance and SLA tests to ensure API speed
Resource            ../resources/common.resource
Test Tags           performance

*** Test Cases ***
Verify System Info Processing Time
    [Documentation]    Ensures the Pi-hole server processes system info requests quickly
    [Tags]    sla    metrics
    ${response}=      GET On Session    pihole    url=${SYSTEM_INFO_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    ${process_time}=  Set Variable    ${response.json()}[took]
    Should Be True    ${process_time} < 0.5    msg=API internal processing time exceeded 0.5 seconds!
    Log    Server processing time was: ${process_time} seconds    level=INFO

Verify Top Clients Network Latency
    [Documentation]    Ensures the full network round-trip for a heavy endpoint is under 1 second
    [Tags]    sla    network
    ${response}=      GET On Session    pihole    url=${TOP_CLIENTS_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    ${round_trip}=    Set Variable    ${response.elapsed.total_seconds()}
    Should Be True    ${round_trip} < 1.0      msg=Network round-trip latency exceeded 1 second!
    Log    Network round-trip completed in ${round_trip} seconds    level=INFO
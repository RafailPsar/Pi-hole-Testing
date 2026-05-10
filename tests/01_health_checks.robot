*** Settings ***
Documentation       Health checks for the Pi-hole  API
Resource            ../resources/common.resource
Test Tags          health

*** Test Cases ***
Verify API Is Responding
    [Documentation]    Ensures the summary API is reachable
    [Tags]    smoke    stats
    ${response}=      GET On Session    pihole    url=${STATS_SUMMARY_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    Log               ${response.json()}

Verify Blocking Status Integrity
    [Documentation]    Ensures the blocking status endpoint returns expected data
    [Tags]    smoke    dns
    ${response}=      GET On Session    pihole    url=${DNS_BLOCKING_PATH}
    Status Should Be  ${SUCCESS_STATUS}    ${response}

    Dictionary Should Contain Key    ${response.json()}    blocking
*** Settings ***
Documentation       Feature tests for controlling Pi-hole blocking state
Resource            ../resources/common.resource
Test Tags           feature    blocking

*** Test Cases ***
Disable Blocking Temporarily
    [Documentation]    Disables blocking for a few seconds and verifies the state.
    [Tags]    critical
    ${payload}=       Create Dictionary    blocking=${FALSE}    timer=${5}
    
    ${response}=      POST On Session    pihole    url=${DNS_BLOCKING_PATH}    json=${payload}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    # Use String comparison to avoid NameError
    ${status}=        Set Variable    ${response.json()}[blocking]
    Should Be Equal As Strings    ${status}    disabled
    Log    Blocking disabled successfully    level=INFO

Enable Blocking Manually
    [Documentation]    Ensures blocking can be turned back on.
    [Tags]    critical
    ${payload}=       Create Dictionary    blocking=${TRUE}
    
    ${response}=      POST On Session    pihole    url=${DNS_BLOCKING_PATH}    json=${payload}
    Status Should Be  ${SUCCESS_STATUS}    ${response}
    
    ${status}=        Set Variable    ${response.json()}[blocking]
    Should Be Equal As Strings    ${status}    enabled
    Log    Blocking re-enabled successfully   level=INFO
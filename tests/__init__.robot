*** Settings ***
Documentation    Global setup for Pi-hole testing
Library          RequestsLibrary
Resource         ../resources/common.resource
Suite Setup      Global Login
Suite Teardown   Global Logout


*** Variables ***
${CURRENT_SID}    dummy_value  # This will be set to the actual SID token during login and used for logout

*** Keywords ***
Global Login
    [Documentation]    Authenticates once and shares the session across all test cases
    Create Session    auth_session    ${PIHOLE_URL}    timeout=10    max_retries=3
    ${login_data}=    Create Dictionary    password=${PIHOLE_PASSWORD}
    ${auth_resp}=     POST On Session    auth_session    ${AUTH_PATH}    json=${login_data}
    Status Should Be  ${SUCCESS_STATUS}    ${auth_resp}
    
    ${sid_token}=     Set Variable    ${auth_resp.json()}[session][sid]
    Set Suite Variable    ${CURRENT_SID}    ${sid_token}
    ${headers}=       Create Dictionary    sid=${sid_token}
    
    # Making the authenticated session available globally for all tests
    Create Session    pihole    ${PIHOLE_URL}    headers=${headers}
    Log    Successfully authenticated and created global session    level=INFO


Global Logout
    [Documentation]    Closes all active sessions and performs final logging out
    ${logout_params}=    Create Dictionary    sid=${CURRENT_SID}
    ${logout_resp}=    DELETE On Session    
    ...    alias=pihole    
    ...    url=${AUTH_PATH}   
    ...    params=${logout_params}
    ...    expected_status=${NO_CONTENT_STATUS}
    
    Delete All Sessions
    Log    All sessions have been closed and logged out successfully    level=INFO
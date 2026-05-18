*** Settings ***
Documentation       Negative tests to ensure the Pi-hole API correctly rejects invalid requests
Resource            ../resources/common.resource
Test Tags           negative    security

*** Test Cases ***
Verify Login With Invalid Password
    [Documentation]    Attempts to authenticate with a wrong password and expects a 401 Unauthorized error
    [Tags]    auth
    Create Session    bad_auth_session    ${PIHOLE_URL}    timeout=5
    ${bad_login_data}=    Create Dictionary    password=wrong_password

    ${response}=      POST On Session    bad_auth_session    url=${AUTH_PATH}    json=${bad_login_data}    expected_status=${UNAUTHORIZED_STATUS}
    
    Log    Server correctly rejected invalid password. Response: ${response.text}    level=INFO

Verify Protected Endpoint Without Session Token
    [Documentation]    Attempts to access system info without providing the required 'sid' header
    [Tags]    auth
    # Create a completely fresh session with NO headers
    Create Session    unauth_session    ${PIHOLE_URL}    timeout=5
    
    # Try to access a protected route
    ${response}=      GET On Session    unauth_session    url=${SYSTEM_INFO_PATH}    expected_status=${UNAUTHORIZED_STATUS}
    
    Log    Server correctly blocked unauthenticated access. Response: ${response.text}    level=INFO

Verify Blocking Rejects Empty Payload
    [Documentation]    Attempts to change blocking state without sending any data
    [Tags]    bad_request    blocking
    ${empty_payload}=    Create Dictionary
    
    # sending an empty JSON
    ${response}=      POST On Session    pihole    url=${DNS_BLOCKING_PATH}    json=${empty_payload}    expected_status=${BAD_REQUEST_STATUS}
    
    Log    Server correctly rejected empty payload. Response: ${response.text}    level=INFO

Verify Blocking Rejects Invalid Data Type
    [Documentation]    Attempts to send a string instead of a boolean for the blocking state
    [Tags]    bad_request    blocking
    # invalid API data payload
    ${invalid_payload}=  Create Dictionary    blocking=yes_please_disable
    
    ${response}=      POST On Session    pihole    url=${DNS_BLOCKING_PATH}    json=${invalid_payload}    expected_status=${BAD_REQUEST_STATUS}
    
    Log    Server correctly rejected invalid data type. Response: ${response.text}    level=INFO

Verify Accessing Non-Existent Endpoint
    [Documentation]    Ensures the API returns a 404 Not Found for invalid paths instead of crashing
    [Tags]    not_found
    # fake URL payload
    ${response}=      GET On Session    pihole    url=/api/this/endpoint/is/fake    expected_status=${NOT_FOUND_STATUS}
    
    Log    Server correctly returned 404 for invalid path.    level=INFO
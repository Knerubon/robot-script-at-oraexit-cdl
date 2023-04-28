*** Settings ***
Library         Selenium2Library
Library         String
Library         Collections
Library         OperatingSystem
Library         DateTime

Resource          ../Variables/CDL_Common_TestData.robot
Resource          ../Variables/CDL_Common_Variables.robot
Resource          ../Repository/CDL_Common_Repository.robot

*** Keywords ***

Open Browser Chrome :
    [Arguments]  ${_url} 
     ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
     ${disabled}    Create List    Chrome PDF Viewer
     # set  download default
     ${prefs} =    create dictionary    download.prompt_for_download=${FALSE}    download.directory_upgrade=${TRUE}    download.default_directory=${CURDIR}\\Download  safebrowsing.enabled=${TRUE}
     call method    ${CHROME_OPTIONS}    add_experimental_option    prefs    ${prefs}
     Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors  
     Call Method    ${chrome_options}    add_argument    --ignore-urlfetcher-cert-requests
     Create Webdriver    Chrome   chrome_options=${chrome_options}
     Go To  ${_url}   
     Maximize Browser Window
    
Split Data :
    [Arguments]   ${inputData}
    @{list_data}     Create List   ${inputData}
    log  ${list_data}
    @{Data} =    Split String      ${list_data[${0}]}      |
    log  ${Data}
    Set Test Variable  ${Data}

Login at Employee Services :
    [Arguments]  ${url_web}  ${Username_login}
    Open Browser Chrome :  ${url_web}
    Split Data :  ${Username_login}
    Wait Until Element Is Visible   ${loc_Username}   60s
    Input Text :  ${loc_Username}  ${Data[${0}]}
    Input Password  ${loc_Password}  ${Data[${1}]}
    Click Element :  ${btn_ok}

Login at COA :
    [Arguments]  ${url_web}  ${Username_login}
    Open Browser Chrome :  ${url_web}
    Split Data :  ${Username_login}
    Wait Until Element Is Visible   ${COA_locUername}   60s
    Input Text :  ${COA_locUername}  ${Data[${0}]}
    Input Password  ${COA_locPassword}  ${Data[${1}]}
    Click Element :  ${COA_btn_Submit}
    
Click Element :
    [Arguments]   ${Local}
    Log  ${Local}
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Element Is Enabled  ${Local} 
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${Local} 
    Wait Until Element Is Visible  ${Local}  120s
    Click Element   ${Local}
    Wait Loading screen Not Visible

Input Text :
    [Arguments]   ${locator}  ${inputData}
    Wait Until Element Is Visible  ${locator}   120s
    Input Text  ${locator}  ${inputData}

Logout Employee
    ${window_request} =	Get Window Handles
    ${handle} =	Switch Window	MAIN

    FOR  ${i}  IN RANGE  5
            ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element    ${btn_logout}    60s
            Run Keyword If	'${status}' == 'FAIL'   sleep  2s
            Exit For Loop IF  '${status}' == 'PASS'
    END
    Click Element :  ${btn_logout}

Switch Window to CREDIT LINE
    ${window_request} =	Get Window Handles
    ${handle} =	Switch Window	NEW
    Maximize Browser Window

    FOR  ${i}  IN RANGE  5
        ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Element Is Visible    ${CREDITLINE_btn_logout}    60s
        Run Keyword If	'${status}' == 'PASS'	Wait Until Page Contains Element   ${CREDITLINE_btn_logout}    120s
        Exit For Loop IF  '${status}' == 'PASS'
    END

Logout in CREDIT LINE
    sleep  2s
    Wait Until Keyword Succeeds     10s  1s     click element       ${CREDITLINE_btn_logout}
    Handle Alert  action=ACCEPT

Validate List Data And Should Be Visible :
    [Arguments]   ${listData}  
    Set Test Variable  ${listData}
    ${Length}    Get Length   ${listData}
    FOR    ${i}    IN RANGE    ${Length}
        Log  ${listdata[${i}]}
        Wait Until Element Is Visible  ${listdata[${i}]}  60s
        Element Should Be Visible  ${listdata[${i}]}  60s
        Page Should Contain Element  ${listdata[${i}]}  60s
    END

Logout COA
    Click Element :  ${COA_btn_logout}
    Click Element :  ${COA_btn_confirmLogout}

Get Text :
    [Arguments]   ${Local}  
    Wait Until Element Is Visible  ${Local}   240s
    Scroll Element Into View  ${Local}
    ${GetValue}   Get Text   ${Local}
    Set Test Variable  ${GetValue}

Get Text And Should Be True :
    [Arguments]   ${Local}   ${Value}
    Wait Until Element Is Visible  ${Local}   240s
    Scroll Element Into View  ${Local}
    ${GetValue}   Get Text   ${Local}
    Should Be True   '${GetValue}'=='${Value}'
    Set Test Variable  ${GetValue}

Get Value And Should Be True :
    [Arguments]   ${Local}   ${Value}
    Wait Until Element Is Visible  ${Local}   240s
    Scroll Element Into View  ${Local}
    ${GetValue}   Get Value   ${Local}
    Should Be True   '${GetValue}'=='${Value}'
    Set Test Variable  ${GetValue}

Get Selected List Labels And Should Be True :
    [Arguments]   ${Local}   ${Value}
    Wait Until Element Is Visible  ${Local}
    ${GetSelected}   Get Selected List Labels   ${Local}
    Should Be True   '${GetSelected[${0}]}'=='${Value}'
    Log  ${GetSelected[${0}]} = ${Value}
    Set Test Variable  ${GetSelected}

Check RequestNO in system :
    [Arguments]   ${type_create}
    ${status}   ${value} =  Run Keyword And Ignore Error   Wait Until Element Is Visible  ${WARNING_POPUP}   20s
    Run Keyword If	'${status}' == 'PASS'  Conditon Check Request NO  ${type_create}

Conditon Check Request NO
    [Arguments]   ${type_create}
    Validate List Data And Should Be Visible :  ${list_validatePOPUP}
    Get Text :  ${POPUP_BODY}
    @{RequestNo} =    Split String      ${GetValue}      :${SPACE} 
    @{RequestNo} =    Split String      ${RequestNo[${1}]}      , 
    ${RequestNo}    Set Variable    ${RequestNo[${0}]}
    Set Test Variable   ${RequestNo}
    Log To Console  : Can't Create New Request Credit Line. RequestNo :: ${RequestNo}
    Log   -----------------------------------------------------------------
    Log   Can't Create New Request Credit Line. RequestNo :: ${RequestNo}
    Log   -----------------------------------------------------------------
    Run Keyword If	'${type_create}' == 'Normal'  Create File  ${path_data_test}/log_err_Normal_RequestNo.text   ${RequestNo}
    Run Keyword If	'${type_create}' == 'Request'  Create File  ${path_data_test}/log_err_Request_RequestNo.text   ${RequestNo}
    Click Element :  ${POPUP_Btn_OK}
    Logout in CREDIT LINE
    Close Window

Get Text New Request No Type Normal
    Wait Until Element Is Visible  ${NEW_NormalREQUEST_NO}   240s
    Scroll Element Into View  ${NEW_NormalREQUEST_NO}
    ${GetValue}   Get Text   ${NEW_NormalREQUEST_NO}
    ${NewRequestNo}    Set Variable    ${GetValue}
    Set Test Variable  ${NewRequestNo}
    Create File  ${path_data_test}/NEW_Normal_RequestNo.text   ${NewRequestNo}

Get Text New Request CA No :
    [Arguments]   ${Local}  
    Wait Until Element Is Visible  ${Local}   240s
    Scroll Element Into View  ${Local}
    ${GetValue}   Get Text   ${Local}
    ${CANewRequestNo}    Set Variable    ${GetValue}
    Set Test Variable  ${CANewRequestNo}
    Create File  ${path_data_test}/NEW_Request_RequestNo.text   ${CANewRequestNo}

Check detail data
    ${status}   ${value} =  Run Keyword And Ignore Error   Get Selected List Labels And Should Be True :   ${CREDIT_LINE_TYPE}   Normal

Check Request Status :
    [Arguments]  ${RequestNo}  ${lacator}  ${value}   
    Click Element :  ${Menu_TRACKING} 
    Input Text :  ${loc_requsetNo}  ${RequestNo}
    Click Element :  ${FINANCE_Search}
    Get Text And Should Be True :  ${lacator}  ${value}

Get File Text Normal
    ${log}  Get File   ${path_data_test}/NEW_Normal_RequestNo.text
    ${NewRequestNo}  Set Variable  ${log}
    Set Test Variable  ${NewRequestNo}

Get File Text Request
    ${log}  Get File   ${path_data_test}/NEW_Request_RequestNo.text
    ${CANewRequestNo}  Set Variable  ${log}
    Set Test Variable  ${CANewRequestNo}

Wait Until Element Is Enabled :
    [Arguments]   ${listData}
    ${Length}    Get Length   ${listData}
    FOR    ${i}    IN RANGE    ${Length}
            Wait Until Element Is Enabled  ${listData[${i}]}   120s
    END

Import Data From File Excel
    Click Element :  ${popup_btn_confirm}
    ChooseFile  ${upload_files}  ${file_path}
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Element Is Visible   ${upload_completed}  240s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  2s
    Run Keyword If	'${status}' == 'PASS'  Click Element :   ${btn_ImportFile}
    Wait Until Element Is Enabled :  ${list_validate_dataImport}
    Scroll Height

Select Reason
    Wait Until Element Is Visible   ${DropDown_list_reason}  120s
    Click Element :  ${DropDown_list_reason}
    Wait Until Element Is Enabled  ${reason_1}  60s
    Click Element :  ${reason_1}
    Click Element :  ${button_Edite_Confirm}

Select Reason Request
    Wait Until Element Is Visible   ${DropDown_list_reason}  120s
    Click Element :  ${DropDown_list_reason}
    Wait Until Element Is Enabled  ${reason_1}  60s
    Click Element :  ${reason_1}
    Click Element :  ${SaveReCal}

Wait Loading screen Not Visible
    # Sleep  0.5s
    FOR    ${i}    IN RANGE    5
            ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${loading}  2s
            Run Keyword If	'${status}' == 'PASS'    Run Keyword And Ignore Error  Wait Until Page Does Not Contain Element  ${loading}  60s
            Exit For Loop IF  '${status}' == 'FAIL'
    END
    
    Wait Until Element Is Not Visible   ${loading}   60s

Check data in excel :
    [Arguments]   ${locator}
    Scroll Height
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${locator}  60s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  10s

Select NO OF EMPLOYEE : less 25
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${OF_EMPLOYEE}  60s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  10s

Select CREDIT LINE TYPE : Normal
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${CREDIT_LINE_TYPE}  60s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  10s

Input Value AWN
    Input Text :  ${loc_inputText_AWN}  ${Max_Credit}
    Click Element :  ${TOTAL}
    Get Value And Should Be True :  ${TOTAL}  ${check_total}

Scroll Height
    Sleep  1s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Select CREDIT TERM LEVEL : CA
    Scroll Height
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${CREDIT_TERM_LEVEL}  40s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  10s

Select SALE REQUEST DAYS: 35 DAYS
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${SALE_REQUEST}  40s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  10s

Select REASON : Option 1
    ${status}   ${value} =  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${Reason_listbox}  20s
    Run Keyword If	'${status}' == 'FAIL'  Sleep  10s
    Wait Until Element Is Visible   ${Reason_listbox}  120s
    Click Element :  ${Reason_listbox}
    Wait Until Element Is Enabled  ${Reason_listbox_option1}  60s
    Click Element :  ${Reason_listbox_option1}

    
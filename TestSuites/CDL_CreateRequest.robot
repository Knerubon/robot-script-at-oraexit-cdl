*** Settings ***
Metadata          Version 1.0.0
Library           Selenium2Library
Resource          ../Resources/Keywords/CDL_Common_Keyword.robot
Resource          ../Resources/Repository/CDL_Common_Repository.robot
Resource          ../Resources/Variables/CDL_Common_TestData.robot
Resource          ../Resources/Variables/CDL_Common_Variables.robot

# Test Teardown       Close All Browsers

*** Test Cases ***

CDLCreateNormal_CreateRequest_TC001             # Create  Request 
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Create  Request Credit Line Type : Normal  ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User: siriratt
        ...      Pass: siriratt
        ...     3 ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Term
        ...     5. คลิกเมนู Create Request 
        ...     6. คลิก Request  ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Create Request Step 1 ค้นหาข้อมูลลูกค้า

        Login at Employee Services :  ${URL_CDL_Test}  ${user_siriratt}    # User Create
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${Menu_CreateTerm}
        Wait Loading screen Not Visible
        Click Element :  ${Menu_CREATE_REQUEST}
        Click Element :  ${subMenu_Request}
        Validate List Data And Should Be Visible :  ${list_validate_CREATE_REQUEST}
        Capture Page Screenshot

CDLCreateNormal_CreateRequest_TC002
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Tab "ค้นหาข้อมูลลูกค้า"  ${\n}

        ...     TEST STEPS:
        ...     1. ระบุ SFF CUSTOMER NAME =  ทิปโก้มารีไทม์
        ...     2. คลิกปุ่ม Next
        ...     3. คลิกปุ่ม Choose ที่ Popup SEARCH CUSTOMER NAME ${\n}

        ...     Expected Result
        ...     - ระบบนำ Account ที่ Choose ไปแสดงที่ Step2 ระบุข้อมูลเพื่อพิจารณา

        # STEP 1 ค้นหาข้อมูลลูกค้า
        Input Text :  ${Search_SFF_CUSTOMER_NAME}  ${SFF_CUSTOMERNAME}
        Click Element :  ${btn_NEXT}
        Validate List Data And Should Be Visible :  ${list_SEARCH_SFF_CUSTOMERNAME}
        Click Element :  ${Choose_SFF_CUSTOMERNAME}
        Scroll Height
        Validate List Data And Should Be Visible :  ${list_CREATE_REQUEST_Step1}
        Capture Page Screenshot

CDLCreateNormal_CreateRequest_TC003
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Tab "ระบุข้อมูลเพื่อพิจารณา"  ${\n}

        ...     TEST STEPS:
        ...     1. ระบุ CREDIT TERM LEVEL : CA
        ...     2. ระบุ SALE REQUEST (DAYS) : 35 Days
        ...     3. ระบุ REASON : เป็นนโยบายของบริษัท ลูกค้าในการขยายชำระเงินเวลา
        ...     4. คลิกปุ่ม Next   ${\n}

        ...     Expected Result
        ...     - ระบบจะนำข้อมูล CUSTOMER INFORMATION และข้อมูลประกอบการพิจารณา ไปแสดงที่ Step3 สรุปข้อมูล  ${\n}

        Select CREDIT TERM LEVEL : CA
        Select SALE REQUEST DAYS: 35 DAYS
        Select REASON : Option 1
        Click Element :  ${button_NEXT}
        Check RequestNO in system :  Request
        Validate List Data And Should Be Visible :  ${list_Total_Information_consideration}

CDLCreateNormal_CreateRequest_TC004
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Tab "สรุปข้อมูล"  ${\n}

        ...     TEST STEPS:
        ...     1. ตรวจสอบข้อมูลประกอบการพิจารณา
        ...     2. คลิกปุ่ม Confirm ${\n}

        ...     Expected Result
        ...     - ระบบจะนำข้อมูล CUSTOMER INFORMATION และข้อมูลประกอบการพิจารณา ไปแสดงที่ Step3 สรุปข้อมูล  ${\n}

        ...     Remark
        ...     ระบบแสดง NEW REQUEST INFORMATION ที่มีข้อมูล
        ...     COMPANY NAME :ทิปโก้มารีไทม์
        ...     CA NO :31200000783575
        ...     REQUEST NO :CT20220000093
        ...     CREDIT TERM LEVEL :CA
        ...     URGENT REQUEST :NO
        ...     - ได้เอกสาร Request Credit Term ในระบบ 
        ...     - Request Status = CREATE

        ## STEP 3 สรุปข้อมูล
        Validate List Data And Should Be Visible :  ${list_Total_Information_consideration}
        Click Element :  ${btn_Confirm}
        Wait Loading screen Not Visible
        Validate List Data And Should Be Visible :  ${list_velidate_Information_Popup}
        Get Text New Request CA No :  ${REQUEST_CA_NO}
        Click Element :  ${NEW_REQUEST_NO_Button_OK}
        Check Request Status :  ${CANewRequestNo}  ${loc_getStatus_request}  ${Create}             # Check Request Status : Create  parameter :: ${RequestNo}  ${loc_getValue}  ${value}
        Logout in CREDIT LINE
        Logout Employee
        Close Window

CDLCreateNormal_COAApprove_TC001                # COA Approve
        [Tags]      COA_Approve
        [Documentation]
        ...     Test Case:
        ...     COA Approve  ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Corporate Online Approve 
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : thanaprj 
        ...      Pass : thanaprj 
        ...     3 ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Term
        ...     5. คลิกเมนู Approve   ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ APPROVE

        Login at COA :  ${URL_COA_TEST}  ${user_thanaprj}
        Validate List Data And Should Be Visible :  ${list_COA_NeedApprove}
        Click Element :  ${CorporateSales}
        Get File Text Request
        Input Text :  ${Search_Filter}  ${CANewRequestNo}
        Click Element :  ${view_Transaction}

CDLCreateNormal_COAApprove_TC002
        [Tags]      COA_Approve
        [Documentation]
        ...     Test Case:
        ...     Click Approve Request  ${\n}

        ...     TEST STEPS:
        ...     1.กรอกข้อมูล REQUEST NO.: CT20220000093
        ...     2.คลิกปุ่ม Search
        ...     3.คลิก Checkbox หน้า Request
        ...     4.คลิกปุ่ม APPROVE
        ...     6.คลิกปุ่ม OK  Popup Confirm  ${\n}

        ...     Expected Result
        ...     - Request Status = APPROVE
        ...     - ส่ง Request ไปยัง COA คนถัดไป${\n}

        Click Element :  ${coa_Approve}
        Click Element :  ${coa_btn_ok}
        Click Element :  ${coa_btn_ok}
        Capture Page Screenshot
        Logout COA
        Close Window

CDLCreateNormal_FinanceConfirm_TC001            # FI (1) (MAKER) Confirm Request 
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI (MAKER) Confirm Request   ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User: sirigunn
        ...      Pass: sirigunn
        ...     3 ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Term
        ...     5. คลิกเมนู Finance   ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Finance  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_sirigunn}   # FI (MAKER) Finance Confirm 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${Menu_CreateTerm}
        Click Element :  ${menu_FINANCIAL}
        Wait Loading screen Not Visible
        Validate List Data And Should Be Visible :  ${list_FINANCE_Request}

CDLCreateNormal_FinanceConfirm_TC002
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     ReserveRequest  ${\n}

        ...     TEST STEPS:
        ...     1. กรอกข้อมูล REQUEST NO.: CL20220000951
        ...     2. คลิกปุ่ม Search
        ...     3. คลิกปุ่ม RESERVE ใบ Request No.  CL20220000951 ที่ตารางแสดงข้อมูล Column ACTION
        ...     4. คลิกปุ่ม OK ที่ Popup Confirm
        ...     5. คลิกปุ่ม EDIT  ${\n}

        ...     Expected Result
        ...     - ระบบแสดง Panel EDIT / TAB DETAIL OUTPUT  ${\n}

        Get File Text Request
        Input Text :  ${loc_requsetNo}  ${CANewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${RESERVE}
        Click Element :  ${popup_btn_confirm}
        Click Element :  ${Edit_request}
        Validate List Data And Should Be Visible :  ${list_PanelEDIT}

CDLCreateNormal_FinanceConfirm_TC003
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     Tab "OUTPUT" เปรียบเทียบงบดุล (Balance Sheet) /เปรียบเทียบงบกำไรขาดทุน (Income(Loss) Statement)  ${\n}

        ...     TEST STEPS:
        ...     1.คลิกปุ่ม Import File DBD / Edit Data
        ...     2.คลิกปุ่ม OK ที่ Popup Confirm
        ...     3.เลือก File เพื่อทำการ Import ข้อมูล DBD 
        ...     4.คลิกปุ่ม OK  ${\n}

        ...     Expected Result
        ...     - ระบบแสดงข้อมูลที่ Import  ${\n}

        Click Element :  ${add_Statement}
        Import Data From File Excel

CDLCreateNormal_FinanceConfirm_TC004
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     ปุ่ม RE-CALCULATE   ${\n}

        ...     TEST STEPS:
        ...     1. คลิกปุ่ม RE-CALCULATE
        ...     2. คลิกปุ่ม SAVE
        ...     3. ระบุ Reason : 
        ...     4. คลิกปุ่ม SAVE ${\n}

        ...     Expected Result
        ...     - ระบบแสดงข้อมูลที่ Import  ${\n}

        Click Element :  ${btn_Recalculate}
        Check data in excel :  ${ApprovedCreditTerm}
        Click Element :  ${btn_SaveReCal} 
        Select Reason Request

CDLCreateNormal_FinanceConfirm_TC005
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     Popup Confirm   ${\n}

        ...     TEST STEPS:
        ...     1.คลิกปุ่ม OK ที่ Popup Confirm
        ...     2. คลิกปุ่ม Confirm ${\n}

        ...     Expected Result
        ...     - Request Status = CONFIRM
        ...     - ส่ง Request ไปยัง FI (CHECKER) คนต่อไป  ${\n}

        Wait Until Element Is Visible   ${popup_Confirm}   240s
        Click Element :  ${popup_btn_confirm}
        Click Element :  ${popup_comment_Confirm}
        Wait Loading screen Not Visible
        Get File Text Request
        Check Request Status :  ${CANewRequestNo}  ${loc_getStatus_request}  ${Confirm}             # Check Request Status : Confirm  parameter :: ${RequestNo}  ${loc_getValue}  ${value}
        Logout in CREDIT LINE
        Logout Employee
        Close Window

CDLCreateNormal_FinanceConfirm_TC006            # FI (2) (CHECKER) Confirm Request 
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI (CHECKER) Confirm Request    ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:   #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : suwannep 
        ...      Pass: suwannep 
        ...     3.ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Term
        ...     5. คลิกเมนู Finance  ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Finance  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_suwannep}   # FI (CHECKER) Confirm Request 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${Menu_CreateTerm}
        Click Element :  ${menu_FINANCIAL}
        Validate List Data And Should Be Visible :  ${list_FINANCE_Request}

CDLCreateNormal_FinanceConfirm_TC007            
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     Reserve Request    ${\n}

        ...     TEST STEPS:
        ...     1.กรอกข้อมูล REQUEST NO.: CL20220000951
        ...     2.คลิกปุ่ม Search
        ...     3.คลิกปุ่ม RESERVE ใบ Request No.  CL20220000951 ที่ตารางแสดงข้อมูล Column ACTION
        ...     4.คลิกปุ่ม OK ที่ Popup Confirm
        ...     5.คลิก Checkbox หน้า Request
        ...     6.คลิกปุ่ม CONFIRM   ${\n}

        ...     Expected Result
        ...     - Request Status = CONFIRM
        ...     - ส่ง Request ไปยัง FI คนถัดไปตาม ระยะเวลาที่ขออนุมัติ  ${\n}

        Get File Text Request
        Input Text :  ${loc_requsetNo}  ${CANewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${checkbox_request}
        Click Element :  ${req_Confirm}
        Click Element :  ${POPUP_contains_OK}
        Logout in CREDIT LINE
        Logout Employee
        Close Window
        
CDLCreateNormal_FinanceConfirm_TC008            # FI (3) Confirm Request
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI Confirm Request     ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : patchanl 
        ...      Pass : patchanl 
        ...     3.ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Term
        ...     5. คลิกเมนู Finance ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Finance  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_patchanl}   # FI Confirm Request 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${Menu_CreateTerm}
        Click Element :  ${menu_FINANCIAL}
        Validate List Data And Should Be Visible :  ${list_FINANCE_Request}

CDLCreateNormal_FinanceConfirm_TC009
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     Confirm Request    ${\n}

        ...     TEST STEPS:
        ...     1.กรอกข้อมูล REQUEST NO.: CL20220000951
        ...     2.คลิกปุ่ม Search
        ...     3.คลิก Checkbox หน้า Request
        ...     4.คลิกปุ่ม CONFIRM  ${\n}

        ...     Expected Result
        ...     - Request Status = CONFIRM  ${\n}

        Get File Text Request
        Input Text :  ${loc_requsetNo}  ${CANewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${checkbox_request}
        Click Element :  ${req_Confirm}
        Click Element :  ${POPUP_Btn_OK}
        Logout in CREDIT LINE
        Logout Employee
        Close Window

CDLCreateNormal_FinanceConfirm_TC010            # FI (4) Close Request 
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI Close Request     ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:   #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : nakanyal 
        ...      Pass: nakanyal 
        ...     3.ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Term
        ...     5. คลิกเมนู Tracking  ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Tracking  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_nakanyal}   # FI Close Request 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${Menu_CreateTerm}
        Click Element :  ${Menu_TRACKING}
        Validate List Data And Should Be Visible :  ${list_TRACKING}
    
CDLCreateNormal_FinanceConfirm_TC011
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     Close Request     ${\n}

        ...     TEST STEPS:
        ...     1.กรอกข้อมูล REQUEST NO.: CT20220000093
        ...     2.คลิกปุ่ม Search
        ...     3.เลือก  Request
        ...     4.คลิกปุ่ม Close(X) ที่ Column ACTION
        ...     5.คลิกปุ่ม Close ที่ Popup Colse ${\n}

        ...     Expected Result
        ...     - Request Status = COMPLETE  ${\n}

        Get File Text Request
        Input Text :  ${loc_requsetNo}  ${CANewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${checkbox_request}
        Click Element :  ${btn_close}
        Click Element :  ${button_close}
        Check Request Status :  ${CANewRequestNo}  ${loc_getStatus_request}  ${Complete}             # Check Request Status : Create  parameter :: ${RequestNo}  ${loc_getValue}  ${value}
        Logout in CREDIT LINE
        Logout Employee
        Close Window






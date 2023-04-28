*** Settings ***
Metadata          Version 1.0.0
Library           Selenium2Library
Resource          ../Resources/Keywords/CDL_Common_Keyword.robot
Resource          ../Resources/Repository/CDL_Common_Repository.robot
Resource          ../Resources/Variables/CDL_Common_TestData.robot
Resource          ../Resources/Variables/CDL_Common_Variables.robot

# Test Teardown       Close All Browsers
        
*** Test Cases ***

CDLCreateNormal_CreateRequest_TC001     # Create Request
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Create  Request Credit Line Type : Normal  ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User: siriratt
        ...      Pass: siriratt
        ...     3 ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Create Request -> คลิก Request  ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Create Request Step 1 ค้นหาข้อมูลลูกค้า

        Login at Employee Services :  ${URL_CDL_Test}  ${user_siriratt}    # User Create
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${menu_CreateRequest}
        Click Element :  ${subMenu_Request}
        Validate List Data And Should Be Visible :  ${list_searchCustomer}
        # Capture Page Screenshot
        
CDLCreateNormal_CreateRequest_TC002
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Tab "ค้นหาข้อมูลลูกค้า"  ${\n}

        ...     TEST STEPS:
        ...     1. ระบุ SFF CUSTOMER NAME = พีทีที แอลเอ็นจี
        ...     2. ระบุ SFF ACCOUNT NO. = 1499077492
        ...     3. ระบุ SFF TAX ID = 105547000000
        ...     4. คลิกปุ่ม Next
        ...     5. คลิกปุ่ม Choose ที่ Popup SEARCH CUSTOMER NAME  ${\n}

        ...     Expected Result
        ...     - ระบบนำ Account ที่ Choose ไปแสดงที่ Step2 ระบุข้อมูลเพื่อพิจารณา

        # ---------------------------------------------------------------
        ## STEP 1 ค้นหาข้อมูลลูกค้า
        Input Text :  ${Search_SFF_CUSTOMER_NAME}  ${CUSTOMERNAME}
        Input Text :  ${Search_SFF_Account_No}  ${ACCOUNT_NO}
        Input Text :  ${Search_SFF_TAX_ID}  ${TAX_ID}
        Click Element :  ${btn_NEXT}
        Validate List Data And Should Be Visible :  ${list_SEARCH_CUSTOMER_NAME}
        Click Element :  ${Choose}
        Validate List Data And Should Be Visible :  ${list_step2_consideration}
        Capture Page Screenshot

CDLCreateNormal_CreateRequest_TC003
        [Tags]      CreateRequest
        [Documentation]
        ...     Test Case:
        ...     Tab "ระบุข้อมูลเพื่อพิจารณา"  ${\n}

        ...     TEST STEPS:
        ...     1. เลือก จำนวนพนักงาน / NO. OF EMPLOYEE : <25
        ...     2. เลือก CREDIT LINE TYPE : Normal
        ...     3. ระบุ SALE FORECAST AWN : 2,000,000
        ...     4. คลิกปุ่ม Next ${\n}

        ...     Expected Result
        ...     - ระบบจะนำข้อมูล CUSTOMER INFORMATION และข้อมูลประกอบการพิจารณา ไปแสดงที่ Step3 สรุปข้อมูล  ${\n}

        ...     Remark
        ...     - กรณีมีวงเงิน Normal แล้วในระบบ จะแสดง Popup Warning 
        ...     "Found Credit Line Type Normal is active. 
        ...     Credit Line Start Date From : DD/MM/YYYY To : DD/MM/YYYY"

        # ---------------------------------------------------------------
        ## STEP 2 ระบุข้อมูลเพื่อพิจารณา
        Select NO OF EMPLOYEE : less 25         # default
        Select CREDIT LINE TYPE : Normal        # default
        Input Value AWN
        Click Element :  ${button_NEXT}     
        Check RequestNO in system :  Normal      
        Click Element :  ${POPUP_Comfirm_Btn_YES}
        Capture Page Screenshot

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
        ...     CUSTOMER NAME :พีทีที แอลเอ็นจี 
        ...     ACCOUNT NO :1499077492 
        ...     SAP CODE : 
        ...     REQUEST NO : CL20210039348 
        ...     CREDIT LINE TYPE :Normal 
        ...     SEND MAIL TO FI :NO
        ...     - ได้เอกสาร Request Credit Line Type Normal ในระบบ 
        ...     - Request Status = CREATE

        ## STEP 3 สรุปข้อมูล
        Validate List Data And Should Be Visible :  ${list_RequestInformation}
        Click Element :  ${btn_Confirm}
        Validate List Data And Should Be Visible :  ${list_verify_data}
        Get Text New Request No Type Normal
        Click Element :  ${NEW_REQUEST_NO_Button_OK}
        Check Request Status :  ${NewRequestNo}  ${loc_getStatus}  ${Create}       # Check Request Status : Create  parameter :: ${RequestNo}${loc_getValue}${value}
        Logout in CREDIT LINE
        Logout Employee
        Close Window

CDLCreateNormal_FinanceConfirm_TC001    # FI (1) (MAKER) Finance Confirm
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI (MAKER) Confirm Request  ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User: sirigunn 
        ...      Pass: sirigunn
        ...     3.ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Financial${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Finance  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_sirigunn}   # FI (MAKER) Finance Confirm 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${menu_FINANCIAL}
        Validate List Data And Should Be Visible :  ${list_FINANCE}

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

        Get File Text Normal            # Get value varible ${NewRequestNo}
        Input Text :  ${loc_requsetNo}  ${NewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${RESERVE_normal}
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
        ...     Tab "OUTPUT" ข้อมูลอื่นๆ   ${\n}

        ...     TEST STEPS:
        ...     1. ระบุ Max Credit Line by Financial Statement
        ...     2. ระบุ Max. Credit Limit By Segment 
        ...     3. คลิกปุ่ม RE-CALCULATE
        ...     4. คลิกปุ่ม SAVE
        ...     5. ระบุ Reason : 
        ...     6. คลิกปุ่ม SAVE ${\n}

        ...     Expected Result
        ...     - ระบบแสดงข้อมูลที่กรอก
        ...     - แสดง Amount Approved (Baht) ตามที่ FI ระบุ  ${\n}

        Input Text :  ${Max_Financial_Statement}  ${Max_Credit}
        Input Text :  ${Max_CreditByCate}  ${Max_Credit}
        Click Element :  ${btn_Recalculate}
        Check data in excel :  ${Available}
        Click Element :  ${btn_Edite_Save}
        Select Reason

CDLCreateNormal_FinanceConfirm_TC005
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     Tab "OUTPUT" ข้อมูลอื่นๆ   ${\n}

        ...     TEST STEPS:
        ...     1.คลิกปุ่ม OK ที่ Popup Confirm
        ...     2. คลิกปุ่ม Confirm ${\n}

        ...     Expected Result
        ...     - Request Status = CONFIRM
        ...     - ส่ง Request ไปยัง FI (CHECKER) คนต่อไป  ${\n}

        Wait Until Element Is Visible   ${popup_Confirm}   240s
        # Do you want to Confirm now? 
        Click Element :  ${POPUP_Btn_OK}
        Click Element :  ${popup_comment_Confirm}
        Get File Text Normal
        Check Request Status :  ${NewRequestNo}  ${loc_getStatus}  ${Confirm}       # Check Request Status : Create  parameter :: ${RequestNo}${loc_getValue}${value}
        Wait Loading screen Not Visible
        Logout in CREDIT LINE
        Logout Employee
        Close Window

CDLCreateNormal_FinanceConfirm_TC006    # FI (2) (CHECKER) Finance Confirm 
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI (CHECKER) Confirm Request    ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : jantaric 
        ...      Pass : jantaric 
        ...     3.ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Financial ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Finance  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_jantaric}   # FI (CHECKER) Confirm Request 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${menu_FINANCIAL}
        Validate List Data And Should Be Visible :  ${list_FINANCE}

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
        ...     - ส่ง Request ไปยัง FI คนถัดไปตามวงเงิน  ${\n}

        Get File Text Normal            # Get value varible ${NewRequestNo}
        Input Text :  ${loc_requsetNo}  ${NewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${RESERVE_normal}
        Click Element :  ${POPUP_Btn_OK}
        Click Element :  ${checkbox_request}
        Click Element :  ${multiple_Confirm}
        Click Element :  ${POPUP_contains_OK}
        Wait Loading screen Not Visible
        Logout in CREDIT LINE
        Logout Employee
        Close Window
        
CDLCreateNormal_FinanceConfirm_TC008    # FI (3) Confirm Request 
        [Tags]      FinanceConfirm
        [Documentation]
        ...     Test Case:
        ...     FI Confirm Request    ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Employee Services
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : patchanl 
        ...      Pass : patchanl 
        ...     3.ระบบแสดงหน้าจอ Employee Service -> คลิก Menu Corporate Credit Line -Staging
        ...     4.คลิกเลือก Menu Financia ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ Finance  ${\n}

        Login at Employee Services :  ${URL_CDL_Test}  ${user_patchanl}   # FI Confirm Request 
        Click Element :  ${menu_Corporate_CreditLine_Staging}
        Switch Window to CREDIT LINE
        Click Element :  ${menu_FINANCIAL}
        Validate List Data And Should Be Visible :  ${list_FINANCE}

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
        ...     - Request Status = CONFIRM
        ...     - ส่ง Request ไปยัง COA   ${\n}

        Get File Text Normal            # Get value varible ${NewRequestNo}
        Input Text :  ${loc_requsetNo}  ${NewRequestNo}
        Click Element :  ${FINANCE_Search}
        Click Element :  ${checkbox_request}
        Click Element :  ${multiple_Confirm}
        Click Element :  ${POPUP_contains_OK}
        Wait Loading screen Not Visible
        Logout in CREDIT LINE
        Logout Employee
        Close Window

CDLCreateNormal_COAApprove_TC001        # COA Approve (1)
        [Tags]      COA_Approve
        [Documentation]
        ...     Test Case:
        ...     COA Approve  ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Corporate Online Approve 
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : kositv 
        ...      Pass: kositv 
        ...     3.คลิกปุ่ม Submit  ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ COA Need Approve

        Login at COA :  ${URL_COA_TEST}  ${user_kositv}
        Validate List Data And Should Be Visible :  ${list_COA_NeedApprove}
        Wait Loading screen Not Visible
        
CDLCreateNormal_COAApprove_TC002
        [Tags]      COA_Approve
        [Documentation]
        ...     Test Case:
        ...     Click Approve Request  ${\n}

        ...     TEST STEPS:
        ...     1. คลิกเมนู Need Approve
        ...     2. คลิก Corporate Sales
        ...     3. คลิก Request ที่ต้องการ Approve : CL20220000951
        ...     4. คลิกปุ่ม Approve
        ...     5. คลิกปุ่ม OK ที่ Popup Confirm
        ...     6.คลิกปุ่ม OK ที่ Popup Approve  ${\n}

        ...     Expected Result
        ...     - Request Status = APPROVE
        ...     - ส่ง Request ไปยัง COA คนถัดไปตามวงเงิน  ${\n}

        ...     Remark
        ...     กรณีไม่ต้องการปลี่ยนแปลงวงเงิน Amount Approved (Baht) 
        ...     สามารถคลิกปุ่ม Confirm Request ที่ต้องการได้เลย


        Click Element :  ${CorporateSales}
        Get File Text Normal            # Get value varible ${NewRequestNo}
        Input Text :  ${Search_Filter}  ${NewRequestNo}
        Click Element :  ${view_Transaction}
        Click Element :  ${coa_Approve}
        Click Element :  ${coa_btn_ok}
        Wait Loading screen Not Visible
        Click Element :  ${coa_btn_ok}
        Capture Page Screenshot
        Logout COA
        Close Window

CDLCreateNormal_COAApprove_TC003        # COA Approve (2)    
        [Tags]      COA_Approve
        [Documentation]
        ...     Test Case:
        ...     COA คนสุดท้าย Approve  ${\n}

        ...     TEST STEPS:
        ...     1.Login เข้าระบบ Corporate Online Approve 
        ...     Enter URL:  #url test
        ...     2.ระบุ user/password ที่มีในระบบ LDAP
        ...      User : ernestle
        ...      Pass : ernestle   ${\n}

        ...     Expected Result
        ...     - ระบบแสดงหน้าจอ COA Need Approve

        Get File Text Normal            # Get value varible ${NewRequestNo}
        Login at COA :  ${URL_COA_TEST}  ${user_ernestle}         # COA คนสุดท้าย Approve
        Validate List Data And Should Be Visible :  ${list_COA_NeedApprove}

CDLCreateNormal_COAApprove_TC004
        [Tags]      COA_Approve
        [Documentation]
        ...     Test Case:
        ...     Click Approve Request  ${\n}

        ...     TEST STEPS:
        ...     1. คลิกเมนู Need Approve
        ...     2. คลิก Corporate Sales
        ...     3. คลิก Request ที่ต้องการ Approve : CL20220000951
        ...     4. คลิกปุ่ม Approve
        ...     5. คลิกปุ่ม OK ที่ Popup Confirm
        ...     6.คลิกปุ่ม OK ที่ Popup Approve  ${\n}

        ...     Expected Result
        ...     - Request Status = COMPLETE
        ...     - ได้รับวงเงิน Credit Line Normal ในระบบ CDL  ${\n}

        Click Element :  ${CorporateSales}
        Get File Text Normal            # Get value varible ${NewRequestNo}
        Input Text :  ${Search_Filter}  ${NewRequestNo}
        Click Element :  ${view_Transaction}
        Click Element :  ${coa_Approve}
        Click Element :  ${coa_btn_ok}
        Wait Loading screen Not Visible
        Click Element :  ${coa_btn_ok}
        Capture Page Screenshot
        Logout COA
        Close Window



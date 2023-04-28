*** Variables ***

${loc_Username}  id:field2
${loc_Password}  id:field1
${btn_ok}  id:loginBtn
${btn_cancel}  id:clearBtn
${btn_logout}  //img[contains(@src,'logout.gif')]           # Click logout
${btn_temporaryLogin}  //img[@src='images/LogonUSB/15-TempBtn.png']     # Click Temporary Login
${menu_Corporate_CreditLine_Staging}   (//tr[contains(.,'Corporate Credit Line -Staging')])[4]
${CREDITLINE_btn_logout}  //a[contains(.,'LOGOUT')]
${subMenu_Request}  //a[@class='sub'][contains(.,'REQUEST')]
@{list_searchCustomer}
...  ${Search_SFF_CUSTOMER_NAME}
...  ${Search_SFF_Account_No}
...  ${Search_SFF_TAX_ID}
...  id:Search_SAP_CUSTOMER_NAME
...  id:Search_SAP_CODE
...  id:Search_SAP_TAX_ID

${Search_SFF_CUSTOMER_NAME}  id:Search_SFF_CUSTOMER_NAME
${Search_SFF_Account_No}  id:Search_SFF_Account_No
${Search_SFF_TAX_ID}  id:Search_SFF_TAX_ID
${btn_NEXT}  id:search      # Next step 1
${Choose}  //*[@id="105547000000"]

@{list_SEARCH_CUSTOMER_NAME}
...  (//h3[contains(.,'SEARCH CUSTOMER NAME')])[1]

${loc_inputText_AWN}  id:Text_FORECAST_AMT_0

@{list_step2_consideration}
...  ${loc_inputText_AWN}

${button_NEXT}   id:next
${WARNING_POPUP}  (//div[contains(@class,'modal-content')])[3]
@{list_validatePOPUP_Create}
...  //div[@class='modal-header'][contains(.,'WARNING')]
...  //div[contains(@class,'modal-body')]
...  //button[@data-bb-handler='danger'][contains(.,'NO')]
...  ${POPUP_Comfirm_Btn_YES}

${POPUP_Comfirm_Btn_YES}  //button[@data-bb-handler='main'][contains(.,'YES')]

@{list_validatePOPUP}
...  ${POPUP_WARNING}
...  ${POPUP_BODY}
...  ${POPUP_Btn_OK}

${POPUP_WARNING}  //h4[@class='modal-title'][contains(.,'WARNING')]
${POPUP_BODY}   //div[contains(@class,'modal-body')]
${POPUP_Btn_OK}  //button[contains(.,'OK')]
${menu_FINANCIAL}  //a[@class='main-menu'][contains(.,'FINANCIAL')]

@{list_FINANCE}
...  //span[@class='greenHeaderFont'][contains(.,'FINANCE')]
...  id:GridWaitingList
...  id:multipleConfirm

@{list_FINANCE_Request}
...  //span[@class='greenHeaderFont'][contains(.,'FINANCE')]
...  id:GridWaitingList
...  //a[contains(@onclick,'MultiConfirm()')]

${multiple_Confirm}  id:multipleConfirm
${req_Confirm}  //a[contains(@onclick,'MultiConfirm()')]
${loc_requsetNo}  id:requsetNo
${FINANCE_Search}  id:trackingSearch

@{list_RequestInformation}
...  //p[contains(.,'พีทีที แอลเอ็นจี')]
...  //p[contains(.,'1499077492')]
...  //td[@class='text-left'][contains(.,'Normal')]
...  (//td[@class='text-left'][contains(.,'No')])[2]
...  ${btn_Confirm}

${btn_Back}  id:back
${btn_Confirm}  id:confirm

@{list_verify_data}
...  //div[@class='modal-content']
...  //div[@class='col-md-4 padtop10'][contains(.,'พีทีที แอลเอ็นจี')]
...  //div[@class='col-md-4 padtop10'][contains(.,'1499077492')]
...  ${NEW_NormalREQUEST_NO}
...  //div[@class='col-md-4 padtop10'][contains(.,'Normal')]
...  //div[@class='col-md-4 padtop10'][contains(.,'NO')]
...  ${NEW_REQUEST_NO_Button_OK}

${NEW_NormalREQUEST_NO}   (//div[@class='col-md-4 padtop10'])[4]
${NEW_REQUEST_NO_Button_OK}   //button[@type='submit'][contains(.,'OK')]
${Menu_TRACKING}  //a[@class='main-menu'][contains(.,'TRACKING')]
${Create}  Create
${Confirm}  Confirm
${RESERVE_normal}  //a[contains(@class,'k-button k-grid-gridReserve')]
${RESERVE}  //a[contains(@class,'k-button k-grid-gridReserve')]

${popup_btn_confirm}  //button[@data-bb-handler='confirm'][contains(.,'OK')]
${Edit_request}  //a[contains(@class,'k-button k-grid-gridEdit')]

@{list_PanelEDIT}
...  //div[@class='panel-heading'][contains(.,'CUSTOMER INFORMATION')]
...  //div[@class='panel-heading'][contains(.,'เปรียบเทียบงบดุล (Balance Sheet)')]
...  ${add_BalanceSheet}
...  ${add_Statement}
...  ${btn_Recalculate}

${add_BalanceSheet}  (//a[contains(@onclick,'addYear()')])[1]
${add_Statement}  (//a[contains(@onclick,'addYear()')])[2]
${btn_GoBack}  //a[contains(@onclick,'GoBack()')]
${btn_Recalculate}  //a[contains(@onclick,'Recalculate()')]
${file_path}        ${CURDIR}\\File\\Financial_Statement_2561.xlsx
${import_file}  //div[@class='k-button k-upload-button'][contains(.,'Select files...')]
${upload_completed}   //li[contains(.,'uploadedFinancial_Statement_2561.xlsx100%')]
${btn_ImportFile}   id:btnImportFile

@{list_validate_dataImport}
...  (//th[@class='center col-md-1'][contains(.,'2561')])[1]
...  (//th[@class='center col-md-1'][contains(.,'2561')])[2]

${Max_Financial_Statement}  id:MaxCreditLine
${Max_CreditByCate}  id:MaxCreditByCate
${btn_Edite_Save}  id:btnEditeConfirm
${button_Edite_Confirm}  //a[contains(@onclick,'EditeConfirm()')]
${DropDown_list_reason}  //span[contains(@aria-owns,'DropDownSave_listbox')]
${reason_1}  //li[contains(.,'ข้อมูลไม่ถูกต้อง วงเงินที่ได้รับครอบคลุมมูลค่า Handset Cost และ Airtime 6 เดือน')]
${popup_Confirm}  //div[@class='modal-header'][contains(.,'Confirm')]
${popup_comment_Confirm}  //a[contains(@onclick,'ConfirmAction()')]
${loading}   //div[contains(@class,'img-loading')]
${CorporateSales}  id:ul_viewCategory
${Search_Filter}  id:textFilter
${view_Transaction}  id:ul_viewTransaction
${COA_locUername}   //input[contains(@placeholder,'Username')]
${COA_locPassword}  //input[contains(@placeholder,'Password')]
${COA_btn_Submit}   //a[@data-bind='click: onLogin'][contains(.,'Submit')]

@{list_COA_NeedApprove}
...  //div[@class='coa-web-textHeader'][contains(.,'Need Approve')]
...  ${COA_btn_logout}

${COA_btn_logout}  //a[@onclick='logout();'][contains(.,'Log Out')]
${COA_btn_confirmLogout}  //button[@data-bb-handler='main'][contains(.,'OK')]
${menu_Need Approve}  //a[contains(.,'Need Approve${SPACE * 16}0')]

${coa_Approve}  //a[@data-role='button'][contains(.,'Approve')]
${coa_btn_ok}  //button[@data-bb-handler='main'][contains(.,'OK')]
${coa_btn_ok_complete}  //button[@data-bb-handler='main'][contains(.,'OK')]
${header_popup}  //h4[@class='modal-title']
${upload_files}  id:files

${loc_getStatus}  (//td[contains(@role,'gridcell')])[6]
${loc_getStatus_Confirm}  (//td[contains(@role,'gridcell')])[6]
${Menu_CreateTerm}  //a[@class='main-menu'][contains(.,'CREDIT TERM')]
${CREDIT_LINE_TYPE}  (//span[@unselectable='on'][contains(.,'Normal')])[3]
${TOTAL}  id:Text_FORECAST_TOTAL

${Available}  //td[@class='center'][contains(.,'2,000,000.00')]
${Menu_CREATE_REQUEST}  //a[@class='main-menu'][contains(.,'CREATE REQUEST')]

@{list_validate_CREATE_REQUEST}
...  //span[@class='greenHeaderFont'][contains(.,'CREATE REQUEST')]
...  id:Search_SFF_CUSTOMER_NAME
...  id:Search_SFF_TAX_ID
...  id:Search_SFF_Account_No

${SFF_CUSTOMER_NAME}  id:Search_SFF_CUSTOMER_NAME

@{list_SEARCH_SFF_CUSTOMERNAME}
...  (//td[contains(@role,'gridcell')])[1]
...  //td[@role='gridcell'][contains(.,'31200000783575')]
...  //td[@role='gridcell'][contains(.,'ทิปโก้มารีไทม์')]

${Choose_SFF_CUSTOMERNAME}  id:0105538016616

@{list_Information_consideration}
...  //p[contains(.,'ทิปโก้มารีไทม์')]
...  //p[contains(.,'31200000783575')]
...  id:fileOther

${CREDIT_TERM_LEVEL}  (//span[@unselectable='on'][contains(.,'CA')])[3]
${SALE_REQUEST}  (//span[@unselectable='on'][contains(.,'35 Days')])[3]
${Reason_listbox}  //span[contains(@aria-owns,'ddlReason_listbox')]
${Reason_listbox_option1}  //li[@tabindex='-1'][contains(.,'เป็นนโยบายของบริษัท ลูกค้าในการขยายเวลาชำระเงิน')]

@{list_Total_Information_consideration}
...  //p[contains(.,'ทิปโก้มารีไทม์')]
...  //p[contains(.,'31200000783575')]
...  //span[@class='lbl-normal normalFont'][contains(.,'35 Days')]
...  //span[@class='lbl-normal normalFont'][contains(.,'เป็นนโยบายของบริษัท ลูกค้าในการขยายเวลาชำระเงิน')]
...  //span[@class='lbl-normal normalFont'][contains(.,'No')]
...  id:back
...  id:confirm

@{list_velidate_Information_Popup}
...  //div[@class='col-md-4 padtop10'][contains(.,'ทิปโก้มารีไทม์')]
...  //div[@class='col-md-4 padtop10'][contains(.,'31200000783575')]
...  //div[@class='col-md-4 padtop10'][contains(.,'CA')]
...  //div[@class='col-md-4 padtop10'][contains(.,'NO')]

${REQUEST_CA_NO}  (//div[contains(@class,'col-md-4 padtop10')])[3]
${loc_getStatus_request}  (//td[contains(@role,'gridcell')])[7]
${ApprovedCreditTerm}  //input[@value='35']
${btn_SaveReCal}  id:btnSaveReCal

@{list_TRACKING}
...  //ol[@class='breadcrumb'][contains(.,'TRACKING')]
...  id:requsetNo
...  id:trackingSearch

${btn_close}  //a[contains(@title,'CLOSE')]
${button_close}  id:btnConfirmReason
${Complete}  Complete

@{list_CREATE_REQUEST_Step1}
...  //p[contains(.,'31200000783575')]
...  //p[contains(.,'ทิปโก้มารีไทม์')]
...  //p[contains(.,'0105538016616')]

${POPUP_contains_OK}  //button[@data-bb-handler='main'][contains(.,'OK')]
${SaveReCal}  //a[contains(@onclick,'SaveReCal()')]
${checkbox_request}  (//td[contains(@role,'gridcell')])[1]
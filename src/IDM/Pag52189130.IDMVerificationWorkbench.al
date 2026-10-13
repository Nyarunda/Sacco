page 50889 "IDM Verification Workbench"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'IDM Verification Workbench';

    layout
    {
        area(Content)
        {
            group(Request)
            {
                Caption = 'Verification Request';

                field(VerificationType; VerificationType)
                {
                    ApplicationArea = All;
                    Caption = 'Verification Type';
                    ToolTip = 'Select the type of verification to perform.';

                    trigger OnValidate()
                    begin
                        ClearInputs();
                        ClearResult();
                        UpdateVisibility();
                        SetResultVisibility();
                    end;
                }
                field(MemberNo; MemberNo)
                {
                    ApplicationArea = All;
                    Caption = 'Member No.';
                    ToolTip = 'Optionally link this verification to a member (leave blank for standalone checks).';
                    TableRelation = Customer."No.";

                    trigger OnValidate()
                    var
                        Customer: Record Members;
                    begin
                        if MemberNo <> '' then begin
                            if Customer.Get(MemberNo) then
                                MemberName := Customer.Name;
                        end else
                            MemberName := '';
                    end;
                }
                field(MemberName; MemberName)
                {
                    ApplicationArea = All;
                    Caption = 'Member Name';
                    ToolTip = 'Name of the linked member.';
                    Editable = false;
                }
            }
            group(Identifiers)
            {
                Caption = 'Identifiers';

                group(NID_Input)
                {
                    Caption = 'National ID';
                    Visible = ShowNationalIDInput;

                    field(NID_IDField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'National ID Number';
                        ToolTip = 'Kenya National ID number (6-20 characters).';
                    }
                }
                group(AlienID_Input)
                {
                    Caption = 'Alien ID';
                    Visible = ShowAlienIDInput;

                    field(Alien_IDField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Alien ID Number';
                        ToolTip = 'Alien / Foreign Resident ID number (6-15 characters).';
                    }
                }
                group(KRAPIN_Input)
                {
                    Caption = 'KRA PIN';
                    Visible = ShowKRAPINInput;

                    field(KRA_PINField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'KRA PIN';
                        ToolTip = 'KRA PIN — 11 characters, e.g. A123456789Z.';
                    }
                }
                group(DL_Input)
                {
                    Caption = 'Driving Licence';
                    Visible = ShowDLInput;

                    field(DL_LicenceField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Licence Number';
                        ToolTip = 'Driving licence number (5-20 characters).';
                    }
                }
                group(Phone_Input)
                {
                    Caption = 'Phone Verification';
                    Visible = ShowPhoneInput;

                    field(Ph_IDField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'National ID Number';
                        ToolTip = 'National ID number of the phone holder.';
                    }
                    field(Ph_PhoneField; PhoneNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Phone Number';
                        ToolTip = 'Phone number to verify (any format: 07XX, +2547XX, or 2547XX).';
                    }
                }
                group(Vehicle_Input)
                {
                    Caption = 'Vehicle';
                    Visible = ShowVehicleInput;

                    field(Veh_RegField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration Number';
                        ToolTip = 'Vehicle plate number (e.g. KAA123A).';
                    }
                }
                group(BizUBO_Input)
                {
                    Caption = 'Business UBO';
                    Visible = ShowBizUBOInput;

                    field(Biz_RegField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration Number';
                        ToolTip = 'Company registration number (e.g. C.123456).';
                    }
                }
                group(BankAcc_Input)
                {
                    Caption = 'Bank Account';
                    Visible = ShowBankAccInput;

                    field(Bank_AccField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'Account Number';
                        ToolTip = 'Bank account number (5-20 characters).';
                    }
                    field(Bank_BankIDField; BankID)
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Code (CBK)';
                        ToolTip = 'Three-digit CBK bank code (e.g. 031 = Equity, 011 = Co-op, 001 = KCB).';
                    }
                }
                group(CreditRep_Input)
                {
                    Caption = 'Credit Report';
                    Visible = ShowCreditRepInput;

                    field(CR_IDField; IDNumber)
                    {
                        ApplicationArea = All;
                        Caption = 'National ID Number';
                        ToolTip = 'National ID number for credit report retrieval (6-10 digits).';
                    }
                }
            }
            group(Result)
            {
                Caption = 'Verification Result';
                Editable = false;
                Visible = ResultEntryNo <> 0;

                field(ResultStatus; ResultStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Result of the last verification.';
                    StyleExpr = ResultStatusStyle;
                    Editable = false;
                }
                field(ResultErrorMessage; ResultErrorMessage)
                {
                    ApplicationArea = All;
                    Caption = 'Error / Message';
                    ToolTip = 'Error or informational message returned by the API.';
                    Editable = false;
                    Visible = ResultHasError;
                    StyleExpr = 'Unfavorable';
                }
                group(NationalIDResult)
                {
                    Caption = 'National ID';
                    Visible = ShowNationalID;

                    field(NID_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Full Name';
                        Editable = false;
                    }
                    field(NID_DOB; ResultDOB)
                    {
                        ApplicationArea = All;
                        Caption = 'Date of Birth';
                        Editable = false;
                    }
                    field(NID_Gender; ResultGender)
                    {
                        ApplicationArea = All;
                        Caption = 'Gender';
                        Editable = false;
                    }
                    field(NID_Citizenship; ResultCitizenship)
                    {
                        ApplicationArea = All;
                        Caption = 'Citizenship';
                        Editable = false;
                    }
                    field(NID_DistrictOfBirth; ResultDistrictOfBirth)
                    {
                        ApplicationArea = All;
                        Caption = 'District of Birth';
                        Editable = false;
                    }
                    field(NID_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(AlienIDResult)
                {
                    Caption = 'Alien ID';
                    Visible = ShowAlienID;

                    field(Alien_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Full Name';
                        Editable = false;
                    }
                    field(Alien_DOB; ResultDOB)
                    {
                        ApplicationArea = All;
                        Caption = 'Date of Birth';
                        Editable = false;
                    }
                    field(Alien_Gender; ResultGender)
                    {
                        ApplicationArea = All;
                        Caption = 'Gender';
                        Editable = false;
                    }
                    field(Alien_Citizenship; ResultCitizenship)
                    {
                        ApplicationArea = All;
                        Caption = 'Citizenship';
                        Editable = false;
                    }
                }
                group(KRAPINResult)
                {
                    Caption = 'KRA PIN';
                    Visible = ShowKRAPin;

                    field(KRA_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Taxpayer Name';
                        Editable = false;
                    }
                    field(KRA_TradingName; ResultTradingName)
                    {
                        ApplicationArea = All;
                        Caption = 'Trading Name';
                        Editable = false;
                    }
                    field(KRA_TaxStatus; ResultTaxStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Tax Status';
                        Editable = false;
                    }
                    field(KRA_PAYERegistered; ResultPAYERegistered)
                    {
                        ApplicationArea = All;
                        Caption = 'PAYE Registered';
                        Editable = false;
                    }
                    field(KRA_VATRegistered; ResultVATRegistered)
                    {
                        ApplicationArea = All;
                        Caption = 'VAT Registered';
                        Editable = false;
                    }
                    field(KRA_RegDate; ResultRegistrationDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration Date';
                        Editable = false;
                    }
                    field(KRA_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(DrivingLicenceResult)
                {
                    Caption = 'Driving Licence';
                    Visible = ShowDrivingLicence;

                    field(DL_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Holder Name';
                        Editable = false;
                    }
                    field(DL_DOB; ResultDOB)
                    {
                        ApplicationArea = All;
                        Caption = 'Date of Birth';
                        Editable = false;
                    }
                    field(DL_Gender; ResultGender)
                    {
                        ApplicationArea = All;
                        Caption = 'Gender';
                        Editable = false;
                    }
                    field(DL_LicenceClass; ResultLicenceClass)
                    {
                        ApplicationArea = All;
                        Caption = 'Licence Class';
                        Editable = false;
                    }
                    field(DL_LicenceExpiry; ResultLicenceExpiry)
                    {
                        ApplicationArea = All;
                        Caption = 'Expiry Date';
                        Editable = false;
                    }
                    field(DL_Status; ResultRegistrationStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Licence Status';
                        Editable = false;
                    }
                    field(DL_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(PhoneResult)
                {
                    Caption = 'Phone Verification';
                    Visible = ShowPhoneResult;

                    field(Ph_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Registered Name';
                        Editable = false;
                    }
                    field(Ph_PhoneMatched; ResultPhoneMatched)
                    {
                        ApplicationArea = All;
                        Caption = 'Phone Matched';
                        Editable = false;
                    }
                    field(Ph_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(VehicleResult)
                {
                    Caption = 'Vehicle';
                    Visible = ShowVehicle;

                    field(Veh_Make; ResultVehicleMake)
                    {
                        ApplicationArea = All;
                        Caption = 'Make';
                        Editable = false;
                    }
                    field(Veh_Model; ResultVehicleModel)
                    {
                        ApplicationArea = All;
                        Caption = 'Model';
                        Editable = false;
                    }
                    field(Veh_Color; ResultVehicleColor)
                    {
                        ApplicationArea = All;
                        Caption = 'Color';
                        Editable = false;
                    }
                    field(Veh_OwnerName; ResultOwnerName)
                    {
                        ApplicationArea = All;
                        Caption = 'Owner Name';
                        Editable = false;
                    }
                    field(Veh_Status; ResultRegistrationStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration Status';
                        Editable = false;
                    }
                    field(Veh_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(BusinessUBOResult)
                {
                    Caption = 'Business UBO';
                    Visible = ShowBusinessUBO;

                    field(Biz_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Business Name';
                        Editable = false;
                    }
                    field(Biz_BusinessType; ResultBusinessType)
                    {
                        ApplicationArea = All;
                        Caption = 'Business Type';
                        Editable = false;
                    }
                    field(Biz_Status; ResultRegistrationStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Business Status';
                        Editable = false;
                    }
                    field(Biz_RegDate; ResultRegistrationDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Registration Date';
                        Editable = false;
                    }
                    field(Biz_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(BankAccountResult)
                {
                    Caption = 'Bank Account';
                    Visible = ShowBankAccount;

                    field(Bank_FullName; ResultFullName)
                    {
                        ApplicationArea = All;
                        Caption = 'Account Name';
                        Editable = false;
                    }
                    field(Bank_BankName; ResultBankName)
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Name';
                        Editable = false;
                    }
                    field(Bank_AccountStatus; ResultAccountStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Account Status';
                        Editable = false;
                    }
                    field(Bank_AdditionalInfo; ResultAdditionalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Additional Details';
                        Editable = false;
                    }
                }
                group(CreditReportResult)
                {
                    Caption = 'Credit Report';
                    Visible = ShowCreditReport;

                    field(CR_CreditScore; ResultCreditScore)
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Score';
                        Editable = false;
                    }
                    field(CR_ScoreGrade; ResultScoreGrade)
                    {
                        ApplicationArea = All;
                        Caption = 'Score Grade';
                        Editable = false;
                    }
                    field(CR_CreditSummary; ResultCreditSummary)
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Summary';
                        Editable = false;
                        MultiLine = true;
                    }
                }
                field(ResultEntryNo; ResultEntryNo)
                {
                    ApplicationArea = All;
                    Caption = 'Log Entry No.';
                    ToolTip = 'IDM Verification Log entry number for this verification.';
                    Editable = false;
                }
            }
            part(History; "IDM Verification Log Part")
            {
                ApplicationArea = All;
                Caption = 'Verification History';
                SubPageLink = "Requested By" = filter(<> '');
                SubPageView = sorting("Entry No.") order(descending);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Verify)
            {
                ApplicationArea = All;
                Caption = 'Verify';
                ToolTip = 'Submit the verification request to Calwide IDM.';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IDMApi: Codeunit "IDM API Integration";
                    IDMLog: Record "IDM Verification Log";
                    EntryNo: Integer;
                begin
                    ValidateInputs();
                    ClearResult();

                    case VerificationType of
                        "IDM Verification Type"::"National ID":
                            EntryNo := IDMApi.VerifyNationalID(IDNumber, MemberNo, RequestID);
                        "IDM Verification Type"::"Alien ID":
                            EntryNo := IDMApi.VerifyAlienID(IDNumber, MemberNo, RequestID);
                        "IDM Verification Type"::"KRA PIN":
                            EntryNo := IDMApi.VerifyKRAPin(IDNumber, MemberNo, RequestID);
                        "IDM Verification Type"::"Driving Licence":
                            EntryNo := IDMApi.VerifyDrivingLicence(IDNumber, MemberNo, RequestID);
                        "IDM Verification Type"::Phone:
                            EntryNo := IDMApi.VerifyPhone(IDNumber, PhoneNumber, MemberNo, RequestID);
                        "IDM Verification Type"::Vehicle:
                            EntryNo := IDMApi.VerifyVehicle(IDNumber, MemberNo, RequestID);
                        "IDM Verification Type"::"Business UBO":
                            EntryNo := IDMApi.VerifyBusinessUBO(IDNumber, MemberNo, RequestID);
                        "IDM Verification Type"::"Bank Account":
                            EntryNo := IDMApi.VerifyBankAccount(IDNumber, BankID, MemberNo, RequestID);
                        "IDM Verification Type"::"Credit Report":
                            EntryNo := IDMApi.GetCreditReport(IDNumber, MemberNo, RequestID);
                    end;

                    // Refresh history subpage
                    CurrPage.History.Page.Update(false);

                    // Load result from log
                    if IDMLog.Get(EntryNo) then begin
                        ResultEntryNo := EntryNo;
                        ResultStatus := Format(IDMLog.Status);
                        ResultFullName := IDMLog."Full Name";
                        ResultDOB := IDMLog."Date of Birth";
                        ResultGender := IDMLog.Gender;
                        ResultAdditionalInfo := IDMLog."Additional Info";
                        ResultErrorMessage := IDMLog."Error Message";
                        ResultHasData := IDMLog.Status = IDMLog.Status::Success;
                        ResultHasError := IDMLog.Status in [IDMLog.Status::Failed, IDMLog.Status::"Not Found"];
                        // Type-specific fields
                        ResultCitizenship := IDMLog.Citizenship;
                        ResultDistrictOfBirth := IDMLog."District of Birth";
                        ResultTradingName := IDMLog."Trading Name";
                        ResultTaxStatus := IDMLog."Tax Status";
                        ResultPAYERegistered := IDMLog."PAYE Registered";
                        ResultVATRegistered := IDMLog."VAT Registered";
                        ResultLicenceClass := IDMLog."Licence Class";
                        ResultLicenceExpiry := IDMLog."Licence Expiry Date";
                        ResultRegistrationStatus := IDMLog."Registration Status";
                        ResultRegistrationDate := IDMLog."Registration Date";
                        ResultPhoneMatched := IDMLog."Phone Matched";
                        ResultVehicleMake := IDMLog."Vehicle Make";
                        ResultVehicleModel := IDMLog."Vehicle Model";
                        ResultVehicleColor := IDMLog."Vehicle Color";
                        ResultOwnerName := IDMLog."Owner Name";
                        ResultBusinessType := IDMLog."Business Type";
                        ResultBankName := IDMLog."Bank Name";
                        ResultAccountStatus := IDMLog."Account Status";
                        ResultCreditScore := IDMLog."Credit Score";
                        ResultScoreGrade := IDMLog."Score Grade";
                        ResultCreditSummary := IDMLog."Credit Summary";
                        case IDMLog.Status of
                            IDMLog.Status::Success:
                                ResultStatusStyle := 'Favorable';
                            IDMLog.Status::Failed:
                                ResultStatusStyle := 'Unfavorable';
                            IDMLog.Status::"Not Found":
                                ResultStatusStyle := 'Attention';
                            else
                                ResultStatusStyle := 'Standard';
                        end;
                        SetResultVisibility();
                    end;
                end;
            }
            action(OpenLog)
            {
                ApplicationArea = All;
                Caption = 'View Log Entry';
                ToolTip = 'Open the full log entry for the last verification.';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = ResultEntryNo <> 0;

                trigger OnAction()
                var
                    IDMLog: Record "IDM Verification Log";
                begin
                    if IDMLog.Get(ResultEntryNo) then
                        Page.Run(Page::"IDM Verification Log Card", IDMLog);
                end;
            }
            action(ViewAllLogs)
            {
                ApplicationArea = All;
                Caption = 'All Verifications';
                ToolTip = 'Open the full IDM Verification Log.';
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "IDM Verification Log List";
            }
            action(IDMSetup)
            {
                ApplicationArea = All;
                Caption = 'IDM Setup';
                ToolTip = 'Configure the Calwide IDM API connection.';
                Image = Setup;
                RunObject = Page "IDM Setup";
            }
        }
    }

    trigger OnOpenPage()
    begin
        VerificationType := "IDM Verification Type"::"National ID";
        UpdateVisibility();
    end;

    local procedure ValidateInputs()
    begin
        if VerificationType = "IDM Verification Type"::" " then
            Error('Please select a Verification Type.');
        if IDNumber = '' then
            Error('Please enter the primary identifier (ID number, KRA PIN, plate number, etc.).');
        if (VerificationType = "IDM Verification Type"::Phone) and (PhoneNumber = '') then
            Error('Please enter the Phone Number for phone verification.');
        if (VerificationType = "IDM Verification Type"::"Bank Account") and (BankID = '') then
            Error('Please enter the Bank Code for bank account verification.');
    end;

    local procedure ClearInputs()
    begin
        IDNumber := '';
        PhoneNumber := '';
        BankID := '';
    end;

    local procedure ClearResult()
    begin
        ResultEntryNo := 0;
        ResultStatus := '';
        ResultFullName := '';
        Clear(ResultDOB);
        ResultGender := '';
        ResultAdditionalInfo := '';
        ResultErrorMessage := '';
        ResultStatusStyle := 'Standard';
        ResultHasData := false;
        ResultHasError := false;
        ResultCitizenship := '';
        ResultDistrictOfBirth := '';
        ResultTradingName := '';
        ResultTaxStatus := '';
        ResultPAYERegistered := false;
        ResultVATRegistered := false;
        ResultLicenceClass := '';
        Clear(ResultLicenceExpiry);
        ResultRegistrationStatus := '';
        Clear(ResultRegistrationDate);
        ResultPhoneMatched := false;
        ResultVehicleMake := '';
        ResultVehicleModel := '';
        ResultVehicleColor := '';
        ResultOwnerName := '';
        ResultBusinessType := '';
        ResultBankName := '';
        ResultAccountStatus := '';
        ResultCreditScore := 0;
        ResultScoreGrade := '';
        ResultCreditSummary := '';
        ShowNationalID := false;
        ShowAlienID := false;
        ShowKRAPin := false;
        ShowDrivingLicence := false;
        ShowPhoneResult := false;
        ShowVehicle := false;
        ShowBusinessUBO := false;
        ShowBankAccount := false;
        ShowCreditReport := false;
    end;

    local procedure UpdateVisibility()

    var
        Customer: Record Members;
    begin
        ShowNationalIDInput := VerificationType = "IDM Verification Type"::"National ID";
        ShowAlienIDInput := VerificationType = "IDM Verification Type"::"Alien ID";
        ShowKRAPINInput := VerificationType = "IDM Verification Type"::"KRA PIN";
        ShowDLInput := VerificationType = "IDM Verification Type"::"Driving Licence";
        ShowPhoneInput := VerificationType = "IDM Verification Type"::Phone;
        ShowVehicleInput := VerificationType = "IDM Verification Type"::Vehicle;
        ShowBizUBOInput := VerificationType = "IDM Verification Type"::"Business UBO";
        ShowBankAccInput := VerificationType = "IDM Verification Type"::"Bank Account";
        ShowCreditRepInput := VerificationType = "IDM Verification Type"::"Credit Report";


        IDNumber := '';
        PhoneNumber := '';
        MemberName := '';

        if MemberNo <> '' then begin
            if Customer.Get(MemberNo) then begin
                MemberName := Customer.Name;
                PhoneNumber := Customer."Mobile Phone No.";
                if VerificationType = "IDM Verification Type"::"National ID" then
                    IDNumber := Customer."ID No.";
                if VerificationType = "IDM Verification Type"::"KRA PIN" then
                    IDNumber := Customer."KRA PIN";
                if verificationType = "IDM Verification Type"::Phone then
                    IDNumber := Customer."Mobile Phone No.";
            end;
        end else
            MemberName := '';

    end;

    local procedure SetResultVisibility()
    begin
        ShowNationalID := VerificationType = "IDM Verification Type"::"National ID";
        ShowAlienID := VerificationType = "IDM Verification Type"::"Alien ID";
        ShowKRAPin := VerificationType = "IDM Verification Type"::"KRA PIN";
        ShowDrivingLicence := VerificationType = "IDM Verification Type"::"Driving Licence";
        ShowPhoneResult := VerificationType = "IDM Verification Type"::Phone;
        ShowVehicle := VerificationType = "IDM Verification Type"::Vehicle;
        ShowBusinessUBO := VerificationType = "IDM Verification Type"::"Business UBO";
        ShowBankAccount := VerificationType = "IDM Verification Type"::"Bank Account";
        ShowCreditReport := VerificationType = "IDM Verification Type"::"Credit Report";
    end;

    var
        VerificationType: Enum "IDM Verification Type";
        MemberNo: Code[20];
        RequestID: Code[20];
        MemberName: Text[150];
        IDNumber: Text[100];
        PhoneNumber: Text[20];
        BankID: Text[10];
        ResultEntryNo: Integer;
        ResultStatus: Text[50];
        ResultFullName: Text[150];
        ResultDOB: Date;
        ResultGender: Text[10];
        ResultAdditionalInfo: Text[500];
        ResultErrorMessage: Text[500];
        ResultStatusStyle: Text;
        ResultHasData: Boolean;
        ResultHasError: Boolean;
        // Input group visibility flags (one per verification type)
        ShowNationalIDInput: Boolean;
        ShowAlienIDInput: Boolean;
        ShowKRAPINInput: Boolean;
        ShowDLInput: Boolean;
        ShowPhoneInput: Boolean;
        ShowVehicleInput: Boolean;
        ShowBizUBOInput: Boolean;
        ShowBankAccInput: Boolean;
        ShowCreditRepInput: Boolean;
        // Type-specific result fields
        ResultCitizenship: Text[50];
        ResultDistrictOfBirth: Text[100];
        ResultTradingName: Text[150];
        ResultTaxStatus: Text[50];
        ResultPAYERegistered: Boolean;
        ResultVATRegistered: Boolean;
        ResultLicenceClass: Text[20];
        ResultLicenceExpiry: Date;
        ResultRegistrationStatus: Text[50];
        ResultRegistrationDate: Date;
        ResultPhoneMatched: Boolean;
        ResultVehicleMake: Text[50];
        ResultVehicleModel: Text[50];
        ResultVehicleColor: Text[30];
        ResultOwnerName: Text[150];
        ResultBusinessType: Text[100];
        ResultBankName: Text[100];
        ResultAccountStatus: Text[50];
        ResultCreditScore: Integer;
        ResultScoreGrade: Text[5];
        ResultCreditSummary: Text[500];
        // Result group visibility flags (one per verification type)
        ShowNationalID: Boolean;
        ShowAlienID: Boolean;
        ShowKRAPin: Boolean;
        ShowDrivingLicence: Boolean;
        ShowPhoneResult: Boolean;
        ShowVehicle: Boolean;
        ShowBusinessUBO: Boolean;
        ShowBankAccount: Boolean;
        ShowCreditReport: Boolean;
}

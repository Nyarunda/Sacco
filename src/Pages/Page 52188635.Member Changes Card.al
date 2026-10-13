
Page 50298 "Member Changes Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Changes";
    PromotedActionCategories = 'New,Process,Report,Post Changes,Show Details, Approval Requests,Nominee & NOK';

    layout
    {
        area(content)
        {
            group("Member Change")
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        /*
                        IF "Account Type" = "Account Type"::Savings THEN BEGIN
                          SingleMemberVisibl:=FALSE;
                          GroupMemberVisibl:=FALSE;
                          IsFixedDepositVisibl:=FALSE;
                          IsJuniorVisibl:=FALSE;
                          EmployerVisibl:=FALSE;
                          BankDetailVisibl:=FALSE;
                        END ELSE BEGIN
                          SingleMemberVisibl:=FALSE;
                          GroupMemberVisibl:=FALSE;
                          IsFixedDepositVisibl:=FALSE;
                          IsJuniorVisibl:=FALSE;
                          EmployerVisibl:=FALSE;
                          BankDetailVisibl:=FALSE;
                          END;
                        */
                        StatusControl;

                    end;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageID = "Member Listing";
                }
                field("Full Name"; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ChangeType; Rec."Change Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateActions;
                    end;
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ReasonForChange; Rec."Reason For Change")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }

                field("Created Date Time"; Rec."Created Date Time")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
            }
            group(General)
            {
                Visible = secGeneral;
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditabl;
                }
                field(NewFirstName; Rec."New First Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditabl;
                }
                field(NewSurname; Rec."New Surname")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(OtherNames; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Other Names';
                    Editable = SecondNameEditabl;
                }
                field(NewMiddleName; Rec."New Middle Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Other Names';
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(NewName; Rec."New Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic;

                }
                field("New Member Category"; Rec."New Member Category")
                {
                    ApplicationArea = Basic;

                }



                field(KRAPIN; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                }
                field(NewKRAPIN; Rec."New KRA PIN")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec."New KRA PIN IDM Verified" := false;
                        IDMAutoVerify("IDM Verification Type"::"KRA PIN");
                    end;
                }
                field(NewKRAPINVerified; Rec."New KRA PIN IDM Verified")
                {
                    ApplicationArea = Basic;
                    Caption = 'New KRA PIN Verified';
                    Editable = false;
                }
                field(Status; Rec."Status")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(NewStatus; Rec."New Status")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = true;
                }
                field(RegistrationDate; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = Rec."Change Type" = Rec."Change Type"::Rejoining;
                }
                field(NewRegistrationDate; Rec."New Registration Date")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = Rec."Change Type" = Rec."Change Type"::Rejoining;
                }
                field(OldMemberNo; Rec."Old Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewOldMemberNo; Rec."New Old Member No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", Rec."New ID No.");
                            Cust.SetRange(Cust."Account Category", Cust."account category"::Individual);
                            if Cust.FindFirst then begin
                                if Cust."No." <> Rec."Member No." then
                                    Error(MemberExistError, Cust."No.", Cust.Name);
                            end;
                        end else
                            if Rec."Account Category" = Rec."account category"::Joint then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", Rec."New ID No.");
                                Cust.SetRange(Cust."Account Category", Cust."account category"::Joint);
                                if Cust.FindFirst then begin
                                    if Cust."No." <> Rec."Member No." then
                                        Error(MemberExistError, Cust."No.", Cust.Name);
                                end;
                            end;
                    end;
                }
                field(NewIDNo; Rec."New ID No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec."New ID No. IDM Verified" := false;
                        Rec."New Phone IDM Verified" := false;

                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", Rec."New ID No.");
                            Cust.SetRange(Cust."Account Category", Cust."account category"::Individual);
                            if Cust.FindFirst then begin
                                if Cust."No." <> Rec."Member No." then
                                    Error(MemberExistError, Cust."No.", Cust.Name);
                            end;
                        end else
                            if Rec."Account Category" = Rec."account category"::Joint then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", Rec."New ID No.");
                                Cust.SetRange(Cust."Account Category", Cust."account category"::Joint);
                                if Cust.FindFirst then begin
                                    if Cust."No." <> Rec."Member No." then
                                        Error(MemberExistError, Cust."No.", Cust.Name);
                                end;
                            end;

                        VerifyNewIDNumber();
                        if Rec."New Mobile Phone No." <> '' then
                            IDMAutoVerify("IDM Verification Type"::Phone);
                    end;
                }
                field(NewIDNoVerified; Rec."New ID No. IDM Verified")
                {
                    ApplicationArea = Basic;
                    Caption = 'New ID Verified';
                    Editable = false;
                }
                field(IDType; Rec."ID Type")
                {
                    ApplicationArea = Basic;
                }
                field(NewIDType; Rec."New ID Type")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec."New ID No. IDM Verified" := false;
                        VerifyNewIDNumber();
                    end;
                }
                field(IDExpiryDate; Rec."ID Expiry Date")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewIDExpiryDate; Rec."New ID Expiry Date")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Editable = true;
                }
                field(Passport; Rec.Passport)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Cust.Reset;
                            Cust.SetRange(Cust.passport, Rec."New Passport");
                            Cust.SetRange(Cust."Account Category", Cust."account category"::Individual);
                            if Cust.FindFirst then begin
                                if Cust."No." <> Rec."Member No." then
                                    Error(MemberExistPassError, Cust."No.", Cust.Name);
                            end;
                        end else
                            if Rec."Account Category" = Rec."account category"::Joint then begin
                                Cust.Reset;
                                Cust.SetRange(Cust.Passport, Rec."New Passport");
                                Cust.SetRange(Cust."Account Category", Cust."account category"::Joint);
                                if Cust.FindFirst then begin
                                    if Cust."No." <> Rec."Member No." then
                                        Error(MemberExistPassError, Cust."No.", Cust.Name);
                                end;
                            end;
                    end;
                }
                field("New Passport"; Rec."New Passport")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Cust.Reset;
                            Cust.SetRange(Cust.Passport, Rec."New Passport");
                            Cust.SetRange(Cust."Account Category", Cust."account category"::Individual);
                            if Cust.FindFirst then begin
                                if Cust."No." <> Rec."Member No." then
                                    Error(MemberExistPassError, Cust."No.", Cust.Name);
                            end;
                        end else
                            if Rec."Account Category" = Rec."account category"::Joint then begin
                                Cust.Reset;
                                Cust.SetRange(Cust.Passport, Rec."New Passport");
                                Cust.SetRange(Cust."Account Category", Cust."account category"::Joint);
                                if Cust.FindFirst then begin
                                    if Cust."No." <> Rec."Member No." then
                                        Error(MemberExistPassError, Cust."No.", Cust.Name);
                                end;
                            end;
                    end;
                }
                field("Passport Expiry Date"; Rec."Passport Expiry Date")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("New Passport Expiry Date"; Rec."New Passport Expiry Date")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditabl;
                }
                field(NewDateofBirth; Rec."New Date of Birth")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalStatusEditabl;
                }
                field(NewMaritalStatus; Rec."New Marital Status")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditabl;
                }
                field(NewGender; Rec."New Gender")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Reference Code"; Rec."Reference Code")
                {
                    Caption = 'Payment Reference Code';
                    ApplicationArea = Basic;
                    Editable = false;
                    //ShowMandatory = true;
                }
                field("New Reference Code"; Rec."New Reference Code")
                {
                    Caption = 'New Payment Reference Code';
                    ApplicationArea = Basic;
                    Style = Favorable;
                    ShowMandatory = Rec."Change Type" = Rec."Change Type"::Rejoining;
                    StyleExpr = true;
                }
                group("Date Rejoining")
                {
                    Visible = Rec."Change Type" = Rec."Change Type"::Rejoining;
                    field("New Registration Date"; Rec."New Registration Date")
                    {
                        ApplicationArea = Basic;
                    }
                }

            }
            group("Employment Details")
            {
                Visible = secGeneral or secemployment;
                field("Employment Info"; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                }
                field("New Employment Info"; Rec."New Employment Info")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        UpdateEmploymentFields();
                        CurrPage.Update(false);
                    end;
                }
                field(EmployerCode; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewEmployerCode; Rec."New Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmpBool;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewEmployerName; Rec."New Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }

                field(TermsofEmployment; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(NewTermsofEmployment; Rec."New Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = EmpBool;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(PayrollStaffNo; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Employer Code");
                    end;
                }
                field(NewPayrollStaffNo; Rec."New Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                    Editable = EmpBool;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Employer Code");
                    end;
                }
                field("Employement Sector"; Rec."Employement Sector")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Business Type';
                }
                field(NewEmployementSector; Rec."New Employement Sector")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Business Type';
                    Editable = EmpSectorBool;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("New Business Name"; Rec."New Business Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Business Name';
                    Editable = EmpSectorBool;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Position Held"; Rec."Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Position Held"; Rec."New Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = EmpBool;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Business Location"; Rec."Business/Group Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Business/Group Location"; Rec."New Business/Group Location")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Business Location';
                    Editable = EmpSectorBool;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            group(Communication)
            {
                Visible = secGeneral or secCommunication;
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(NewAddress; Rec."New Address")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Address2; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(NewAddress2; Rec."New Address 2")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(PostCode; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewPostCode; Rec."New Post Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic;
                }
                field(NewNationality; Rec."New Nationality")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field(NewCity; Rec."New City")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(CountryRegionCode; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewCountryRegionCode; Rec."New Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(OfficeTelephoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Office Telephone No:';
                }
                field(NewPhoneNo; Rec."New Phone No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewMobilePhoneNo; Rec."New Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec."New Phone IDM Verified" := false;
                        IDMAutoVerify("IDM Verification Type"::Phone);
                    end;
                }
                field(NewMobilePhoneNoVerified; Rec."New Phone IDM Verified")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Mobile Verified';
                    Editable = false;
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(NewEMail; Rec."New E-Mail")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Work E-Mail"; Rec."Work E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("New Work E-Mail"; Rec."New Work E-Mail")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Exempt Send SMS"; Rec."Exempt Send SMS")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;

                }
                field("New Exempt Send SMS"; Rec."New Exempt Send SMS")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Exempt Send Email"; Rec."Exempt Send Email")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("New Exempt Send Email"; Rec."New Exempt Send Email")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            group("Other Information")
            {
                Visible = secOther;
                field(AccountCategory; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(NewAccountCategory; Rec."New Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewGlobalDimension2Code; Rec."New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(RecruitedbyType; Rec."Recruited by Type")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recruited By';
                }
                field(RecruitedByName; Rec."Recruited By Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewRecruitedbyType; Rec."New Recruited by Type")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewRecruitedBy; Rec."New Recruited By")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(NewRecruitedByName; Rec."New Recruited By Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(SpecialAccount; Rec."Special Account")
                {
                    ApplicationArea = Basic;
                }
                field(NewSpecialAccount; Rec."New Special Account")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(CannotGuarantee; Rec."Cannot Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field(NewCannotGuarantee; Rec."New Cannot Guarantee")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(RelationshipManager; Rec."Relationship Manager")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NewRelationshipManager; Rec."New Relationship Manager")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
            }
            group("Junior Account")
            {
                visible = ChildDetVisibl;
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                    LookupPageId = "Member Accounts List";
                    DrillDownPageId = "Member Accounts List";
                }
                field("Child Name"; Rec."Child Name")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("New Child Name"; Rec."New Child Name")
                {
                    ApplicationArea = basic;
                }
                field("Child Date of Birth"; Rec."Child Date of Birth")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("New Child Date of Birth"; Rec."New Child Date of Birth")
                {
                    ApplicationArea = basic;
                }
                field("Child Birth Cert No."; Rec."Child Birth Cert No.")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("New Child Birth Cert No."; Rec."New Child Birth Cert No.")
                {
                    ApplicationArea = basic;
                }
                field("Piggy Bank Issued"; Rec."Piggy Bank Issued")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("New Piggy Bank Issued"; Rec."New Piggy Bank Issued")
                {
                    ApplicationArea = basic;
                }

            }
            group("Account Closure")
            {
                visible = sec_Closure;
                field(Member_Account_No; Rec."Account No.")
                {
                    ApplicationArea = basic;
                    DrillDownPageId = "Member Accounts List";
                    LookupPageId = "Member Accounts List";

                }
                field(Account_Status_; Rec."Account Status")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field(New_Account_Status_; Rec."New Account Status")
                {
                    ApplicationArea = basic;
                }
            }
            group("Account Details")
            {
                visible = AccDetVisibl;

                field("Member Account No."; Rec."Account No.")
                {
                    ApplicationArea = basic;
                    DrillDownPageId = "Member Accounts List";
                    LookupPageId = "Member Accounts List";

                }

                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("Deposit Changed By"; Rec."Deposit Changed By")
                {
                    ApplicationArea = basic;
                }
                field("New Monthly Contribution"; Rec."New Monthly Contribution")
                {
                    ApplicationArea = basic;
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ApplicationArea = basic;
                }
                field("New Repay Mode"; Rec."New Repay Mode")
                {
                    ApplicationArea = basic;
                }
                field("Salary Processing"; Rec."Salary Processing")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("New Salary Processing"; Rec."New Salary Processing")
                {
                    ApplicationArea = basic;
                    Enabled = Rec."Salary Processing" = true;
                }
                field("Transactional Mobile No"; Rec."Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Transactional Mobile No"; Rec."New Transactional Mobile No")
                {
                    ApplicationArea = Basic;
                }


            }

            group("Account Activation")
            {
                visible = AccActVisibl;
                field("Member Account"; Rec."Account No.")
                {
                    ApplicationArea = basic;
                    DrillDownPageId = "Member Accounts List";
                    LookupPageId = "Member Accounts List";
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = basic;
                    Editable = false;
                }
                field("New Account Status"; Rec."New Account Status")
                {
                    ApplicationArea = basic;
                }

            }
            group("Unblock Account")
            {
                visible = AccUnblockVisibl;
                field("Member Account_"; Rec."Account No.")
                {
                    ApplicationArea = basic;
                    DrillDownPageId = "Member Accounts List";
                    LookupPageId = "Member Accounts List";
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("New Blocked"; Rec."New Blocked")
                {
                    ApplicationArea = Basic;
                }

            }

            group("Group Details")
            {
                Visible = false;
                field(GroupCategory; Rec."Group Category")
                {
                    ApplicationArea = Basic;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = Basic;
                }
                field("New Group No."; Rec."New Group No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                group("Non-Incorporated")
                {
                    Visible = false;
                    field(GroupType; Rec."Group Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewGroupType; Rec."New Group Type")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Other Type Of Group"; Rec."Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Other Type Of Group"; Rec."New Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Date of Group Reg."; Rec."Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Date of Group Reg."; Rec."New Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Group Physical Location"; Rec."Business/Group Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Group Physical Location"; Rec."New Business/Group Location")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Group Plot/Bldg/Street/Road"; Rec."Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Group Plot/Bldg/Street/Road"; Rec."New Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }

                }
                group(Incorporated)
                {
                    Visible = false;
                    field(TypeofBusiness; Rec."Type of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewTypeofBusiness; Rec."New Type of Business")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(OtherTypeOfBusiness; Rec."Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewOtherTypeOfBusiness; Rec."New Other Type Of Business")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(BusinessRegNo; Rec."Business Reg. No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewBusinessRegNo; Rec."New Business Reg. No.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(IncorporationNo; Rec."Incorporation No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewIncorporationNo; Rec."New Incorporation No.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field(DateofBusReg; Rec."Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                    }
                    field(NewDateofBusReg; Rec."New Date of Bus. Reg.")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Business Physical Location"; Rec."Business/Group Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Business Physical Location"; Rec."New Business/Group Location")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Business Plot/Bldg/Street/Road"; Rec."Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                    }
                    field("New Bus. Plot/Bldg/Street/Road"; Rec."New Plot/Bldg/Street/Road")
                    {
                        ApplicationArea = Basic;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                }
            }
            group("Signing")
            {
                Visible = false;
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Signing Instructions"; Rec."New Signing Instructions")
                {
                    ApplicationArea = Basic;
                }

                field("Signing Instructions Narration"; Rec."Signing Instructions Narration")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("New Signing Instr. Narration"; Rec."New Signing Instr. Narration")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Bank Details")
            {
                Visible = secBank or secGeneral;
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewBankCode; Rec."New Bank Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field(NewBankName; Rec."New Bank Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewBranchCode; Rec."New Branch Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewBranchName; Rec."New Branch Name")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(BankAccountNo; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(NewBankAccountNo; Rec."New Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }



                field("Swift Code"; Rec."Swift Code")
                {
                    ApplicationArea = Basic;
                }
                field("New Swift Code"; Rec."New Swift Code")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }

            group("Picture & Signature")
            {
                Visible = secPic_Sig;
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
            }

            group("Cancelled")
            {
                Visible = Rec."Approval Status" = Rec."Approval Status"::Cancelled;
                field("Cancelled By"; Rec."Cancelled By") { }
                field("Cancellation Reason"; Rec."Cancellation Reason") { }
                field("Cancelled Date"; Rec."Cancelled Date") { }
                field("Cancelled Time"; Rec."Cancelled Time") { }
            }

        }
        area(factboxes)
        {
            part(IDMVerificationLogPart; "IDM Verification Log Part")
            {
                ApplicationArea = All;
                Caption = 'IDM Verification History';
                SubPageLink = "API Request ID" = field(Code);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Post Changes")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()

                begin
                    Rec.TestField("Approval Status", Rec."approval status"::Approved);
                    Rec.TestField(Posted, false);
                    Rec.UpdateMember(Rec."Member No.");
                    Rec.Posted := true;
                    Message('Updated');
                    CurrPage.Close();
                end;
            }
            action("Show Details")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    UpdateActions;
                end;
            }
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        NextofKinError: label 'You must specify next of Kin for this application.';
                        NextofKIN: Record "Service Item";
                        ProductFactory: Record "Service Item";
                        SavingsAccountRegistration: Record "Service Item";
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        Confirm: Dialog;
                        TextConfirm: Label 'Are you sure you want to send for approval;';
                    begin

                        UserSetup.Get(UserId);
                        Rec.TestField(Posted, false);
                        Rec.TestField("Reason For Change");
                        CheckControls();

                        VarVariant := Rec;

                        CalwideApprovals.CreateCustomTracker(VarVariant, Rec.Code, 0, Documenttype::"Member Changes", UserSetup."Global Dimension 1 Code", UserSetup."Global Dimension 2 Code", 0);

                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category6;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin
                        Rec.TestField("Approval Status", Rec."approval status"::Pending);

                        VarVariant := Rec;
                        CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = category6;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        RecRef: RecordRef;
                        DocumentType: Enum "Custom Document Type";
                        VarVariant: Variant;
                        ApprovalTracker: Record "Approval Tracker";
                    begin
                        VarVariant := Rec;
                        RecRef.GetTable(VarVariant);
                        DocumentType := Documenttype::"Member Changes";


                        ApprovalTracker.Reset;
                        ApprovalTracker.SetRange("Table ID", RecRef.Number);
                        ApprovalTracker.SetRange("Document No.", Rec.Code);
                        ApprovalTracker.SetRange("Document Type", DocumentType);
                        if ApprovalTracker.FindFirst then
                            approvalsMgmt.OpenApprovalEntriesPage(RecRef.RecordId);
                    end;
                }
                action("Reopen Document")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
                        CalwideApprovals: Codeunit "Calwide Approvals";
                        VarVariant: Variant;
                    begin

                        if Rec."Approval Status" = Rec."approval status"::Pending then begin
                            VarVariant := Rec;
                            CalwideApprovals.CancelTracker(VarVariant, Rec.Code);
                        end
                        else begin

                            if not Confirm('Are you sure you want to re-open this document?') then
                                exit;

                            Rec."Approval Status" := Rec."approval status"::Open;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    Caption = 'Can Transact';
                    PromotedIsBig = true;
                    Visible = secGeneral or secSignatories;
                    PromotedCategory = category7;
                    RunObject = Page "Account Signatories App.";
                    RunPageLink = Code = field("No. Series");
                }
                action("NOK Changes")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = secGeneral or secNOK;
                    PromotedCategory = category7;
                    RunObject = Page "Next of Kin Changes";
                    RunPageLink = "No." = field(Code);
                }
                action("Nominee Changes")
                {
                    ApplicationArea = Basic;
                    Image = NewSparkle;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = secGeneral or secNOM;
                    PromotedCategory = category7;
                    RunObject = Page "Nominee Changes";
                    RunPageLink = "No." = field(Code);
                }

            }
        }
    }

    trigger OnOpenPage()
    begin

        //UpdateActions;
        UpdateEmploymentFields();

        if Rec.Posted then
            CurrPage.Editable := false;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateActions();
        UpdateEmploymentFields();
    end;

    local procedure VerifyNewIDNumber()
    begin
        if Rec."New ID No." = '' then
            exit;

        case Rec."New ID Type" of
            Rec."New ID Type"::"National ID":
                IDMAutoVerify("IDM Verification Type"::"National ID");
            Rec."New ID Type"::"Alien ID":
                IDMAutoVerify("IDM Verification Type"::"Alien ID");
        end;
    end;

    local procedure IDMAutoVerify(VerificationType: Enum "IDM Verification Type")
    var
        IDMSetup: Record "IDM Setup";
        Identifier: Text;
        SecondaryIdentifier: Text;
    begin
        if not IDMSetup.Get('') then
            exit;
        if not IDMSetup.Enabled then
            exit;

        case VerificationType of
            VerificationType::"National ID",
            VerificationType::"Alien ID":
                if not IDMSetup."Auto Verify ID No." then
                    exit;
            VerificationType::"KRA PIN":
                if not IDMSetup."Auto Verify KRA PIN" then
                    exit;
            VerificationType::Phone:
                if not IDMSetup."Auto Verify Phone" then
                    exit;
        end;

        case VerificationType of
            VerificationType::"National ID",
            VerificationType::"Alien ID":
                Identifier := Rec."New ID No.";
            VerificationType::"KRA PIN":
                Identifier := Rec."New KRA PIN";
            VerificationType::Phone:
                begin
                    Identifier := Rec."New ID No.";
                    if Identifier = '' then
                        Identifier := Rec."ID No.";
                    SecondaryIdentifier := Rec."New Mobile Phone No.";
                end;
        end;

        if Identifier = '' then
            exit;
        if (VerificationType = VerificationType::Phone) and (SecondaryIdentifier = '') then
            exit;

        RunIDMVerify(VerificationType, Identifier, SecondaryIdentifier);
    end;

    local procedure RunIDMVerify(VerificationType: Enum "IDM Verification Type"; Identifier: Text; SecondaryIdentifier: Text)
    var
        IDMApi: Codeunit "IDM API Integration";
        IDMLog: Record "IDM Verification Log";
        EntryNo: Integer;
    begin
        case VerificationType of
            VerificationType::"National ID":
                EntryNo := IDMApi.VerifyNationalID(Identifier, Rec."Member No.", Rec.Code);
            VerificationType::"Alien ID":
                EntryNo := IDMApi.VerifyAlienID(Identifier, Rec."Member No.", Rec.Code);
            VerificationType::"KRA PIN":
                EntryNo := IDMApi.VerifyKRAPin(Identifier, Rec."Member No.", Rec.Code);
            VerificationType::Phone:
                EntryNo := IDMApi.VerifyPhone(Identifier, SecondaryIdentifier, Rec."Member No.", Rec.Code);
        end;

        if not IDMLog.Get(EntryNo) then
            exit;

        case VerificationType of
            VerificationType::"National ID",
            VerificationType::"Alien ID":
                Rec."New ID No. IDM Verified" := IDMLog.Status = IDMLog.Status::Success;
            VerificationType::"KRA PIN":
                Rec."New KRA PIN IDM Verified" := IDMLog.Status = IDMLog.Status::Success;
            VerificationType::Phone:
                Rec."New Phone IDM Verified" := IDMLog."Phone Matched";
        end;
    end;

    var
        IncorporatedEdit: Boolean;
        NonIncorporatedEdit: Boolean;
        Customer: Record Customer;
        SingleMemberVisibl: Boolean;
        FirstNameEditabl: Boolean;
        SecondNameEditabl: Boolean;
        LastNameEditabl: Boolean;
        NameEditabl: Boolean;
        IDNoEditabl: Boolean;
        PassportNoEditabl: Boolean;
        StaffNoEditabl: Boolean;
        DOBEditabl: Boolean;
        MaritalStatusEditabl: Boolean;
        GenderEditabl: Boolean;
        GroupAccountNoEditabl: Boolean;
        GroupMemberVisibl: Boolean;
        BusinessMemberVisibl: Boolean;
        IsFixedDepositVisibl: Boolean;
        IsJuniorVisibl: Boolean;
        CommVisbl: Boolean;
        OtherVisibl: Boolean;
        EmployerVisibl: Boolean;
        BankDetailVisibl: Boolean;
        GroupDetailVisibl: Boolean;
        ChildDetVisibl: Boolean;
        AccDetVisibl: Boolean;
        AccActVisibl: Boolean;
        AccUnblockVisibl: Boolean;
        "-": Integer;
        VarVariant: Variant;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        GroupAcc: Boolean;
        SingleAcc: Boolean;
        CameraAvailable: Boolean;
        Cust: Record Members;
        Savings: Record "Savings Accounts";
        secGeneral: Boolean;
        secEmployment: Boolean;
        secCommunication: Boolean;
        secBank: Boolean;
        secOther: Boolean;
        secNOK: Boolean;
        secNOM: Boolean;
        secAuthorizedPersons: Boolean;
        secAuthor: Boolean;
        secPic_Sig: Boolean;
        sec_Closure: Boolean;
        Empstatus: Boolean;
        secSignatories: Boolean;
        EmpBool: Boolean;
        EmpSectorBool: Boolean;
        MemberExistError: label 'ID Already Exist. Member No. %1 - %2';
        MemberExistPassError: label 'IPassport Already Exist. Member No. %1 - %2';
        UserSetup: Record "User Setup";

    local procedure CheckControls()
    var
        NextofKin: Record "Next of Kin.";
    begin
        /* if Rec."Change Type" = Rec."Change Type"::Rejoining then begin
            Rec.TestField("New ID No.");
            Rec.TestField("New Registration Date");
            Rec.TestField("New Status");
        end; */

        if Rec."Change Type" = Rec."Change Type"::"Next of Kin" then begin

            NextofKin.Reset();
            NextofKin.SetRange("No.", Rec.Code);
            if not NextofKin.FindSet() then
                Error('You must specify next of kin for this application.');

        end;

        NextofKin.Reset();
        NextofKin.SetRange("No.", Rec.Code);
        if NextofKin.FindSet() then
            repeat
                if Rec."Change Type" = Rec."Change Type"::"Next of Kin" then begin
                    NextofKin.TestField(Relationship);
                end;
                NextofKin.TestField(Name);
            until NextofKin.Next() = 0;

    end;

    procedure StatusControl()
    begin
        /*
        IF ("Account Type" IN ["Account Type"::" ","Account Type"::Savings]) THEN BEGIN
         CASE "Product Category" OF
          "Product Category"::"Fixed Deposit" : BEGIN
           IsFixedDepositVisibl:=TRUE;
           IsJuniorVisibl:=FALSE;
           EmployerVisibl:=FALSE;
           BankDetailVisibl:=FALSE;
           SingleMemberVisibl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=FALSE;
           CommVisbl:=FALSE;
          END;
          "Product Category"::"Junior Savings" : BEGIN
           IsFixedDepositVisibl:=FALSE;
           IsJuniorVisibl:=TRUE;
           EmployerVisibl:=FALSE;
           BankDetailVisibl:=FALSE;
           SingleMemberVisibl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=FALSE;
           CommVisbl:=FALSE;
          END;
          "Product Category"::" ", "Product Category" ::"Share Capital", "Product Category" ::"Deposit Contribution",
          "Product Category" ::"Registration Fee" : BEGIN
           IsFixedDepositVisibl:=FALSE;
           IsJuniorVisibl:=FALSE;
           EmployerVisibl:=FALSE;
           BankDetailVisibl:=FALSE;
           SingleMemberVisibl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=FALSE;
           CommVisbl:=FALSE;
          END;
        END;
        
          END ELSE BEGIN
          CASE "Single Party/Multiple/Business" OF
           "Single Party/Multiple/Business"::Single: BEGIN
            SingleMemberVisibl:=TRUE;
            NameEditabl:=FALSE;Rec.FirstNameEditabl:=TRUE;Rec.SecondNameEditabl:=TRUE;Rec.LastNameEditabl:=TRUE;Rec.StaffNoEditabl:=TRUE;
            IDNoEditabl:=TRUE;Rec.PassportNoEditabl:=TRUE;Rec.DOBEditabl:=TRUE;Rec.MaritalStatusEditabl:=TRUE;Rec.GenderEditabl:=TRUE;
            GroupAccountNoEditabl:=TRUE;
            GroupMemberVisibl:=FALSE;
            BusinessMemberVisibl:=FALSE;
            CommVisbl:=TRUE;
            EmployerVisibl:=TRUE;
            BankDetailVisibl:=TRUE;
          END;
           "Single Party/Multiple/Business"::Multiple: BEGIN
            SingleMemberVisibl:=FALSE;
            NameEditabl:=TRUE;Rec.FirstNameEditabl:=FALSE;Rec.SecondNameEditabl:=FALSE;Rec.LastNameEditabl:=FALSE;Rec.StaffNoEditabl:=FALSE;
            IDNoEditabl:=FALSE;Rec.PassportNoEditabl:=FALSE;Rec.DOBEditabl:=FALSE;Rec.MaritalStatusEditabl:=FALSE;Rec.GenderEditabl:=FALSE;
            GroupAccountNoEditabl:=FALSE;
            GroupMemberVisibl:=TRUE;
            BusinessMemberVisibl:=FALSE;
            CommVisbl:=TRUE;
            EmployerVisibl:=TRUE;
            BankDetailVisibl:=TRUE;
          END;
          "Single Party/Multiple/Business"::Business: BEGIN
           SingleMemberVisibl:=FALSE;
           NameEditabl:=TRUE;Rec.FirstNameEditabl:=FALSE;Rec.SecondNameEditabl:=FALSE;Rec.LastNameEditabl:=FALSE;Rec.StaffNoEditabl:=FALSE;
           IDNoEditabl:=FALSE;Rec.PassportNoEditabl:=FALSE;Rec.DOBEditabl:=FALSE;Rec.MaritalStatusEditabl:=FALSE;Rec.GenderEditabl:=FALSE;
           GroupAccountNoEditabl:=FALSE;
           GroupMemberVisibl:=FALSE;
           BusinessMemberVisibl:=TRUE;
           CommVisbl:=TRUE;
           EmployerVisibl:=TRUE;
           BankDetailVisibl:=TRUE;
          END;
        END;
            END;
        */

        /*
        CASE Status OF
         Status::Open :
           BEGIN
             CurrPage.EDITABLE:=TRUE;
             END;
        
         Status::Pending, Status::Rejected, Status::Processed :
           BEGIN
             CurrPage.EDITABLE:=FALSE;
             END;
        END;
        */
        /*
        CASE "Single Party/Multiple/Business" OF
        "Single Party/Multiple/Business"::Single: BEGIN
          SingleMemberVisibl:=TRUE;
           NameEditabl:=FALSE;Rec.FirstNameEditabl:=TRUE;Rec.SecondNameEditabl:=TRUE;Rec.LastNameEditabl:=TRUE;Rec.StaffNoEditabl:=TRUE;
           IDNoEditabl:=TRUE;Rec.PassportNoEditabl:=TRUE;Rec.DOBEditabl:=TRUE;Rec.MaritalStatusEditabl:=TRUE;Rec.GenderEditabl:=TRUE;
           GroupAccountNoEditabl:=TRUE;
          GroupMemberVisibl:=FALSE;
          BusinessMemberVisibl:=FALSE;
          END;
        "Single Party/Multiple/Business"::Multiple: BEGIN
          SingleMemberVisibl:=FALSE;
           NameEditabl:=TRUE;Rec.FirstNameEditabl:=FALSE;Rec.SecondNameEditabl:=FALSE;Rec.LastNameEditabl:=FALSE;Rec.StaffNoEditabl:=FALSE;
           IDNoEditabl:=FALSE;Rec.PassportNoEditabl:=FALSE;Rec.DOBEditabl:=FALSE;Rec.MaritalStatusEditabl:=FALSE;Rec.GenderEditabl:=FALSE;
           GroupAccountNoEditabl:=FALSE;
          GroupMemberVisibl:=TRUE;
          BusinessMemberVisibl:=FALSE;
          END;
        "Single Party/Multiple/Business"::Business: BEGIN
          SingleMemberVisibl:=FALSE;
           NameEditabl:=TRUE;Rec.FirstNameEditabl:=FALSE;Rec.SecondNameEditabl:=FALSE;Rec.LastNameEditabl:=FALSE;Rec.StaffNoEditabl:=FALSE;
           IDNoEditabl:=FALSE;Rec.PassportNoEditabl:=FALSE;Rec.DOBEditabl:=FALSE;Rec.MaritalStatusEditabl:=FALSE;Rec.GenderEditabl:=FALSE;
           GroupAccountNoEditabl:=FALSE;
          GroupMemberVisibl:=FALSE;
          BusinessMemberVisibl:=TRUE;
          END;
        END;
        
        
        CASE "Product Category" OF
        "Product Category"::"Fixed Deposit" : BEGIN
          IsFixedDepositVisibl:=TRUE;
          IsJuniorVisibl:=FALSE;
          EmployerVisibl:=FALSE;
          BankDetailVisibl:=FALSE;
          END;
        "Product Category"::"Junior Savings" : BEGIN
          IsFixedDepositVisibl:=FALSE;
          IsJuniorVisibl:=TRUE;
          EmployerVisibl:=FALSE;
          BankDetailVisibl:=FALSE;
          END;
        "Product Category"::" ", "Product Category" ::"Share Capital", "Product Category" ::"Deposit Contribution",
        "Product Category" ::"Registration Fee" : BEGIN
          IsFixedDepositVisibl:=FALSE;
          IsJuniorVisibl:=FALSE;
          EmployerVisibl:=TRUE;
          BankDetailVisibl:=TRUE;
          END;
        END;
        
        
        
        //IF ("Account Type" IN ["Account Type"::" ","Account Type"::Savings]) THEN BEGIN
        
        
        
        CASE Status OF
         Status::Open :
           BEGIN
             CurrPage.EDITABLE:=TRUE;
             END;
        
         Status::Pending, Status::Rejected, Status::Processed :
           BEGIN
             CurrPage.EDITABLE:=FALSE;
             END;
        END;
        */


        NonIncorporatedEdit := false;
        IncorporatedEdit := false;

        if Rec."Group Category" = Rec."group category"::"Non-Incorporated" then begin
            NonIncorporatedEdit := true;
        end;
        if Rec."Group Category" = Rec."group category"::Incorporated then begin
            IncorporatedEdit := true;
        end;
    end;

    local procedure UpdateActions()
    begin


        secGeneral := false;
        secEmployment := false;
        secCommunication := false;
        secBank := false;
        secOther := false;
        secNOK := false;
        secAuthorizedPersons := false;
        secAuthor := false;
        secPic_Sig := false;
        secSignatories := false;
        GroupDetailVisibl := false;
        ChildDetVisibl := false;
        AccDetVisibl := false;
        AccActVisibl := false;
        sec_Closure := false;
        secAuthor := False;


        if Rec."Change Type" = Rec."change type"::"Authorized Persons" then
            secAuthorizedPersons := true;

        if Rec."Change Type" = Rec."change type"::"Bank Details" then
            secBank := true;

        if Rec."Change Type" = Rec."change type"::Communication then
            secCommunication := true;

        if Rec."Change Type" = Rec."change type"::"Employment Details" then
            secEmployment := true;

        if (Rec."Change Type" = Rec."change type"::General) or (Rec."Change Type" = Rec."Change Type"::Rejoining) then begin
            secGeneral := true;
        end;

        if Rec."Change Type" = Rec."Change Type"::"Account Details" then
            AccDetVisibl := true;

        if Rec."Change Type" = Rec."Change Type"::Activation then
            AccActVisibl := true;

        if Rec."Change Type" = Rec."Change Type"::"UnBlock Account" then
            AccUnblockVisibl := true;

        if Rec."Change Type" = Rec."Change Type"::"Account Closure" then
            sec_Closure := true;

        if Rec."Change Type" = Rec."change type"::"Next of Kin" then
            secNOK := true;

        if Rec."Change Type" = Rec."change type"::Nominee then
            secNOM := true;

        if Rec."Change Type" = Rec."change type"::"Other Information" then
            secOther := true;

        if Rec."Change Type" = Rec."change type"::"Pic & Signature" then
            secPic_Sig := true;


        if Rec."Change Type" = Rec."Change Type"::"Child Details" then
            ChildDetVisibl := true;


        NonIncorporatedEdit := false;
        IncorporatedEdit := false;

        if Rec."Group Category" = Rec."group category"::"Non-Incorporated" then begin
            NonIncorporatedEdit := true;
        end;
        if Rec."Group Category" = Rec."group category"::Incorporated then begin
            IncorporatedEdit := true;
        end;


    end;

    local procedure UpdateEmploymentFields()
    begin
        case Rec."New Employment Info" of
            Rec."New Employment Info"::"Self-Employed",
            Rec."New Employment Info"::Business,
            Rec."New Employment Info"::Contracting:
                begin
                    EmpSectorBool := true;
                    EmpBool := false;
                end;

            Rec."New Employment Info"::Employed,
            Rec."New Employment Info"::Permanent:
                begin
                    EmpSectorBool := false;
                    EmpBool := true;
                end;

            Rec."New Employment Info"::UnEmployed,
            Rec."New Employment Info"::Pensioner:
                begin
                    EmpSectorBool := false;
                    EmpBool := false;
                end;
        end;
    end;
}


Page 50214 "CRB Main Data"
{
    Editable = false;
    PageType = List;
    SourceTable = "CRB Main Data";
    SourceTableView = where("Client Type" = const(Loanee));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Name2; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Forename 1';
                }
                field(Name3; Rec."Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Forename 2';
                }
                field(Name4; Rec."Name 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Forename 3';
                }
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = Basic;
                    Caption = 'Trading As';
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(ClientCode; Rec."Client Code")
                {
                    Caption = 'Client Number';
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Number';
                }
                field("Old Account Number"; Rec."Old Account Number")
                {
                    ApplicationArea = Basic;
                    Caption = 'Old Account Number';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field(PrimaryIdentificationCode; Rec."Primary Identification Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Primary Identification Document Type';
                }
                field(PrimaryIdentification1; Rec."Primary Identification 1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Primary Identification Doc Number';
                }
                field(SecondaryIdentificationCode; Rec."Secondary Identification Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Secondary Identification Document Type';
                }
                field(SecondaryIdentification1; Rec."Secondary Identification 1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Secondary Identification Document Number';
                }
                field(OtherIdentificationCode; Rec."Other Identification Code")
                {
                    ApplicationArea = Basic;
                }
                field(OtherIdentification1; Rec."Other Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field("Passport Country Code"; Rec."Passport Country Code")
                {
                    ApplicationArea = Basic;
                }
                field(MobileNo; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field(HomeTelephone; Rec."Home Telephone")
                {
                    ApplicationArea = Basic;
                }
                field(WorkTelephone; Rec."Work Telephone")
                {
                    ApplicationArea = Basic;
                }
                field(PostalAddress1; Rec."Postal Address 1")
                {
                    ApplicationArea = Basic;
                }
                field(PostalAddress2; Rec."Postal Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(PostalLocationTown; Rec."Postal Location Town")
                {
                    ApplicationArea = Basic;
                }
                field(PostalLocationCountry; Rec."Postal Location Country")
                {
                    ApplicationArea = Basic;
                }
                field(PostCode; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field(PhysicalAddress1; Rec."Physical Address 1")
                {
                    ApplicationArea = Basic;
                }
                field(PhysicalAddress2; Rec."Physical Address 2")
                {
                    ApplicationArea = Basic;
                }
                field(PlotNo; Rec."Plot No.")
                {
                    ApplicationArea = Basic;
                }
                field(LocationTown; Rec."Location Town")
                {
                    ApplicationArea = Basic;
                }
                field(LocationCountry; Rec."Location Country")
                {
                    ApplicationArea = Basic;
                }
                field(DateofPhysicalAddress; Rec."Date of Physical Address")
                {
                    ApplicationArea = Basic;
                }
                field(PINNo; Rec."PIN No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Number ';
                }
                field(CustomerWorkEmail; Rec."Customer Work Email")
                {
                    Caption = 'Consumer work E-Mail';
                    ApplicationArea = Basic;
                }
                field(EmployerName; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerIndustryType; Rec."Employer Industry Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupational Industry Type';
                }
                field(EmploymentDate; Rec."Employment Date")
                {
                    ApplicationArea = Basic;
                }
                field(EmploymentType; Rec."Employment Type")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryBand; Rec."Salary Band")
                {
                    ApplicationArea = Basic;
                }
                field(LendersRegisteredName; Rec."Lenders Registered Name")
                {
                    ApplicationArea = Basic;
                }
                field(LendersTradingName; Rec."Lenders Trading Name")
                {
                    ApplicationArea = Basic;
                }
                field(LendersBranchName; Rec."Lenders Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(LendersBranchCode; Rec."Lenders Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountProductType; Rec."Account Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(DateAccountOpened; Rec."Date Account Opened")
                {
                    ApplicationArea = Basic;
                }
                field(InstallmentDueDate; Rec."Installment Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(OriginalAmount; Rec."Original Amount")
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyofFacilty; Rec."Currency of Facilty")
                {
                    ApplicationArea = Basic;
                }
                field(AmountinKSHs; Rec."Amount in KSHs")
                {
                    ApplicationArea = Basic;
                }
                field(CurrentBalance; Rec."Current Balance")
                {
                    ApplicationArea = Basic;
                }
                field(OverdueBalance; Rec."Overdue Balance")
                {
                    ApplicationArea = Basic;
                }
                field(OverdueDate; Rec."Overdue Date")
                {
                    ApplicationArea = Basic;
                }
                field(NoofDaysinArrears; Rec."No. of Days in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(NoofInstallmentsinArrears; Rec."No. of Installments in Arrears")
                {
                    ApplicationArea = Basic;
                }
                field(PerformingNPLIndicator; Rec."Performing/NPL Indicator")
                {
                    ApplicationArea = Basic;
                }
                field(AccountStatus; Rec."Account Status")
                {
                    ApplicationArea = Basic;
                }
                field(AccountStatusDate; Rec."Account Status Date")
                {
                    ApplicationArea = Basic;
                }
                field(AccountClosureReason; Rec."Account Closure Reason")
                {
                    ApplicationArea = Basic;
                }
                field(RepaymentPeriod; Rec."Repayment Period")
                {
                    ApplicationArea = Basic;
                }
                field(DeferredPaymentDate; Rec."Deferred Payment Date")
                {
                    ApplicationArea = Basic;
                }
                field(DeferredPayment; Rec."Deferred Payment")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentFrequency; Rec."Payment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field(DisbursementDate; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(InstallmentAmount; Rec."Installment Amount")
                {
                    ApplicationArea = Basic;
                }
                field(DateofLatestPayment; Rec."Date of Latest Payment")
                {
                    ApplicationArea = Basic;
                }
                field(LastPaymentAmount; Rec."Last Payment Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofSecurity; Rec."Type of Security")
                {
                    ApplicationArea = Basic;
                }
                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate CRB")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Generate CRB Main";
            }
            action("View Guarantor File")
            {
                ApplicationArea = Basic;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = Page "CRB Guarantor File";
            }
            action("View Loanee Update File")
            {
                ApplicationArea = Basic;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = Page "CRB Update";
            }
        }
    }
}


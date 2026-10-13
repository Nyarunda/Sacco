
Table 50067 Loans
{
    DrillDownPageID = "Loans List";
    LookupPageID = "Loans List";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                if "Loan No." <> xRec."Loan No." then begin
                    NSetup.Get;
                    NoSeries.TestManual(NSetup."Loan Nos.");

                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin

                if "Application Date" > Today then
                    Error('Application date can not be in the future.');
            end;
        }
        field(3; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup"."Product ID" where("Product Class" = const(Credit), Status = const(Active));

            trigger OnValidate()
            begin
                ValidateLoanProductType();
            end;
        }
        field(4; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            var
                Groups: Record Members;
                CheckControl: Boolean;
                Emp: Record Members;
            begin

                "SMS Sent" := false;

                if "Loan No." <> '' then
                    ClearLoanDetails;

                if "Portal Loan Code" <> '' then
                    error('You cannot edit the member no of a portal loan');

                if LoanType.Get("Loan Product Type") then
                    "Disbursement Account No" := '';

                GenSetup.Get;

                Unpaid := '';
                LArrears := '';
                //Check if there is a loan never paid or is in arrears
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Member No.", "Member No.");
                LoanApp.SetRange(LoanApp.Posted, true);
                LoanApp.SetFilter(LoanApp."Outstanding Principal", '>0');
                LoanApp.SetFilter("Disbursement Date", '<%1', CalcDate('-31D', Today));
                if LoanApp.Find('-') then begin
                    repeat
                        LoanApp.CalcFields("Outstanding Principal");
                        if LoanApp."Approved Amount" = LoanApp."Outstanding Principal" then
                            Unpaid += '\ - ' + LoanApp."Loan Product Type" + ' - ' + LoanApp."Loan Product Type Name";


                    /*
                    CreditLedger.RESET;
                    CreditLedger.SETRANGE(CreditLedger."Member No.","Member No.");
                    CreditLedger.SETRANGE(CreditLedger."Transaction Type",CreditLedger."Transaction Type"::Repayment);
                    CreditLedger.SETRANGE(CreditLedger."Loan No",LoanApp."Loan No.");
                    IF NOT CreditLedger.FIND('-') THEN
                        MESSAGE(Text003,LoanApp."Loan No.");

                    IF LoanApp."Outstanding Bills">0 THEN
                    MESSAGE(Text004,LoanApp."Loan No.");

                    */


                    until LoanApp.Next = 0;

                    /*if (Unpaid <> '') and ("Loan Product Type" <> 'L43') then
                        Message(Text003 + Unpaid);

                    if (LArrears <> '') and ("Loan Product Type" <> 'L43') then
                        // Message(Text004 + LArrears);?
                        */

                end;

                if Cust.Get("Member No.") then begin

                    if Cust."Member Status" <> Cust."Member Status"::Active then
                        //if Confirm('This member is not active. Do you wish to continue with application ?', true) = false then
                        if "Loan Product Type" <> 'L43' then
                            Error("InactiveErr:");

                    "Staff No" := Cust."Payroll/Staff No.";
                    "Member Name" := Cust.Name;
                    //"Application Date" := Today;
                    "ID No." := Cust."ID No.";
                    /*
                    IF NOT Groups.GET(Cust."Group Code") THEN BEGIN
                        IF Groups.GET('0'+Cust."Group Code") THEN BEGIN
                            Cust."Group Code" := '0'+Cust."Group Code";
                            Cust
                        END;
                    END;
                    */
                    "Group Code" := Cust."Group No.";

                    "Old Member No." := Cust."Old Member No.";

                    "Employer Code" := Cust."Employer Code";
                    "Employer Name" := cust."Employer Name";
                    // "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    if Cust."Global Dimension 2 Code" <> '' then
                        "Booking Branch" := Cust."Global Dimension 2 Code";

                    if (Cust."ID No." = '') and (Cust.Passport = '') then
                        Error('Kindly update the ID No for this member before proceeding');

                end
                else
                    Error('Member does not exist');

                if ("Member No." <> '') and ("Member No." <> xRec."Member No.") then begin
                    "Disbursement Account No" := '';
                end;



                CheckControl := false;
                if cust."Employer Code" = '' then begin
                    CheckControl := true;
                end
                else begin
                    if Emp.get(cust."Employer Code") then begin
                        /*if not Emp."Remove Loan Restriction" then begin

                            CheckControl := true;
                        end;*/
                    end
                    else begin


                        CheckControl := true;
                    end;
                end;

                if (CheckControl) and ("Loan Product Type" <> 'L43') then begin

                    //Check share capital requirement
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."product category"::"Share Capital");
                    if SavAcc.Find('-') then begin

                        SavAcc.CalcFields(SavAcc."Balance (LCY)");
                        SavingsProduct.Reset;
                        SavingsProduct.SetRange("Product Category", SavingsProduct."product category"::"Share Capital");
                        if SavingsProduct.FindFirst then begin
                            //Check Minimum savings per product
                            if SavAcc."Balance (LCY)" < SavingsProduct."Minimum Contribution" then
                                Error(Text019, SavAcc."Balance (LCY)", SavingsProduct."Minimum Contribution");
                        end;

                    end;

                end;



                //Check minimum deposits
                SavAcc.Reset;
                SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                SavAcc.SetRange(SavAcc."Product Category", SavAcc."product category"::"Deposit Contribution");
                if SavAcc.Find('-') then begin
                    SavAcc.CalcFields(SavAcc."Balance (LCY)");
                    //Check Minimum savings per product

                    SavingsProduct.Reset;
                    SavingsProduct.SetRange("Product Category", SavingsProduct."product category"::"Deposit Contribution");
                    if SavingsProduct.FindFirst then begin
                        //Check Minimum savings per product
                        if SavAcc."Balance (LCY)" < SavingsProduct."Minimum Contribution" then
                            Message(Text011, SavAcc."Balance (LCY)", SavingsProduct."Minimum Contribution");
                    end;

                end;

                PopulateBankDetailsFromMember("Member No.");
            end;
        }
        field(5; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "SMS Sent" := false;
                GetFreeShares;

                if LoanType.Get("Loan Product Type") then begin

                    "Approved Amount" := "Requested Amount";
                    "Amount To Disburse" := "Requested Amount";
                    Validate("Approved Amount");
                    //"Application Date" := Today;

                    //Check maximum and minimum loan amounts

                    if LoanType.Get("Loan Product Type") then begin

                        if (LoanType."Nature of Loan Type" = LoanType."nature of loan type"::Normal) then begin
                            if "Requested Amount" > 0 then
                                if ("Requested Amount" > LoanType."Maximum Loan Amount") or ("Requested Amount" < LoanType."Minimum Loan Amount") then
                                    Error(LoanAmountErr, LoanType."Minimum Loan Amount", LoanType."Maximum Loan Amount", "Loan Product Type", "Requested Amount");
                        end;

                        if LoanType.Get("Loan Product Type") then begin
                            if LoanType."Use Tiered Debt Threshold" then begin
                                Installments := GetTieredInstallments(LoanType."Product ID", "Amount To Disburse");
                                Validate(Installments);
                            end;
                        end;
                    end;
                end;

                SaccoActivities.CreateCreditAccount(Rec);
            end;
        }
        field(6; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                GenSetup.Get();
                if LoanType.Get("Loan Product Type") then begin
                    if "Approved Amount" > 0 then
                        if ("Approved Amount" > LoanType."Maximum Loan Amount") or ("Approved Amount" < LoanType."Minimum Loan Amount") then
                            Error(LoanAmountErr, LoanType."Minimum Loan Amount", LoanType."Maximum Loan Amount", "Loan Product Type", "Approved Amount");


                    "Annual Interest %" := LoanType."Interest Rate (Max.)";
                    //Installments := LoanType."Default Installments";
                end;


                if Installments <= 0 then
                    Error(InstallmentsErr);

                if "Approved Amount" > "Requested Amount" then
                    Error(ApprovedAmtErr);

                //"Amount To Disburse" := "Approved Amount";

                CalculateLoanRepayments("Amount To Disburse");


                if Installments = 1 then begin
                    if LoanType."Interest Recovered Upfront" then begin
                        "Repayment" := "Loan Principle Repayment";
                    end;
                end;

                "Loan Interest Repayment" := Round(LInterest, 1, '>');
                "Principal Repayment" := Round(LPrincipal, 1, '>');
                "Loan Principle Repayment" := Round(LPrincipal, 1, '>');

                if "Loan Product Type" = 'L10' then
                    Repayment := "Principal Repayment" else
                    Repayment := "Loan Interest Repayment" + "Principal Repayment";


                if LoanType."Share Deposit Capitilization %" > 0 then
                    "Deposit Boosting" := LoanType."Share Deposit Capitilization %" * "Approved Amount" * 0.01;

                if MemberActivities.GetAccountBalance(Legacy.GetShareCapitalAccount("Member No.")) < GenSetup."Minimum Share Capital" then
                    GetBoostingCommission()
                else
                    "Share Capital Boosting" := 0;

                //UpdateLoanCharges;
                GetLoanCharges();
                SaccoActivities.CreateCreditAccount(Rec);
            end;
        }
        field(7; "Annual Interest %"; Decimal)
        {
            Caption = 'Annual Interest';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                TestField("Loan Product Type");
                if LoanType.Get("Loan Product Type") then begin
                    if ("Annual Interest %" < LoanType."Interest Rate (Min.)") or ("Annual Interest %" > LoanType."Interest Rate (Max.)") then
                        Error(InterestErrorTxt);
                end;

                if "Approved Amount" > 0 then
                    Validate("Approved Amount");
            end;
        }
        field(8; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Installments; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                ValidateInstallments();

                IF "Approved Amount" > 0 THEN
                    VALIDATE("Approved Amount");



            end;
        }
        field(11; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CutOffDate: date;
            begin


                GenSetup.GET;

                if not Posted then
                    if "Disbursement Date" = 0D then
                        "Disbursement Date" := Today;

                LoanType.Get("Loan Product Type");

                if "Repayment Frequency" = "repayment frequency"::Daily then
                    "Repayment Start Date" := CalcDate('1D', "Disbursement Date")
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        "Repayment Start Date" := CalcDate('1W', "Disbursement Date")
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            "Repayment Start Date" := CalcDate('1M', "Disbursement Date")
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quarterly then
                                "Repayment Start Date" := CalcDate('1Q', "Disbursement Date")
                            else
                                if "Repayment Frequency" = "repayment frequency"::"Bi-Annual" then
                                    "Repayment Start Date" := CalcDate('6M', "Disbursement Date")
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Yearly then
                                        "Repayment Start Date" := CalcDate('1Y', "Disbursement Date")
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Bonus then begin

                                            BonusDate := Dmy2date(31, 10, Date2dmy("Disbursement Date", 3));

                                            if BonusDate > "Disbursement Date" then
                                                "Repayment Start Date" := BonusDate
                                            else
                                                "Repayment Start Date" := CalcDate('1Y', BonusDate);
                                        end;

                if LoanType."Cutoff Day" > 0 then begin
                    if Date2dmy("Disbursement Date", 1) > LoanType."Cutoff Day" then
                        "Repayment Start Date" := CalcDate('1M+CM', "Disbursement Date")
                    else
                        "Repayment Start Date" := CalcDate('CM', "Disbursement Date");
                end;
                if "Schedule Start Date" = 0D then
                    "Schedule Start Date" := "Repayment Start Date";


                Validate("Schedule Start Date");
            end;
        }
        field(12; "Type of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Full Disbursement,Partial Disbursement';
            OptionMembers = "Full Disbursement","Partial Disbursement";

            trigger OnValidate()
            begin

                if "Type of Disbursement" = "type of disbursement"::"Partial Disbursement" then begin
                    if "Approved Amount" >= "Amount To Disburse" then
                        Error(DisbErr);
                end else begin
                    if "Approved Amount" <> "Amount To Disburse" then
                        Error(Text002);
                end;

            end;
        }
        field(14; "Installment Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Repayment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loan Product Type Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Amount To Disburse"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                if ("Amount To Disburse" < "Approved Amount") then begin
                    "Type of Disbursement" := "type of disbursement"::"Partial Disbursement";
                end
                else begin
                    if ("Amount To Disburse" > "Approved Amount") then
                        Error('Cannot be greater than Approved Amount');

                    "Type of Disbursement" := "type of disbursement"::"Full Disbursement";
                end;

                if LoanType.Get("Loan Product Type") then
                    if LoanType."Appraise Security" then begin
                        CalcFields("Total Guaranteed");
                        if "Amount To Disburse" > "Total Guaranteed" then
                            Error(
                                'Amount to disburse %1 cannot be greater than total amount guaranteed %2.',
                                "Amount To Disburse",
                                "Total Guaranteed");
                    end;

                Rec.CalcFields("Loan Charges");
                Rec."Net To Be Disbursed" := Rec."Amount To Disburse" - Rec."Top Up Amount" - Rec."Loan Charges" - Rec."External Clearance" - Rec."Deposit Boosting Commission" - Rec."Share Capital Boosting";

                if LoanType.Get("Loan Product Type") then begin
                    if LoanType."Use Tiered Debt Threshold" then begin
                        Installments := GetTieredInstallments(LoanType."Product ID", "Amount To Disburse");
                        // Validate(Installments);
                    end;
                end;
                CalculateLoanRepayments("Amount To Disburse");
                GetLoanCharges();
            end;
        }
        field(19; "Consolidated Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Rescheduled Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Loan Balance at Rescheduling"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Loan Rescheduled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Date Rescheduled"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Reschedule by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat,Zero Interest';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat","Zero Interest";
            trigger OnValidate()
            begin
                Validate("Requested Amount");
            end;
        }
        field(29; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(30; "Max. Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Max. Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Total Disbursed"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Loan Disbursement"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")
                                                                        ));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement)))';
            FieldClass = FlowField;
        }
        field(34; "Repayment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Disbursement Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = if ("Mode of Disbursement" = const("Transfer to Fosa")) "Savings Accounts"."No." where("Member No." = field("Member No."))
            else
            if ("Mode of Disbursement" = filter(Cheque | EFT | RTGS | "Mobile Money")) "Bank Account"."No.";

            trigger OnValidate()
            begin

                //GetDisbAccount();
                if "Disbursement Account No" <> '' then begin
                    if not Posted then begin
                        //LoanType.GET("Loan Product Type");

                        if "Mode of Disbursement" = "mode of disbursement"::"Transfer to Fosa" then begin

                            SavAcc.Reset;
                            SavAcc.SetRange("No.", "Disbursement Account No");
                            if SavAcc.Find('-') then begin
                                if SavAcc.Status <> SavAcc.Status::Active then
                                    Message('Please Note that the disbursement Account is not Active');
                                if SavAcc.Blocked <> SavAcc.Blocked::" " then
                                    Message('Please Note that the disbursement Account is Blocked with type: %1', SavAcc.Blocked);

                            end;

                        end;
                    end;
                end;

                "Loan Account" := SaccoActivities.CreateCreditAccount(Rec); //Create Loan Credit Account

            end;


        }
        field(36; "Staff No"; Code[50])
        {
            CalcFormula = lookup(Members."Payroll/Staff No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(37; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(39; "Total Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(40; Defaulted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(42; "Last Advice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Advice Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,New Loan,Adjustment,Reintroduction,Stoppage';
            OptionMembers = " ","New Loan",Adjustment,Reintroduction,Stoppage;
        }
        field(44; "Loans Category-SASRA"; Option)
        {
            CalcFormula = lookup("Sasra Categorization"."Loan Category" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
            OptionCaption = 'Performing,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Performing,Watch,Substandard,Doubtful,Loss;
        }
        field(45; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Currency Filter"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Top Up Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Offset Existing","Add to Existing Loan";
        }
        field(48; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = " ", Cash, Salary, "Check Off", "Dividends", "Internal Standing Order", "External Standing Order";

        }
        field(50; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Bi-Annual,Yearly,Bonus,Tri-Annual';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,"Bi-Annual",Yearly,Bonus,"Tri-Annual";
        }
        field(51; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected,Deffered,"Pending Committee","Pending Guarantors";

            trigger OnValidate()
            var
                portalLoans: Record "Portal Loans";
                UserSetup: Record "User Setup";
            begin

                LoanType.Get("Loan Product Type");


                IF Status = Status::Approved THEN BEGIN

                    UserSetup.get(userid);
                    if not UserSetup."create loan" then
                        Error(Text001);

                    Rec.Validate("Loan Account");

                    portalLoans.Reset();
                    portalLoans.SetRange("Loan No.", "Loan No.");
                    if portalLoans.FindFirst() then begin
                        portalLoans.Status := portalLoans.Status::Approved;
                        portalLoans.Modify();
                    end;

                END;


                IF Status = Status::Rejected THEN BEGIN

                    IF Cust.GET("Member No.") THEN BEGIN
                        //MemberActivities.SendSms(SourceType::"Loan Rejected", Cust."Mobile Phone No.", 'Your ' + "Loan Product Type Name" + ' of KES ' + FORMAT("Approved Amount") + ' ' +
                        //'has been Rejected', "Loan No.", "Disbursement Account No", TRUE, FALSE);
                    END;

                    portalLoans.Reset();
                    portalLoans.SetRange("Loan No.", "Loan No.");
                    if portalLoans.FindFirst() then begin
                        portalLoans.Status := portalLoans.Status::Failed;
                        portalLoans.Modify();
                    end;


                END;
                IF Status = Status::Pending THEN BEGIN

                    portalLoans.Reset();
                    ;
                    portalLoans.SetRange("Loan No.", "Loan No.");
                    if portalLoans.FindFirst() then begin
                        portalLoans.Status := portalLoans.Status::Appraisal;
                        portalLoans.Modify();
                    end;


                END;


            end;
        }
        field(52; "Loan Rejection Reason"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Recommended Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Loan Officer"; code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            Caption = 'Account Manager';
        }
        field(56; "Email Address"; Text[80])
        {
            Caption = 'Email Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }

        field(57; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Outstanding Principal"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment"),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement|Principal Repayment),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(59; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Interest Due|Interest Paid),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Partial Disbursement Due"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Partial Disbursement"),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Partial Disbursement Due),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }

        field(62; "Loan Principle Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Loan Interest Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Employer Code"; Code[20])
        {
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
            FieldClass = FlowField;
            TableRelation = Customer;// where("Account Type" = const(Employer));
        }
        field(65; "Exempt Recovery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Discounted Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Discounted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF xRec."Discounted Amount">0 THEN
                //  ERROR("DiscErr:" ,xRec."Discounted Amount");

                /*
                GenSetup.GET;
                TotalDisc:=0;
                NetAmt:=0;
                LoanType.RESET;
                LoanType.SETRANGE(LoanType."Type of Discounting",LoanType."Type of Discounting"::"Loan Discounting");
                IF LoanType.FIND('-') THEN BEGIN
                LoanApp.RESET;
                LoanApp.SETRANGE(LoanApp."Member No.","Member No.");
                LoanApp.SETRANGE(LoanApp."Loan Product Type",LoanType.Code);
                LoanApp.SETFILTER(LoanApp."Outstanding Balance",'>0');
                IF LoanApp.FIND('-') THEN BEGIN
                  REPEAT
                    LoanApp.CALCFIELDS("Outstanding Balance");
                  TotalDisc:=TotalDisc+LoanApp."Outstanding Balance";
                  UNTIL LoanApp.NEXT=0;
                END;
                END;
                
                IF GenSetup."Maximum Discounting %"<=0 THEN
                  ERROR(Text016);
                NetAmt:=LoansProcess.ComputeCharges("Approved Amount","Loan Product Type","Loan No.",0);
                //MESSAGE('Appr %1 Dis Amt %2 NetAmt %3 Total Disc %4',"Approved Amount","Discounted Amount",NetAmt,TotalDisc);
                IF TotalDisc+"Discounted Amount">NetAmt*GenSetup."Maximum Discounting %"*0.01 THEN
                  ERROR(Text008,GenSetup."Maximum Discounting %");
                
                  */

            end;
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(70; "Booking Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(71; "Mode of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cheque,Mobile Money,EFT,RTGS';
            OptionMembers = " ","Cheque","Mobile Money",EFT,RTGS,"Transfer to Fosa";

            trigger OnValidate()
            begin
                GetDisbAccount;
            end;
        }
        field(74; "Recovered Loan"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Disbursement Header"."No." where(Posted = const(false),
                                                                   Status = const(Open));

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type") then begin
                    if LoanType."Requires Batching" then
                        Message(Text018);
                    if Status <> Status::Approved then
                        Error(Text017);
                end;
            end;
        }
        field(76; "KRA PIN"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Appraisal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Recovery Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80; Relationship; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(81; "Mobile Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Top Up Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans;
        }
        field(83; "Purpose of Loan"; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = '"Loan Purpose".Code';
        }
        field(84; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Deposit Boosting"; Decimal)
        {
            Caption = 'Boosted Shares';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //if "Deposit Boosting" >= "Approved Amount" then
                //  Error('This amount should be less than the approved amount %1', "Approved Amount");

                //UpdateLoanCharges();
                //GetLoanCharges();
            end;
        }
        field(86; "Form Serial No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Members.No. WHERE (Group Account=CONST(Yes))';
            TableRelation = Members."No." where("Group Account" = const(true));
        }
        field(88; "ID No."; Code[35])
        {
            CalcFormula = lookup(Members."ID No." where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(89; "Old Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Share Capital Boosting"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Share Capital Boosting" >= "Approved Amount" then
                    Error('This amount should be less than approved %1', "Approved Amount");

                GetLoanCharges();
                //UpdateLoanCharges();
            end;
        }
        field(91; "Minute Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Deposit Boosting Option"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Normal Boosting","Boosting on Maximum";
        }
        field(93; "Monthly Pre-Earned Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Outstanding Penalty"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Penalty Due" | "Penalty Paid"),
                                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(95; "Outstanding Appraisal"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Appraisal Due" | "Appraisal Paid"),
                                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(97; "Schedule Interest"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan No."),
                                                                                  "Repayment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(98; "Schedule Principal"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Principal" where("Loan No." = field("Loan No."),
                                                                                   "Repayment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(99; "Appraisal Fee Paid"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Appraisal Paid"),
                                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Recommended by Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Walk In,Marketer,Staff,Board Member,Member';
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member;

            trigger OnValidate()
            begin
                "Recommended By" := '';
                "Recommended By Name" := '';
            end;
        }
        field(101; "Recommended By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Recommended by Type" = const(Marketer)) "Salesperson/Purchaser"
            else
            if ("Recommended by Type" = const(Staff)) Employee
            else
            if ("Recommended by Type" = const(Member)) Members where("Member Category" = const(Member))
            else
            if ("Recommended by Type" = const("Board Member")) Members where("Member Category" = const("Board Members"));

            trigger OnValidate()
            begin

                if "Recommended by Type" = "recommended by type"::Marketer then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "Recommended By");
                    if SalespersonPurchaser.Find('-') then begin
                        "Recommended By Name" := SalespersonPurchaser.Name;
                    end;

                end
                else
                    if "Recommended by Type" = "recommended by type"::"Board Member" then begin
                        Members.Reset;
                        Members.SetRange("No.", "Recommended By");
                        if Members.Find('-') then begin
                            "Recommended By Name" := Members.Name;
                        end;
                    end
                    else
                        if "Recommended by Type" = "recommended by type"::Staff then begin
                            HREmployees.Reset;
                            HREmployees.SetRange("No.", "Recommended By");
                            if HREmployees.Find('-') then begin
                                "Recommended By Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            end;
                        end
                        else
                            if "Recommended by Type" = "recommended by type"::Member then begin
                                Members.Reset;
                                Members.SetRange("No.", "Recommended By");
                                if Members.Find('-') then begin
                                    "Recommended By Name" := Members.Name;
                                end;
                            end
                            else begin
                                "Recommended By Name" := "Recommended By";
                            end;
            end;
        }
        field(102; "Recommended By Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(103; "Interest Paid"; Decimal)
        {
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Interest Paid"),
                                                                         "User ID" = filter(<> ''),
                                                                         Amount = filter(<> 0),
                                                                         "Amount (LCY)" = filter(<> 0),
                                                                         "Posting Date" = field("Date Filter")));
            Description = '-Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Interest Paid),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(104; "Last Principal Pay Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Principal Repayment"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        Reversed = const(false),
                                                                        Amount = filter(< 0)));
            Description = 'Max("Credit Ledger Entry"."Posting Date" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Principal Repayment),Posting Date=FIELD(Date Filter),Reversed=CONST(No),Amount=FILTER(<0)))';
            FieldClass = FlowField;
        }
        field(105; "Principal Paid"; Decimal)
        {
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Principal Repayment"),
                                                                         "User ID" = filter(<> ''),
                                                                         Amount = filter(<> 0),
                                                                         "Amount (LCY)" = filter(<> 0),
                                                                         "Posting Date" = field("Date Filter")));
            Description = '-Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Interest Paid),Posting Date=FIELD(Date Filter)))';
            FieldClass = FlowField;
        }
        field(106; "Schedule Appraisal"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Appraisal" where("Loan No." = field("Loan No."),
                                                                                   "Repayment Date" = field("Date Filter")));
            Description = 'Sum("Loan Repayment Schedule"."Monthly Appraisal" WHERE (Loan No.=FIELD(Loan No.),Repayment Date=FIELD(Date Filter)))';
            FieldClass = FlowField;
        }
        field(107; "Last Pay Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Principal Repayment" | "Interest Paid" | "Penalty Paid" | "Insurance Paid"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        Reversed = const(false),
                                                                        Amount = filter(< 0)));
            Description = 'Max("Credit Ledger Entry"."Posting Date" WHERE (Loan No=FIELD(Loan No.),Transaction Type=FILTER(Repayment|Interest Paid|Appraisal Paid|Penalty Paid),Amount=FILTER(<0),Reversed=CONST(No),Posting Date=FIELD(Date Filter)))';
            FieldClass = FlowField;
        }
        field(108; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Amount Guaranteed" where("Loan No." = field("Loan No."),
                                                                         Substituted = filter(false)));
            Description = 'Sum("Loan Guarantors and Security"."Amount Guaranteed" WHERE (Loan No=FIELD(Loan No.),Substituted=CONST(No)))';
            FieldClass = FlowField;
        }
        field(109; "Total Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment" | "Interest Due" | "Interest Paid" | "Penalty Due" | "Penalty Paid" | "Insurance Due" | "Insurance Paid"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement|Principal Repayment),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(110; "Loan Calculator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(111; "Schedule Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            Var
                EndMonth: Date;
                StartMonth: Date;
                TDays: integer;
                Days: Integer;
                MonthlyInterest: Decimal;
                DateCodeunit: Codeunit "HR Codeunit.";
                DaysString: Text;
            begin
                "Upfront Interest Charge" := 0;
                "Upfront Days" := 0;

                if "Schedule Start Date" < "Repayment Start Date" then begin
                    if Posted then
                        "Repayment Start Date" := "Schedule Start Date"
                    else
                        Error('Schedule Start Date cannot be less than repayment start date');
                end;

                /*
                if "Repayment Frequency" = "repayment frequency"::Monthly then begin
                    if "Schedule Start Date" > CalcDate('1M+CM', "Disbursement Date") then
                        Error('Start Date cannot be greater than %1', CalcDate('1M+CM', "Disbursement Date"));
                end; 
                */
                if "Repayment Frequency" = "repayment frequency"::Monthly then begin
                    if "Schedule Start Date" < "Disbursement Date" then
                        Error('Start Date cannot be less than %1', CalcDate('1M+CM', "Disbursement Date"));
                end;

                //Validate("Schedule Start");
                if "Schedule Start Date" > "Repayment Start Date" then begin

                    //Repayment Start
                    /*EndMonth := CalcDate('CM', "Schedule Start Date");
                    TDays := Date2dmy(EndMonth, 1);
                    if Date2DMY("Schedule Start Date", 2) > Date2DMY("Repayment Start Date", 2) then begin
                        EndMonth := CalcDate('CM', Today);
                        Days := Date2dmy(EndMonth, 1) - Date2dmy("Repayment Start Date", 1);
                        StartMonth := CalcDate('CM+1D', Today);
                        // Days += Date2dmy("Schedule Start Date", 1) - Date2dmy(StartMonth, 1); Commented JN

                        Days := ("Schedule Start Date" - "Repayment Start Date") + 1;

                        //TDays := Date2dmy(CalcDate('CM', StartMonth), 1);
                    end else
                        //Days := Date2dmy("Schedule Start Date", 1) - Date2dmy("Repayment Start Date", 1) + 1; Commented JN

                    Days := DateCodeunit.DetermineDays("Repayment Start Date", "Schedule Start Date") + 1;

                    "Upfront Interest Charge" := ROUND("Loan Interest Repayment" * Days / TDays);
                    "Upfront Days" := Days;
        */

                    //if Days > 30 then
                    //    Error('The Schedule Start Date cannot be more than %1', 30 + 'D')

                end;
            end;
        }
        field(112; "Recovered from Savings"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Recovered from Guarantors"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Interest Due"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Interest Due"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(115; "Last Paid Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Principal Repayment" | "Interest Paid" | "Penalty Paid" | "Insurance Paid"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        Reversed = const(false),
                                                                        Amount = filter(< 0)));
            Description = 'Max("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No=FIELD(Loan No.),Transaction Type=FILTER(Repayment|Interest Paid|Appraisal Paid|Penalty Paid),Amount=FILTER(<0),Reversed=CONST(No),Posting Date=FIELD(Date Filter)))';

        }
        field(116; "Special Account"; Boolean)
        {
            CalcFormula = lookup(Members."Special Account" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(117; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Interest Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Principal Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Loan Recovery No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Adjusted Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Last Int. Due Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Interest Due"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        Reversed = const(false),
                                                                        Amount = filter(> 0)));
            FieldClass = FlowField;
        }
        field(123; "Cheque Discounting No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(125; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(126; "Principal Repayment"; Decimal)
        {
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Principal Repayment"),
                                                                         "User ID" = filter(<> ''),
                                                                         Amount = filter(<> 0),
                                                                         "Amount (LCY)" = filter(<> 0),
                                                                         "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement|Principal Repayment),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(127; "Total Arrears"; Decimal)
        {
            CalcFormula = lookup("SASRA Categorization"."Total Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(128; "SASRA Arrears"; Decimal)
        {
            CalcFormula = lookup("SASRA Categorization"."Total Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(129; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Top Up Amount"; Decimal)
        {
            CalcFormula = sum("Loan Top Up"."Total Top Up" where("Loan No." = field("Loan No."),
                                                                  "Member No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(131; "Loans Category-SACCO"; Option)
        {
            CalcFormula = lookup("SACCO Categorization"."Loan Category" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(132; "Stop Interest Due"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(133; "Principal Arrears"; Decimal)
        {
            CalcFormula = lookup("SASRA Categorization"."Principal Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(134; "Relationship Officer"; Code[50])
        {
        }
        field(135; "Loanee Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(136; "Member Category"; Option)
        {
            CalcFormula = lookup(Members."Member Category" where("No." = field("Member No.")));
            FieldClass = FlowField;
            OptionCaption = 'Member,Staff Members,Board Members,Delegates,Non-Member';
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member";
        }
        field(137; "Penalty Paid"; Decimal)
        {
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Penalty Paid"),
                                                                         "User ID" = filter(<> ''),
                                                                         Amount = filter(<> 0),
                                                                         "Amount (LCY)" = filter(<> 0),
                                                                         "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement|Principal Repayment),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(138; "Free Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(139; Recovered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Interest Due Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Interest Due"),
                                                                        Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(141; "Penalty Due Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Penalty Due"),
                                                                        Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(142; "Penalty Due"; Decimal)
        {
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Penalty Due"),
                                                                         "User ID" = filter(<> ''),
                                                                         Amount = filter(<> 0),
                                                                         "Amount (LCY)" = filter(<> 0),
                                                                         "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Loan Disbursement|Principal Repayment),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }
        field(143; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(144; "Deposit Boosting Commission"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                //if "Deposit Boosting" <= 0 then
                //  Error('This Deposit Boosting amount should not be less than or %1', 0);
                //GetLoanCharges();
            end;
        }
        field(145; "Loan Restructured"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(146; "Int Stop Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(147; "Last Mobile Loan Rem. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(148; "Mobile Loan Reminder"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","1","2","3";
        }
        field(149; "Rollover Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Rollover Logs" where("Loan No." = field("Loan No.")));
        }
        field(150; "Loans Category-Audit"; Option)
        {
            CalcFormula = lookup("SACCO Categories Audit"."Loan Category" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }

        field(151; "Total Guarantor Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Loan Security" where("Loan No." = field("Loan No."),
                                                                         Substituted = filter(false)));
        }
        field(152; "Portal Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(153; "Main Sector Code"; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sasra Main Sector";

            trigger OnValidate()
            var
                LevelTwo: Record "Sasra Sectorial Level 2";
                LevelOne: Record "Sasra Sectorial Level 1";
                MainSector: Record "Sasra Main Sector";
            begin
                "Main Sector Description" := '';
                MainSector.Reset();
                MainSector.SetRange("Main Sector Code", "Main Sector Code");
                if MainSector.FindFirst() then begin
                    "Main Sector Description" := MainSector."Main Sector Description";
                end;
            end;
        }
        field(154; "Main Sector Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


        field(155; "Sub-Sector Level 1 Code"; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sasra Sectorial Level 1"."Sub-Sector Level 1 Code" where("Main Sector Code" = field("Main Sector Code"));


            trigger OnValidate()
            var
                LevelTwo: Record "Sasra Sectorial Level 2";
                LevelOne: Record "Sasra Sectorial Level 1";
                MainSector: Record "Sasra Main Sector";
            begin
                "Sub-Sector Level 1 Description" := '';

                LevelOne.Reset();
                LevelOne.SetRange("Sub-Sector Level 1 Code", "Sub-Sector Level 1 Code");
                if LevelOne.FindFirst() then begin
                    "Sub-Sector Level 1 Description" := LevelOne."Sub-Sector Level 1 Description";
                end;
            end;
        }
        field(156; "Sub-Sector Level 1 Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(157; "Sub-Sector Level 2 Code"; Code[5])
        {
            DataClassification = ToBeClassified;

            TableRelation = "Sasra Sectorial Level 2"."Sub-Sector Level 2 Code" where("Main Sector" = field("Main Sector Code"), "Sub-Sector Level 1 Code" = field("Sub-Sector Level 1 Code"));

            trigger OnValidate()
            var
                LevelTwo: Record "Sasra Sectorial Level 2";
                LevelOne: Record "Sasra Sectorial Level 1";
                MainSector: Record "Sasra Main Sector";
            begin
                "Sub-Sector Level 2 Description" := '';
                LevelTwo.Reset();
                LevelTwo.SetRange("Sub-Sector Level 2 Code", "Sub-Sector Level 2 Code");
                if LevelTwo.FindFirst() then begin
                    "Sub-Sector Level 2 Description" := LevelTwo."Sub-Sector Level 2 Description";
                    if "Sub-Sector Level 1 Code" = '' then begin
                        "Sub-Sector Level 1 Code" := LevelTwo."Sub-Sector Level 1 Code";

                        LevelOne.Reset();
                        LevelOne.SetRange("Sub-Sector Level 1 Code", "Sub-Sector Level 1 Code");
                        if LevelOne.FindFirst() then begin
                            "Sub-Sector Level 1 Description" := LevelTwo."Sub-Sector Level 1 Description";
                            if "Main Sector Code" = '' then begin


                                MainSector.Reset();
                                MainSector.SetRange("Main Sector Code", LevelOne."Main Sector Code");
                                if MainSector.FindFirst() then begin
                                    "Main Sector Description" := MainSector."Main Sector Description";
                                end;

                            end;
                        end;
                    end;
                end;
            end;

        }
        field(158; "Sub-Sector Level 2 Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(159; "Already Suggested"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(160; "Type"; Option)
        {
            OptionMembers = Application,Appraisal;
        }


        field(161; "Test No."; Code[20])
        {
        }


        field(162; "Total Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(163; "Net To Be Disbursed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(164; "Bank Code"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes";

            trigger OnValidate()
            var
                BankCodes: Record "Bank Codes";
            begin
                "Bank Name" := '';
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
            end;
        }
        field(165; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(166; "Bank Branch"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Bank Code"));

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                //"Branch Name" := '';

                //if BankBranches.Get("Bank Code", "Branch Code") then
                //  "Branch Name" := BankBranches."Branch Name";
            end;
        }
        field(167; "Bank Account No"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(168; "Use Special Multiplier"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(169; "Deposit Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                if LoanType.Get("Loan Product Type") then begin
                    if "Deposit Multiplier" > LoanType."Deposit Multiplier" then
                        Error('Cannot Exceed Setup Value of %1', LoanType."Deposit Multiplier");
                end;
            end;

        }

        field(170; "Total Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(171; "Standing Order Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //if "Standing Order Amount" > 0 then
                //  TestField("Standing Order Recovery", true);
            end;
        }

        field(172; "Checkoff Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(173; "STO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(174; "Apraisal Check No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(175; "Self Guaranteed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(176; "Business Income Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(177; "Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(178; "Loan Suspended"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(179; "Loan Suspension Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(180; "Loan Suspension End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(181; "Salary Appraisal No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Salary Appraisal" where("Member No." = field("Member No."));

            trigger OnValidate()
            var
                Appraisal: Record "Member Salary Appraisal";
                NewTopUp: Record "Loan Top Up";
                NewClearance: Record "Other Committments Clearance";
                TopUp: Record "Appraisal Top Up";
                Clearance: Record "Other Committments Clearance";
                LSecurity: Record "Loan Security";
                NewLSecurity: Record "Loan Security";
                ArrearsRecovery: Record "Arrears Recovery";
                NewArrearsRecovery: Record "Arrears Recovery";
                LoanWitness: Record "Loan Witness";
                NewWitness: Record "Loan Witness";
                NewBankAcc: Record "HR Employee Bank Accounts";
                SourceBankAcc: Record "HR Employee Bank Accounts";

            begin

                "Requested Amount" := 0;
                "Approved Amount" := 0;
                "Recommended Amount" := 0;
                Installments := 0;
                "Relationship Officer" := '';
                Appraisal.Reset();
                Appraisal.SetRange("Appraisal No.", "Salary Appraisal No.");
                if Appraisal.FindFirst() then begin
                    Validate("Loan Product Type", Appraisal."Loan Product Type");


                    "Type of Disbursement" := Appraisal."Type of Disbursement";
                    "Requested Amount" := Appraisal."Requested Amount";
                    "Approved Amount" := Appraisal."Requested Amount";
                    Installments := Appraisal.Period;
                    "Relationship Officer" := Appraisal."Captured By";
                    "Amount To Disburse" := Appraisal."Amount To Disburse";
                    Validate("Approved Amount");
                    Validate("Net To Be Disbursed", Appraisal."Net Loan Take Home");
                    validate("Recommended Amount", Appraisal."Recommended Amount");
                    "Deposit Boosting" := Appraisal."Deposit Boosting";
                    Validate("Share Capital Boosting", Appraisal."Share Capital Boosting");
                    Validate("Deposit Boosted", Appraisal."Deposit Boosted");
                    Validate("Appraised By", Appraisal."Captured By");
                    "Deposit COntribution" := Appraisal."BOSA Savings";

                    "Rescheduled Loan" := Appraisal."Rescheduled Loan";
                    "Consolidated Loan" := Appraisal."Consolidated Loan";
                    "Fee Waiver Applied" := Appraisal."Fee Waiver Applied";

                    SalaryDetails.Reset();
                    SalaryDetails.SetRange("Loan No", Rec."Loan No.");
                    if SalaryDetails.FindFirst() then
                        SalaryDetails.DeleteAll();

                    Clearance.Reset();
                    Clearance.SetRange("Loan Application No.", Rec."Loan No.");
                    if Clearance.FindFirst() then
                        Clearance.DeleteAll();

                    ArrearsRecovery.Reset();
                    ArrearsRecovery.SetRange("Application No.", Rec."Loan No.");
                    if ArrearsRecovery.FindFirst() then
                        ArrearsRecovery.DeleteAll();

                    NewTopUp.Reset();
                    NewTopUp.SetRange("Loan No.", Rec."Loan No.");
                    if NewTopUp.FindFirst() then
                        NewTopUp.DeleteAll();



                    LSecurity.reset();
                    LSecurity.SetRange("Loan No.", "Loan No.");
                    if LSecurity.FindFirst() then
                        LSecurity.DeleteAll();

                    LoanWitness.reset();
                    LoanWitness.SetRange("Loan No.", "Loan No.");
                    if LoanWitness.FindFirst() then
                        LoanWitness.DeleteAll();

                    // Delete existing entries for this Loan No.
                    NewBankAcc.Reset();
                    NewBankAcc.SetRange("Loan No.", Rec."Loan No.");
                    if NewBankAcc.FindFirst() then
                        NewBankAcc.DeleteAll();

                    LoanCharges.Reset();
                    LoanCharges.SetRange("Loan No.", Rec."Loan No.");
                    if LoanCharges.FindFirst() then
                        LoanCharges.DeleteAll();

                    Appraisalcharges.Reset();
                    Appraisalcharges.SetRange("Loan No.", Appraisal."Appraisal No.");
                    if Appraisalcharges.FindFirst() then begin
                        LoanCharges.Init();
                        LoanCharges.TransferFields(Appraisalcharges);
                        LoanCharges."Loan No." := Rec."Loan No.";
                        LoanCharges.Insert();
                    end;

                    // Find source entries linked to the Appraisal No.
                    SourceBankAcc.Reset();
                    SourceBankAcc.SetRange("Loan No.", Appraisal."Appraisal No.");
                    if SourceBankAcc.FindSet() then begin
                        repeat
                            NewBankAcc.Init();
                            NewBankAcc.TransferFields(SourceBankAcc);
                            NewBankAcc."Loan No." := Rec."Loan No.";
                            NewBankAcc.Insert();
                        until SourceBankAcc.Next() = 0;
                    end;



                    LoanWitness.Reset();
                    LoanWitness.SetRange("Loan No.", Appraisal."Appraisal No.");
                    if LoanWitness.FindSet() then begin
                        repeat
                            NewWitness.init();
                            NewWitness."Loan No." := Rec."Loan No.";
                            NewWitness.Validate("Member No.", LoanWitness."Member No.");
                            NewWitness."Mobile Phone No" := LoanWitness."Mobile Phone No";
                            NewWitness.Category := NewWitness.Category::Witness;
                            NewWitness.Insert();
                        until LoanWitness.Next() = 0;
                    end;

                    ArrearsRecovery.reset();
                    ArrearsRecovery.SetRange("Application No.", Appraisal."Appraisal No.");
                    if ArrearsRecovery.findset() then
                        repeat
                            NewArrearsRecovery.init();
                            NewArrearsRecovery."Application No." := Rec."Loan No.";
                            NewArrearsRecovery."member No." := ArrearsRecovery."Member No.";
                            NewArrearsRecovery."Loan No" := ArrearsRecovery."Loan No";
                            NewArrearsRecovery."Interest Arrears" := ArrearsRecovery."Interest Arrears";
                            NewArrearsRecovery."Interest Arrears Recovered" := ArrearsRecovery."Interest Arrears Recovered";
                            NewArrearsRecovery."Principal Arrears" := ArrearsRecovery."Principal Arrears";
                            NewArrearsRecovery."Principal Arrears Recovered" := ArrearsRecovery."Principal Arrears Recovered";
                            NewArrearsRecovery.insert();
                        until ArrearsRecovery.next() = 0;

                    LSecurity.reset();
                    LSecurity.SetRange("Loan No.", Appraisal."Appraisal No.");
                    if LSecurity.findset() then
                        repeat

                            NewLSecurity.init();
                            NewLSecurity.TransferFields(LSecurity);
                            NewLSecurity."Loan No." := Rec."Loan No.";
                            if NewLSecurity."Amount Guaranteed" <> 0 then
                                NewLSecurity.insert();

                        until Lsecurity.next() = 0;

                    SalaryDetails.Reset();
                    SalaryDetails.SetRange("Loan No", Rec."Loan No.");
                    if not SalaryDetails.FindFirst() then begin
                        if Appraisal."Gross Pay" > 0 then begin
                            SalaryDetails.init();
                            SalaryDetails."Loan No" := Rec."Loan No.";
                            SalaryDetails.Validate(Type, SalaryDetails.Type::"Gross Pay");
                            SalaryDetails.Amount := Appraisal."Gross Pay";
                            SalaryDetails.Insert();
                        end;
                        if Appraisal."Other Deductions" > 0 then begin
                            SalaryDetails.init();
                            SalaryDetails."Loan No" := Rec."Loan No.";
                            SalaryDetails.Validate(Type, SalaryDetails.Type::Deductions);
                            SalaryDetails.Amount := Appraisal."Other Deductions";
                            SalaryDetails.Insert();
                        end;
                        if Appraisal."Net Salary" > 0 then begin
                            SalaryDetails.init();
                            SalaryDetails."Loan No" := Rec."Loan No.";
                            SalaryDetails.Validate(Type, SalaryDetails.Type::"Net Pay");
                            SalaryDetails.Amount := Appraisal."Net Salary";
                            SalaryDetails.Insert();
                        end;
                    end;

                    Clearance.Reset();
                    Clearance.SetRange("Loan Application No.", "sALARY Appraisal No.");
                    if Clearance.FindFirst() then begin
                        repeat
                            NewClearance.Init();
                            NewClearance.Validate("Loan Application No.", "Loan No.");
                            NewClearance.Validate("Document No,", Clearance."Document No,");
                            NewClearance.Validate(Type, Clearance.Type);
                            NewClearance.Validate("Account No.", Clearance."Account No.");
                            NewClearance.Validate(Description, Clearance.Description);
                            NewClearance.Validate("Loan No.", Clearance."Loan No.");
                            NewClearance.Validate(Amount, Clearance.Amount);
                            NewClearance.Insert();
                        until Clearance.Next() = 0;
                    end;


                    TopUp.Reset();
                    TopUp.SetRange("Loan No.", "sALARY Appraisal No.");
                    TopUp.SetFilter("Loan Top Up", '<>%1', '');
                    if TopUp.FindFirst() then begin
                        repeat
                            NewTopUp.Init();
                            NewTopUp.TransferFields(TopUp);
                            NewTopUp."Loan No." := Rec."Loan No.";
                            NewTopUp.Insert();

                        until TopUp.Next() = 0;
                    end;



                end;
            end;
        }


        field(182; "Debt Collector Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Internal,External;
        }

        field(183; "Debt Collector Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(184; "Debt Collector"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Debt Collector Type" = const(External)) "Salesperson/Purchaser"
            else
            if ("Debt Collector Type" = const(Internal)) Employee;

            trigger OnValidate()
            begin
                "Debt Collector Name" := '';

                if "Debt Collector Type" = "Debt Collector Type"::External then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "Debt Collector");
                    if SalespersonPurchaser.Find('-') then begin
                        "Debt Collector Name" := SalespersonPurchaser.Name;
                    end;
                end
                else
                    if "Debt Collector Type" = "Debt Collector Type"::Internal then begin
                        HREmployees.Reset;
                        HREmployees.SetRange("No.", "Debt Collector");
                        if HREmployees.Find('-') then begin
                            "Debt Collector Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                        end;
                    end;
            end;
        }
        field(186; "Debt Coll. Def Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(187; "Debt Coll. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(188; "Defaulter Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(189; "Defaulter Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Defaulted Amount Transfered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(191; "Old Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(192; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Select then begin
                    if "Batch No." <> '' then begin
                        Error('You cannot select a loan that has already been batched');
                    end;
                    "Selected By" := UserId;
                end;
            end;

        }
        field(193; "Selected By"; Code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(194; "Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(195; "Legacy Loan"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(196; "Ledger Exists"; Boolean)
        {
            CalcFormula = exist("Credit Ledger Entry" where("Loan No." = Field("Loan No.")));
            FieldClass = FlowField;
        }

        field(197; "Loan Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Loan Account" := SaccoActivities.CreateCreditAccount(Rec);
            end;
        }

        field(198; "Account Balance"; Decimal)
        {
            CalcFormula = - sum("Savings Ledger Entry"."Amount (LCY)" where("Account No." = field("Disbursement Account No")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var

            begin
                //GetPreviosRec(xRec."Outstanding Balance");
            end;
        }

        field(199; "Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Repayment" where("Loan No." = field("Loan No."),
                                                                                   "Repayment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(200; "Collector Updated By"; Code[50])
        {
        }

        field(201; "External Clearance"; Decimal)
        {
            CalcFormula = sum("Other Committments Clearance".Amount where("Loan Application No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(202; "Loan Charges"; Decimal)
        {
            CalcFormula = sum("Loan Charges"."Total Charge" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(203; "Employer Name"; Text[100])
        {
            CalcFormula = lookup(Members."Employer Name" where("No." = field("Member No.")));
            FieldClass = FlowField;
            TableRelation = Customer;// where("Account Type" = const(Employer));
        }
        field(204; "External STO Amount"; Decimal)
        {
        }

        field(205; "Last Int. Paid Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Interest Paid"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        Reversed = const(false),
                                                                        Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(206; "Posted By"; Code[50])
        {

            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }

        field(207; "Send SMS Reminder"; Boolean)
        {
            CalcFormula = lookup("Product Setup"."Auto Send SMS Alerts" where("product id" = field("Loan Product Type")));
            FieldClass = FlowField;
        }

        field(208; "Current Pay Date"; date)
        {
            CalcFormula = max("Loan Repayment Schedule"."Repayment Date" where("Loan No." = field("Loan No."),
                                                                                  "Repayment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }

        field(209; "Last Overdue SMS Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(210; "Last Defaulter SMS Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(211; "Standing Order Recovery"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SaccoActivities: Codeunit "Sacco Activities";
            begin
                TestField("Standing Order Amount");
                if ("Standing Order Amount" > 0) and ("Standing Order Recovery") then
                    SaccoActivities.CreateStandingOrder(Rec);
            end;
        }

        field(212; "Deposit Boosted"; Decimal)
        {
            Caption = 'Boosted Shares';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //if "Deposit Boosting" >= "Approved Amount" then
                //  Error('This amount should be less than the approved amount %1', "Approved Amount");

                //UpdateLoanCharges();
                GetLoanCharges();
            end;
        }
        field(213; "Schedule Insurance"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Insurance Contribution" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(259; "Old Installments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(261; "Appraised By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(263; "Appraised On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(264; "Approved On"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(265; "Product Sub Type"; Enum "Product Sub. Type")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PopulateSubType;
            end;
        }
        field(266; "Schedule Start"; Enum "Schedule Start")
        {

            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                /* case "Schedule Start" of
                     "Schedule Start"::"On 1st":
                         begin

                             "Schedule Start Date" := Calcdate('CM+1D', "Repayment Start Date");
                         end;
                     "Schedule Start"::"On 5th":
                         begin

                             "Schedule Start Date" := Calcdate('CM+5D', "Repayment Start Date");
                         end;
                     "Schedule Start"::"On 10th":
                         begin

                             "Schedule Start Date" := Calcdate('CM+10D', "Repayment Start Date");
                         end;
                     "Schedule Start"::"On 15th":
                         begin

                             "Schedule Start Date" := Calcdate('CM+15D', "Repayment Start Date");
                         end;
                     "Schedule Start"::"On 20th":
                         begin

                             "Schedule Start Date" := Calcdate('CM+20D', "Repayment Start Date");
                         end;
                     "Schedule Start"::"On 25th":
                         begin

                             "Schedule Start Date" := Calcdate('CM+25D', "Repayment Start Date");
                         end;
                     "Schedule Start"::"On 30th":
                         begin

                             "Schedule Start Date" := Calcdate('CM+30D', "Repayment Start Date");
                         end

                 end;
                 */
                if "Schedule Start Date" < "Repayment Start Date" then
                    if not Rec."Rescheduled Loan" then
                        Error('Schedule Start Date cannot be less than %1', "Repayment Start Date");

                if "Schedule Start Date" - "Repayment Start Date" > 30 then
                    Error('Schedule Date days cannot exceed more than %1 days', "Schedule Start Date" - "Repayment Start Date")
            end;
        }
        field(267; "SASRA Days Arrears"; Integer)
        {
            CalcFormula = lookup("SASRA Categorization"."Days in Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(268; "Disbursement Stage"; Option)
        {
            OptionMembers = " ",Finance,Disbursement;
        }
        field(269; "Net Income Per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(270; "Monthly Expenditure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(272; "Appraiser Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(273; "Credit Committee Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(274; "Board Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(275; "Business Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(276; "SASRA Months Arrears"; Integer)
        {
            CalcFormula = lookup("SASRA Categorization"."Months in Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(277; "Schedule Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Loan Repayment Schedule"."Loan Balance" where("Loan No." = field("Loan No."),
                                                                                   "Repayment Date" = field("Date Filter")));
        }
        field(2065; "TopUp Commission"; Decimal)
        {
            CalcFormula = sum("Loan Top Up".Commision where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(2066; "Require Committee Approval"; Boolean)
        {
        }

        field(2067; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "Loan No.", "Global Dimension 1 Code", "Booking Branch");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Booking Branch");
            end;
        }

        field(2068; "Upfront Days"; Integer)
        {
        }
        field(2069; "Upfront Interest Charge"; Decimal)
        {
        }
        field(2070; "Stop Penalty"; Boolean)
        {
        }
        field(2071; "Repayment Day"; Integer)
        {
        }
        field(2072; "Interest Run Date"; Date)
        {
        }
        field(2260; "Portal Loan Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2261; "Document File Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(2262; "Document Path"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(2263; "Azure Path"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }

        field(2264; Blob; Blob)
        {
            Caption = 'Blob';
            Subtype = Bitmap;
        }
        field(2265; "Old Last Pay Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2266; "Document Ref. No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2267; "Loan Moratorium Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2268; "Loan Moratorium End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2269; "Deposit COntribution"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposit Contribution';
        }
        field(2270; "CEO Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(2271; "Outstanding Insurance"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Insurance Due" | "Insurance Paid"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Insurance Due|Insurance Paid),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }

        field(2272; "Insurance Paid"; Decimal)
        {
            CalcFormula = - sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Insurance Paid"),
                                                                         "User ID" = filter(<> ''),
                                                                         Amount = filter(<> 0),
                                                                         "Amount (LCY)" = filter(<> 0),
                                                                         "Posting Date" = field("Date Filter")));
            Description = '-Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Insurance Paid),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2273; "Insurance Due"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Insurance Due"),
                                                                        "User ID" = filter(<> ''),
                                                                        Amount = filter(<> 0),
                                                                        "Amount (LCY)" = filter(<> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'Sum("Credit Ledger Entry"."Amount (LCY)" WHERE (Loan No.=FIELD(Loan No.),Transaction Type=FILTER(Insurance Due),Posting Date=FIELD(Date Filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2274; "Last Ins. Due Date"; Date)
        {
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Insurance Due"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        Reversed = const(false),
                                                                        Amount = filter(> 0)));
            FieldClass = FlowField;
        }
        field(2275; "Interest Arrears"; Decimal)
        {
            CalcFormula = lookup("SASRA Categorization"."Interest Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(2276; "Issued Date"; date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                        "Transaction Type" = filter("Loan Disbursement"),
                                                        "Amount (LCY)" = filter(> 0)));
        }
        field(2281; "Latest Disb. Posting Date"; Date)
        {
            Caption = 'Latest Disbursement Posting Date';
            CalcFormula = max("Credit Ledger Entry"."Posting Date" where("Loan No." = field("Loan No."),
                                                                         "Transaction Type" = filter("Loan Disbursement"),
                                                                         Reversed = const(false),
                                                                         "Amount (LCY)" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(2277; "Fee Waiver Applied"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2278; "Stop Insurance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2279; "Appraisal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Business,Staff;
            OptionCaption = 'Member,Staff';
            ValuesAllowed = Business, Staff;
        }

        field(2280; "Total Principal Top Up"; Decimal)
        {
            CalcFormula = sum("Loan Top Up"."Principle Top Up" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "Disbursement Date")
        {
        }
        key(Key3; "Member No.")
        {
        }
        key(Key4; "Repayment Day")
        {
        }
        key(Key5; Posted, Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan No.", "Member No.", "Member Name", "Loan Product Type Name", "Outstanding Principal", "Outstanding Interest", "Outstanding Penalty", "Outstanding Appraisal", "Total Outstanding Balance")
        {
        }
    }

    trigger OnInsert()
    begin


        if "Loan No." = '' then begin
            NSetup.Get();
            if "Mobile Loan" then begin

                NSetup.TestField("Mobile Loans No.");
                "Loan No." := NoSeries.GetNextNo(NSetup."Mobile Loans No.", WorkDate(), true);
            end else begin

                NSetup.TestField("Loan Nos.");
                "Loan No." := NoSeries.GetNextNo(NSetup."Loan Nos.", WorkDate(), true);

            end;

        end;

        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Dimension Set ID");
        //"Application Date" := Today;
        "Booking Branch" := UserSetup."Global Dimension 2 Code";
        "Dimension Set ID" := UserSetup."Dimension Set ID";
        "Captured By" := UserId;

        if not UserSetup."create loan" then
            Error(Text001)
    end;


    var
        Text001: Label 'You do not permission to create loans. Please contact ICT';
        NoSeries: Codeunit "No. Series";
        TotalMRepay: Decimal;

        DefaultDF: DateFormula;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        ShareBoostComm: Decimal;
        "Shares Boosted": Boolean;
        DimMgt: Codeunit DimensionManagement;
        ClientAge: Text;
        ClientAgeValue: Integer;
        ClientAgePart: Text;
        ProdMinAgeText: Text;
        ProdMinAge: Integer;
        UserSetup: Record "User Setup";
        NoOfDays: Integer;
        NoOfMonths: Decimal;
        InstalmentPeriods: DateFormula;
        IntstallMentPeriodText: Text;
        i: Integer;
        PeriodStartDate: array[6] of Date;
        StartDate: Date;
        BusDateFilter: Text;
        LowerDateLimit: Date;
        UpperDateLimit: Date;
        LastMonthDate: Date;
        TotalDisc: Decimal;
        EndDateSalo: Date;
        NetAmt: Decimal;
        BalGuara: Decimal;
        SelfGuaBal: Decimal;
        MaxSelfGuar: Decimal;
        SourceType: Enum "SMS Source Enum";
        AmortisedInt: Decimal;
        TotalLoans: Decimal;
        Unpaid: Text;
        LArrears: Text;
        BonusDate: Date;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        MicroDef: Text;
        ProductSubType: Record "Loan Sub. Types";
        "DiscErr:": label 'Loan is already discounted by %1';
        "InactiveErr:": label 'This member account is not active';
        LoanAmountErr: label 'The loan applied is not within allowed margins Max Loan %1 and Max Loan %2 for product %3. Requested amount is %4';
        InstallmentsErr: label 'Number of installments must be greater than Zero.';
        DateErr: label 'The date is invalid. It should not be in the past';
        DisbErr: label 'The amount to disburse cannot be greater than or equal to approved amount';
        ApprovedAmtErr: label 'The approved amount cannot be greater than requested amount';
        AmountToDisb: label 'Amount to disburse cannot be greater than approved amount';
        Text002: label 'Amount to disburse must be equal to amount approved';
        Text003: label 'This member has a loan which has not be repaid';
        Text004: label 'This member has a loan in arrears %1';
        Text005: label 'This Member age is less than the limit of %1';
        Text006: label 'You cannot exceed the maximum installments';
        Text007: label 'You cannot apply this product without an active Fixed Deposit';
        Err008: label 'You cannot apply more than Amount Fixed';
        ErrGua: label 'You cannot self guarantee where you have guaranteed running loans';
        Text008: label 'You cannot discount above %1 Percent of the approved amount';
        Text009: label 'Salary Must be through the SACCO to get this loan';
        Text010: label 'This member is from another sacco excempted from minimum membership limit';
        Text011: label 'This member has lower deposits of %1 than expected of deposits of %2 ';
        InterestErrorTxt: label 'Interest Rate is not within allowed range.';
        Text012: label 'The applicant is a defaulter - Loan No. %1';
        Text013: label 'The member has a loan recocered from guarantors refference %1';
        Text014: label 'The member must be remmitting checkoff to the organization to qualify';
        Text015: label 'The requested amount is more than availabe deposit balance for self guarantee';
        Text016: label 'Maximum discounting percentage allowable must be defined';
        Text017: label 'The loan must be approved before assigning a batch';
        Err002: label 'CRM application is already in use by Loan No. %1';
        Text018: label 'This product does not require batching';
        Text019: label 'This member does not have sufficient share capital: %1 Expected minimum is %2 ';
        NSetup: Record "Sales & Receivables Setup";
        ProductSetup: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        Cust: Record Members;
        Loan: Record Loans;
        Members: Record Members;
        LoanType: Record "Product Setup";
        DisbProducts: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        GenSetup: Record "Sacco Setup";
        LoanApp: Record Loans;
        SavingsProduct: Record "Product Setup";
        Appraisal: Record "Loan Appraisal";
        HREmployees: Record Employee;
        GenJournalLine: Record "Gen. Journal Line";
        Appraisalcharges: Record "Loan Charges";
        LoanCharges: Record "Loan Charges";
        SalaryDetails: Record "Appraisal Salary Details";
        LoanSecurity: Record "Loan Security";
        Legacy: codeunit Legacy;
        OtherCommitementsClearance: Record "Other Committments Clearance";

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Loans, "Loan No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    local procedure AvailableCreditLimit()
    begin
        "Amount To Disburse" := xRec."Amount To Disburse";
    end;

    local procedure ValidateInstallments()
    var
        TieredThreshold: Record "Tiered Debt Threshold";
        MaxInstallments: Integer;
        LoanProduct: Record "Product Setup";
        MemberSalary: Record "Member Salary Appraisal";

    begin
        if (Installments = 0) or ("Loan Product Type" = '') or ("Approved Amount" = 0) then
            exit;


        MaxInstallments := GetTieredInstallments("Loan Product Type", "Approved Amount");

        if MaxInstallments = 0 then begin

            if LoanProduct.Get("Loan Product Type") then begin
                if Installments > LoanProduct."Default Installments" then
                    Error('Installments cannot exceed %1 months for this loan product.',
                          LoanProduct."Default Installments");
            end;
        end else begin

            if Installments > MaxInstallments then
                Error('Installments cannot exceed %1 months for loan amount %2.',
                      MaxInstallments,
                      "Approved Amount");
        end;
    end;

    local procedure PopulateBankDetailsFromMember(MemberNo: code[20])
    var
        Member: Record Members;
    begin

        if MemberNo = '' then
            exit;
        if Member.Get(MemberNo) then begin
            if Rec."Loan No." <> '' then begin

                Rec."Bank Code" := Member."Bank Code";
                Rec."Bank Name" := Member."Bank Name";
                Rec."Bank Branch" := Member."Branch Name";
                Rec."Bank Account No" := Member."Bank Account No.";

                Modify();
            end;
        end;
    end;

    procedure SetCEOComment(NewCEOComments: Text)
    var
        OutStream: OutStream;
    begin
        Clear("CEO Comments");
        "CEO Comments".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewCEOComments);
        Modify();
    end;

    procedure GetCEOComment() CEOCOMMENTS: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("CEO Comments");
        "CEO Comments".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("CEO Comments")));
    end;

    procedure GetAppraiserComment(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Appraiser Comments");
        "Appraiser Comments".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Appraiser Comments")));
    end;

    procedure SetAppraiserComment(NewComment: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Appraiser Comments");
        "Appraiser Comments".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewComment);
        Modify();
    end;

    procedure GetCreditCommitteeComment(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Credit Committee Comments");
        "Credit Committee Comments".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Credit Committee Comments")));
    end;

    procedure SetCreditCommitteeComment(NewComment: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Credit Committee Comments");
        "Credit Committee Comments".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewComment);
        Modify();
    end;

    procedure GetBoardComment(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Board Comments");
        "Board Comments".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Board Comments")));
    end;

    procedure SetBoardComment(NewComment: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Board Comments");
        "Board Comments".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewComment);
        Modify();
    end;

    local procedure GetBoostingCommission()
    var
        myInt: Integer;
        Value: Decimal;
        Sharecap: Record "Share Capital Controls";
        SaccoSetup: Record "Sacco Setup";
        ShareCapital: Record "Savings Accounts";
    begin
        Value := "Approved Amount";
        //"Share Capital Boosting" := 0;
        SaccoSetup.Get();

        ShareCapital.Reset();
        ShareCapital.SetRange("Member No.", "Member No.");
        ShareCapital.setrange("Product Category", ShareCapital."Product Category"::"Share Capital");
        Sharecapital.SetAutoCalcFields("Balance (LCY)");
        if ShareCapital.findfirst() then;

        Sharecap.Reset;
        Sharecap.SetRange("Loan Product", "Loan Product Type");
        if Sharecap.Find('-') then begin
            "Share Capital Boosting" := 0;
            repeat
                if (Value >= Sharecap.Minimum) and (Value <= Sharecap.Maximum) then begin
                    "Share Capital Boosting" := Value * Sharecap."Capitilize Amount %" * 0.01;
                    //if "Share Capital Boosting" > Sharecapital."Balance (LCY)" then
                    if ("Share Capital Boosting" + Sharecapital."Balance (LCY)") > SaccoSetup."Minimum Share Capital" then
                        "Share Capital Boosting" := SaccoSetup."Minimum Share Capital" - Sharecapital."Balance (LCY)";

                    if "Share Capital Boosting" < 0 then "Share Capital Boosting" := 0;
                end;
            until Sharecap.Next() = 0;
        end;
    end;


    procedure ClearLoanDetails()
    var
        LoanGuara: Record "Loan Security";
        TopUp: Record "Loan Top Up";
    begin

        if "Loan No." <> '' then begin

            LoanGuara.Reset;
            LoanGuara.SetRange("Loan No.", "Loan No.");
            if LoanGuara.FindFirst then
                LoanGuara.DeleteAll;

            TopUp.Reset;
            TopUp.SetRange("Loan No.", "Loan No.");
            if TopUp.FindFirst then
                TopUp.DeleteAll;


            LoanCharges.Reset;
            LoanCharges.SetRange("Loan No.", "Loan No.");
            if LoanCharges.FindFirst then
                LoanCharges.DeleteAll;




            /*
            CurrentLoanCharges.RESET;
            CurrentLoanCharges.SETRANGE("Loan No.","Loan No.");
            IF CurrentLoanCharges.FINDFIRST THEN
              CurrentLoanCharges.DELETEALL;
            */

            OtherCommitementsClearance.RESET;
            OtherCommitementsClearance.SETRANGE("Loan Application No.", "Loan No.");
            IF OtherCommitementsClearance.FINDFIRST THEN
                OtherCommitementsClearance.DELETEALL;


            "Requested Amount" := 0;
            "Approved Amount" := 0;
            "Amount To Disburse" := 0;
            "Recommended Amount" := 0;
            "Registration Fee" := 0;

            //"Application Date" := Today;
            "Disbursement Date" := 0D;
            "Repayment Start Date" := 0D;
            "Schedule Start Date" := 0D;
            "Loan Product Type" := '';


        end;

    end;

    /// <summary>
    /// GetLoanCharges.
    /// </summary>
    procedure GetLoanCharges()
    var
        PCharges: Record "Loan Product Charges.";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        Members: Record Members;
        Continue: Boolean;
        Value: Decimal;
        otherComm: Record "Other Committments Clearance";
    begin

        if not Posted then begin

            LoanCharges.Reset;
            LoanCharges.SetRange("Loan No.", "Loan No.");
            if LoanCharges.FindFirst then
                LoanCharges.DeleteAll;

            GenSetup.Get;

            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.SetFilter(PCharges."Charge Type", '%1|%2', PCharges."Charge Type"::General, PCharges."Charge Type"::"Loan Processing Fee");
            if PCharges.Find('-') then begin
                repeat
                    PChAmt := 0;
                    GL := '';
                    EDuty := 0;

                    Value := "Amount To Disburse";
                    if PCharges."Charging Option" = PCharges."Charging Option"::"Amount to Disburse Less Topup" then begin
                        CalcFields("Total Principal Top Up");
                        Value := "Amount To Disburse" - "Total Principal Top Up";
                        if Value < 0 then
                            Value := 0;
                    end;
                    //changes added on 092426 Cal0019
                    if PCharges."Charging Option" = PCharges."Charging Option"::"Approved Amount Less Topup" then begin
                        CalcFields("Total Principal Top Up");
                        Value := "Approved Amount" - "Total Principal Top Up";
                        if Value < 0 then
                            Value := 0;
                    end;



                    MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Value, PChAmt, EDuty, GL);
                    PChAmt := SaccoActivities.SmartRound(PChAmt);
                    EDuty := SaccoActivities.SmartRound(Eduty);

                    LoanCharges.Init;
                    LoanCharges."Loan No." := "Loan No.";
                    LoanCharges."Loan Product Type" := "Loan Product Type";
                    LoanCharges."Charge Code" := PCharges."Charge Code";
                    LoanCharges.Description := PCharges.Description;
                    LoanCharges."Charge %" := PCharges.Percentage;
                    LoanCharges.Amount := PChAmt;
                    LoanCharges."Excise Duty" := EDuty;
                    LoanCharges."Total Charge" := PChAmt + EDuty;
                    LoanCharges."Account Type" := PCharges."Account Type";
                    LoanCharges."Account No." := PCharges."Account No.";
                    LoanCharges."Posting Type" := PCharges."Posting Type";
                    LoanCharges."Is Sms Charge" := PCharges."Is Sms Alert";
                    LoanCharges."Charge Type" := PCharges."Charge Type";


                    if EDuty > 0 then begin
                        GenSetup.TestField("Excise Duty GL");
                        LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                    end;
                    LoanCharges.Insert;

                until PCharges.Next = 0;
            end;

            Members.get("Member No.");
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.SetFilter(PCharges."Charge Type", '%1|%2', PCharges."Charge Type"::Insurance, PCharges."Charge Type"::Non_Individual);
            //if Members."Member Category" <> Members."Member Category"::"Staff Members" then
            if PCharges.Find('-') then begin
                repeat
                    Continue := false;


                    if Members."Account Category" = Members."Account Category"::Individual then begin
                        if Members.Type = Members.Type::Group then begin
                            if PCharges."Charge Type" = PCharges."Charge Type"::Non_Individual then
                                Continue := true;
                        end
                        else
                            if Members.Type = Members.Type::Member then begin

                                if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                                    Continue := true;
                            end;

                    end
                    else begin

                        if PCharges."Charge Type" = PCharges."Charge Type"::Non_Individual then
                            Continue := true;
                    end;


                    if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then
                        Continue := true;

                    Value := "Amount To Disburse";

                    if Continue then begin

                        if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then begin
                            otherComm.Reset();
                            otherComm.SetRange("Loan Application No.", "Salary Appraisal No.");
                            if otherComm.FindFirst() then begin
                                otherComm.CalcSums(Amount);
                                Value := otherComm.Amount;
                            end;
                        end;

                        PChAmt := 0;
                        GL := '';
                        EDuty := 0;
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Value, PChAmt, EDuty, GL);
                        PChAmt := SaccoActivities.SmartRound(PChAmt);
                        EDuty := SaccoActivities.SmartRound(Eduty);
                        //if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                        //  PChAmt := PChAmt * Installments / 10;
                        if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                            Rec."Total Insurance" := PChAmt + EDuty;


                        //Message('PCharges."Charge Type" %1 \ PCHamt %2', PCharges."Charge Type", PChAmt);
                        if Pcharges."Charge Type" <> PCharges."charge type"::Insurance then begin
                            LoanCharges.Init;
                            LoanCharges."Loan No." := "Loan No.";
                            LoanCharges."Loan Product Type" := "Loan Product Type";
                            LoanCharges."Charge Code" := PCharges."Charge Code";
                            LoanCharges.Description := PCharges.Description;
                            LoanCharges."Charge %" := PCharges.Percentage;
                            LoanCharges.Amount := PChAmt;
                            LoanCharges."Excise Duty" := EDuty;
                            LoanCharges."Total Charge" := PChAmt + EDuty;
                            LoanCharges."Account Type" := PCharges."Account Type";
                            LoanCharges."Account No." := PCharges."Account No.";
                            LoanCharges."Posting Type" := PCharges."Posting Type";
                            LoanCharges."Charge Type" := PCharges."Charge Type";


                            if EDuty > 0 then begin
                                GenSetup.TestField("Excise Duty GL");
                                LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                            end;
                            LoanCharges.Insert;

                        end;
                    end;
                until PCharges.Next = 0;
            end;


            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Deposit Financing");
            if PCharges.Find('-') then begin
                repeat

                    LoanCharges.Reset;
                    LoanCharges.SetRange(LoanCharges."Loan No.", "Loan No.");
                    LoanCharges.SetRange(LoanCharges."Charge Code", PCharges."Charge Code");
                    if LoanCharges.Find('-') then
                        LoanCharges.DeleteAll();

                    //if "Deposit Boosting" > 0 then begin

                    PChAmt := 0;
                    GL := '';
                    EDuty := 0;

                    MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", "Deposit Boosted", PChAmt, EDuty, GL);
                    PChAmt := SaccoActivities.SmartRound(PChAmt);
                    EDuty := SaccoActivities.SmartRound(Eduty);

                    Rec."Deposit Boosting Commission" := PChAmt + EDuty;

                    LoanCharges.Init;
                    LoanCharges."Loan No." := "Loan No.";
                    LoanCharges."Loan Product Type" := "Loan Product Type";
                    LoanCharges."Charge Code" := PCharges."Charge Code";
                    LoanCharges.Description := PCharges.Description;
                    LoanCharges."Charge %" := PCharges.Percentage;
                    LoanCharges.Amount := PChAmt;
                    LoanCharges."Excise Duty" := EDuty;
                    LoanCharges."Total Charge" := PChAmt + EDuty;
                    LoanCharges."Account Type" := PCharges."Account Type";
                    LoanCharges."Account No." := PCharges."Account No.";
                    LoanCharges."Posting Type" := PCharges."Posting Type";


                    if EDuty > 0 then begin
                        GenSetup.TestField("Excise Duty GL");
                        LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                    end;
                    LoanCharges.Insert;
                //end;

                until PCharges.Next = 0;
            end;


            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Share Financing");
            if PCharges.Find('-') then begin
                repeat

                    LoanCharges.Reset;
                    LoanCharges.SetRange(LoanCharges."Loan No.", "Loan No.");
                    LoanCharges.SetRange(LoanCharges."Charge Code", PCharges."Charge Code");
                    if LoanCharges.Find('-') then
                        LoanCharges.DeleteAll();

                    if "Share Capital Boosting" > 0 then begin

                        PChAmt := 0;
                        GL := '';
                        EDuty := 0;
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", "Share Capital Boosting", PChAmt, EDuty, GL);
                        PChAmt := SaccoActivities.SmartRound(PChAmt);
                        EDuty := SaccoActivities.SmartRound(Eduty);

                        LoanCharges.Init;
                        LoanCharges."Loan No." := "Loan No.";
                        LoanCharges."Loan Product Type" := "Loan Product Type";
                        LoanCharges."Charge Code" := PCharges."Charge Code";
                        LoanCharges.Description := PCharges.Description;
                        LoanCharges."Charge %" := PCharges.Percentage;
                        LoanCharges.Amount := PChAmt;
                        LoanCharges."Excise Duty" := EDuty;
                        LoanCharges."Total Charge" := PChAmt + EDuty;
                        LoanCharges."Account Type" := PCharges."Account Type";
                        LoanCharges."Account No." := PCharges."Account No.";
                        LoanCharges."Posting Type" := PCharges."Posting Type";


                        if EDuty > 0 then begin
                            GenSetup.TestField("Excise Duty GL");
                            LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                        end;
                        LoanCharges.Insert;
                    end;
                until PCharges.Next = 0;
            end;
        end;
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            Rec, "Dimension Set ID", "Loan No.", "Global Dimension 1 Code", "Booking Branch");

        IsChanged := OldDimSetID <> "Dimension Set ID";
    end;
    /// <summary>
    /// GetLoanCharges.
    /// </summary>
    procedure GetAdjustedApprovedAmount()
    var
        PCharges: Record "Loan Product Charges.";
        LProduct: Record "Product Setup";
        LoanAmount1: Decimal;
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        Members: Record Members;
        Continue: Boolean;
        Value: Decimal;
        otherComm: Record "Other Committments Clearance";
    begin

        if not Posted then begin

            Rec.Testfield("Top Up Amount");
            Rec.CalcFields("Top Up Amount");
            Rec."Requested Amount" := Rec."Top Up Amount";
            Value := 0;
            LoanAmount1 := Rec."Top Up Amount";

            LProduct.reset();
            LProduct.setrange("Product ID", "Loan Product Type");
            LProduct.setrange("Allow Special Offset", true);
            if LProduct.findfirst then begin


                PCharges.Reset;
                PCharges.SetRange("Product Code", "Loan Product Type");
                //PCharges.SetRange("Charge Code", ChargeCode);
                PCharges.SETRANGE("Charge Method", PCharges."charge method"::"Flat Amount");
                if PCharges.Find('-') then
                    repeat

                        LoanAmount1 += PCharges."Charge Amount";

                    until PCharges.next() = 0;

                PCharges.Reset;
                PCharges.SetRange("Product Code", "Loan Product Type");
                PCharges.SETRANGE("Charge Method", PCharges."charge method"::"% of Amount");
                if PCharges.Find('-') then
                    repeat

                        Value += LoanAmount1 / (1 - (PCharges.Percentage / 100));

                    until PCharges.next() = 0;

                Rec."Requested Amount" := Value;
                Rec.Validate("Requested Amount");
            end;
        end
    end;

    procedure GetDisbAccount()
    begin
        //Validate("Disbursement Account No", '');
        if "Mode of Disbursement" = "mode of disbursement"::"Transfer to Fosa" then begin


            DisbProducts.Reset;
            DisbProducts.SetRange("Loan Processing Account", true);
            DisbProducts.SetRange("Product Category", DisbProducts."product category"::"Ordinary Savings");
            if DisbProducts.FindFirst then begin
                repeat

                    Cust.Get("Member No.");

                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", "Member No.");
                    SavAcc.SetRange("Product Type", DisbProducts."Product ID");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                    if SavAcc.Find('-') then begin
                        //if SavAcc.Count = 1 then
                        Validate("Disbursement Account No", SavAcc."No.")

                    end;
                //else if "Loan Product Type" <> 'L43' then
                //   Message('This member does not have a %1 loan disbursement savings account', DisbProducts."Product ID");

                until DisbProducts.next() = 0;
            end;
        end;

    end;

    procedure UpdateLoanCharges()
    var
        PCharges: Record "Loan Product Charges.";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        Value: Decimal;
    begin

        if not Posted then begin

            GenSetup.Get;

            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Deposit Financing");
            if PCharges.Find('-') then begin
                repeat

                    LoanCharges.Reset;
                    LoanCharges.SetRange(LoanCharges."Loan No.", "Loan No.");
                    LoanCharges.SetRange(LoanCharges."Charge Code", PCharges."Charge Code");
                    if LoanCharges.Find('-') then
                        LoanCharges.DeleteAll();

                    if "Deposit Boosting" > 0 then begin
                        PChAmt := 0;
                        GL := '';
                        EDuty := 0;
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", "Deposit Boosting", PChAmt, EDuty, GL);

                        LoanCharges.Init;
                        LoanCharges."Loan No." := "Loan No.";
                        LoanCharges."Loan Product Type" := "Loan Product Type";
                        LoanCharges."Charge Code" := PCharges."Charge Code";
                        LoanCharges.Description := PCharges.Description;
                        LoanCharges."Charge %" := PCharges.Percentage;
                        LoanCharges.Amount := PChAmt;
                        LoanCharges."Excise Duty" := EDuty;
                        LoanCharges."Total Charge" := PChAmt + EDuty;
                        LoanCharges."Account Type" := PCharges."Account Type";
                        LoanCharges."Account No." := PCharges."Account No.";
                        LoanCharges."Posting Type" := PCharges."Posting Type";


                        if EDuty > 0 then begin
                            GenSetup.TestField("Excise Duty GL");
                            LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                        end;
                        LoanCharges.Insert;
                    end;

                until PCharges.Next = 0;
            end;





            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Share Financing");
            if PCharges.Find('-') then begin
                repeat


                    LoanCharges.Reset;
                    LoanCharges.SetRange(LoanCharges."Loan No.", "Loan No.");
                    LoanCharges.SetRange(LoanCharges."Charge Code", PCharges."Charge Code");
                    if LoanCharges.Find('-') then
                        LoanCharges.DeleteAll();



                    if "Share Capital Boosting" > 0 then begin

                        PChAmt := 0;
                        GL := '';
                        EDuty := 0;
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", "Share Capital Boosting", PChAmt, EDuty, GL);

                        LoanCharges.Init;
                        LoanCharges."Loan No." := "Loan No.";
                        LoanCharges."Loan Product Type" := "Loan Product Type";
                        LoanCharges."Charge Code" := PCharges."Charge Code";
                        LoanCharges.Description := PCharges.Description;
                        LoanCharges."Charge %" := PCharges.Percentage;
                        LoanCharges.Amount := PChAmt;
                        LoanCharges."Excise Duty" := EDuty;
                        LoanCharges."Total Charge" := PChAmt + EDuty;
                        LoanCharges."Account Type" := PCharges."Account Type";
                        LoanCharges."Account No." := PCharges."Account No.";
                        LoanCharges."Posting Type" := PCharges."Posting Type";


                        if EDuty > 0 then begin
                            GenSetup.TestField("Excise Duty GL");
                            LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                        end;
                        LoanCharges.Insert;
                    end;
                until PCharges.Next = 0;

            end;


            LoanCharges.Reset;
            LoanCharges.SetRange(LoanCharges."Loan No.", "Loan No.");
            LoanCharges.SetRange(LoanCharges."Loan Product Type", "Loan Product Type");
            if LoanCharges.Find('-') then begin
                repeat

                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
                    PCharges.SetRange(PCharges."Charge Code", LoanCharges."Charge Code");
                    PCharges.SetFilter("Charge Type", '<>%1&<>%2', PCharges."Charge Type"::"Deposit Financing", PCharges."Charge Type"::"Share Financing");
                    if PCharges.Find('-') then begin


                        PChAmt := 0;
                        GL := '';
                        EDuty := 0;

                        Value := "Approved Amount";
                        if PCharges."Charging Option" = PCharges."Charging Option"::"Amount to Disburse Less Topup" then begin
                            CalcFields("Total Principal Top Up");
                            Value := "Amount To Disburse" - "Total Principal Top Up";
                            if Value < 0 then
                                Value := 0;
                        end;
                        //changes added on 092426 Cal0019
                        if PCharges."Charging Option" = PCharges."Charging Option"::"Approved Amount Less Topup" then begin
                            CalcFields("Total Principal Top Up");
                            Value := "Approved Amount" - "Total Principal Top Up";
                            if Value < 0 then
                                Value := 0;
                        end;
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", LoanCharges."Charge Code", 0, Value, PChAmt, EDuty, GL);

                        LoanCharges.Description := PCharges.Description;
                        LoanCharges."Charge %" := PCharges.Percentage;
                        LoanCharges.Amount := PChAmt;
                        LoanCharges."Excise Duty" := EDuty;
                        LoanCharges."Total Charge" := PChAmt + EDuty;
                        LoanCharges."Account Type" := PCharges."Account Type";
                        LoanCharges."Account No." := PCharges."Account No.";


                        if EDuty > 0 then begin
                            GenSetup.TestField("Excise Duty GL");
                            LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                        end;
                        LoanCharges.Modify;
                    end;
                until LoanCharges.Next = 0;
            end;

        end;
    end;

    procedure GetFreeShares()
    var
        MAcc: Record "Savings Accounts";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;
        PSetup: Record "Product Setup";
        LoanTopUp: Record "Loan Top Up";
        ProductSetup: Record "Product Setup";
        LRec: Record Loans;
    begin

        ProductSetup.Get("Loan Product Type");
        "Free Shares" := 0;

        PSetup.Reset;
        PSetup.SetRange("Product ID", ProductSetup."Appraisal Product");
        if PSetup.FindFirst then begin

            MAcc.Reset;
            MAcc.SetRange("Member No.", "Member No.");
            MAcc.SetRange("Product Type", PSetup."Product ID");
            if MAcc.FindFirst then
                LoanSecurity.CalculateAvailableShares(MAcc, DepAmt, GuaranteedInApplication, Committed, "Free Shares", false);


            LoanTopUp.Reset;
            LoanTopUp.SetRange("Loan No.", "Loan No.");
            LoanTopUp.SetRange("Member No.", "Member No.");
            LoanTopUp.SetFilter("Loan Top Up", '<>%1', '');
            if LoanTopUp.FindFirst then begin
                repeat

                    LRec.Get(LoanTopUp."Loan Top Up");
                    ProductSetup.Get(LRec."Loan Product Type");

                    PSetup.Reset;
                    PSetup.SetRange("Product ID", ProductSetup."Appraisal Product");
                    if PSetup.FindFirst then begin

                        MAcc.Reset;
                        MAcc.SetRange("Member No.", "Member No.");
                        MAcc.SetRange("Product Type", PSetup."Product ID");
                        if MAcc.FindFirst then begin
                            LRec.CalcFields("Outstanding Principal");
                            LoanSecurity.Reset;
                            LoanSecurity.SetRange("Loan No.", LRec."Loan No.");
                            LoanSecurity.SetRange("Self Guarantee", true);
                            if LoanSecurity.FindFirst then
                                "Free Shares" += ROUND(LRec."Outstanding Principal" * 0.9)
                            else begin
                                if LRec."Loan Product Type" <> 'L20' then
                                    "Free Shares" += ROUND(LRec."Outstanding Principal" / LRec."Deposit Multiplier");
                            end;
                        end;
                    end;

                until LoanTopUp.Next = 0;
            end;

        end;
    end;

    procedure IsLoanSuspended(AsAt: Date) LoanIsSuspended: Boolean
    begin
        LoanIsSuspended := "Loan Suspended";
        LoanIsSuspended := ("Loan Suspension Start Date" <= AsAt) and
        ("Loan Suspension End Date" >= AsAt);
    end;

    procedure CheckLoanTopUp(LoanToBridge: Record Loans; MultipleAllowed: Boolean)
    var
        LoanBridging: Record "Appraisal Top Up";
        ErrExistingLoan: label '%1 does not Allow Multiple Running Loans. This Member has an existing Related Loan %2[%3] which needs bridging.';

    begin
        LoanBridging.RESET;
        LoanBridging.SETRANGE(LoanBridging."Member No.", Rec."Member No.");
        LoanBridging.SETRANGE(LoanBridging."Loan No.", LoanToBridge."Loan No.");
        IF NOT LoanBridging.FINDFIRST THEN
            IF NOT MultipleAllowed THEN
                ERROR(ErrExistingLoan, Rec."Loan Product Type Name", LoanToBridge."Loan No.", LoanToBridge."Loan Product Type Name");
    end;

    procedure HasSubType(): Boolean
    var
        myInt: Integer;
    begin
        ProductSubType.RESET;
        ProductSubType.SETRANGE("Loan Type", "Loan Product Type");
        ProductSubType.SETFILTER(ProductSubType."Product Sub. Type", '<>%1', ProductSubType."Product Sub. Type"::" ");
        EXIT(ProductSubType.FINDFIRST);
    end;

    local procedure PopulateSubType()
    var
        myInt: Integer;
    begin

        ProductSubType.Reset();
        ProductSubType.SetRange("Loan Type", "Loan Product Type");
        ProductSubType.SetRange("Product Sub. Type", "Product Sub Type");
        if ProductSubType.FindSet() then begin
            repeat
                if ("Requested Amount" >= ProductSubType."Minimum Loan Amount") and
                   (
                        ("Requested Amount" <= ProductSubType."Maximum Loan Amount") or
                        (ProductSubType."Maximum Loan Amount" = 0)
                   )
                then begin

                    "Annual Interest %" := ProductSubType.Interest;

                    if ProductSubType.Installement > 0 then
                        Installments := ProductSubType.Installement;

                end;
            until ProductSubType.Next() = 0;
        END;
    end;

    procedure CreateCommitteeApprovalEntries()
    var
        myInt: Integer;
        Committee: Record "Board Committees";
        BCommitteMembers: Record "Board Committee Members";
        ApprovalEntry: Record "Committee Approval Entry";
        MemberPortal: Codeunit "sACCO Portal";
        LineNo: Integer;
    begin

        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", "Loan No.");
        if ApprovalEntry.FindFirst() then begin
            repeat
                //ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                ApprovalEntry.Delete();
            until ApprovalEntry.next = 0;
        end;


        LineNo := 0;
        ApprovalEntry.Reset();
        if ApprovalEntry.Findlast() then begin
            LineNo := ApprovalEntry."Entry No.";
        end;

        Committee.Reset();
        Committee.SetCurrentKey(Code, "Approval Sequence");
        Committee.SetAscending("Approval Sequence", true);
        if Committee.FindFirst() then begin
            repeat
                BCommitteMembers.Reset();
                BCommitteMembers.SetRange(Committee, Committee.Code);
                if BCommitteMembers.findset() then
                    repeat

                        ApprovalEntry.Reset();
                        ApprovalEntry.setrange("Document No.", "Loan No.");
                        ApprovalEntry.SetRange("Approver ID", Committee.Code);
                        if ApprovalEntry.findfirst() then;

                        if ApprovalEntry.count < 2 then begin
                            LineNo += 1;
                            ApprovalEntry.Init();
                            ApprovalEntry."Entry No." := LineNo;
                            ApprovalEntry."Document No." := "Loan No.";
                            ApprovalEntry."Document Amount" := "Approved Amount";
                            ApprovalEntry."Date Created" := CurrentDateTime;
                            ApprovalEntry."Created By" := UserId;
                            ApprovalEntry."Description 1" := "Loan Product Type Name";
                            ApprovalEntry."Description 2" := "Member Name";
                            ApprovalEntry."Sender ID" := UserId;
                            ApprovalEntry."Approver ID" := Committee.Code;

                            case Committee."Approval Sequence" of
                                1:
                                    begin
                                        ApprovalEntry.status := ApprovalEntry.Status::Open;
                                        //MemberPortal.SendPortalApprovalNotifications(BCommitteMembers."Member No.", Rec);
                                    end;
                                2 .. 999:
                                    ApprovalEntry.status := ApprovalEntry.Status::Created;
                            end;

                            ApprovalEntry."Approval Sequence" := Committee."Approval Sequence";
                            ApprovalEntry.Insert(true)
                        end;

                    Until BCommitteMembers.Next() = 0;
            until Committee.next = 0;
        end;


        ApprovalEntry.Reset();
        ApprovalEntry.SetCurrentKey("Approval Sequence");
        ApprovalEntry.SetRange("Document No.", "Loan No.");
        ApprovalEntry.SetRange(status, ApprovalEntry.Status::Created);
        if ApprovalEntry.FindFirst() then begin
            //ApprovalEntry.Status := ApprovalEntry.Status::Open;
            //ApprovalEntry.Modify();
        end;
    end;

    local procedure ValidateLoanProductType()
    var
        LoanProduct: Record "Product Setup";
    begin
        if "Loan Product Type" = '' then
            exit;

        TestField("Member No.");

        if not LoanProduct.Get("Loan Product Type") then
            exit;

        // Reset fields
        ResetLoanFields();

        // Create loan account
        CreateLoanAccount();

        // Process registration fee if required
        if LoanProduct."Recover Registration Fee" then
            ProcessRegistrationFee(LoanProduct);

        // Validate member deposits
        ValidateMemberDeposits(LoanProduct);

        // Validate micro finance group if applicable
        if Source = Source::MICRO then
            ValidateMicroGroup();

        // Validate member eligibility
        ValidateMemberEligibility(LoanProduct);

        // Set loan product details
        SetLoanProductDetails(LoanProduct);

        // Check arrears if required
        if LoanProduct."Check Arrears" then
            ValidateArrears();

        // Final validations
        Validate("Disbursement Date");
        GetDisbAccount();
        GetLoanCharges();
        GetFreeShares();
        Validate("Disbursement Account No");
    end;

    local procedure ResetLoanFields()
    begin
        "Approved Amount" := 0;
        "SMS Sent" := false;
    end;

    local procedure CreateLoanAccount()
    var
        SaccoActivities: Codeunit "Sacco Activities";
    begin
        "Loan Account" := SaccoActivities.CreateCreditAccount(Rec);
    end;

    local procedure ProcessRegistrationFee(LoanProduct: Record "Product Setup")
    var
        RegFeeProduct: Record "Product Setup";
        SavingsAccount: Record "Savings Accounts";
        Member: Record Members;
        MemberActivities: Codeunit "Member Activities";
    begin
        "Registration Fee" := 0;

        // Find registration fee product
        RegFeeProduct.Reset();
        RegFeeProduct.SetRange("Product Class", RegFeeProduct."Product Class"::Savings);
        RegFeeProduct.SetRange("Product Category", RegFeeProduct."Product Category"::"Registration Fee");
        if not RegFeeProduct.FindFirst() then
            Error('Registration Fee Product is not set up in the system.');

        // Check if member has registration fee account
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", "Member No.");
        SavingsAccount.SetRange("Product Type", RegFeeProduct."Product ID");

        if not SavingsAccount.FindFirst() then begin
            // Create registration fee account
            if not Member.Get("Member No.") then
                Error('Member %1 not found.', "Member No.");

            MemberActivities.CreateSavingsAccount(
                RegFeeProduct,
                Member,
                0,
                false,
                RegFeeProduct."Repay Mode"
            );

            SavingsAccount.FindFirst();
        end;

        // Check if registration fee is required
        SavingsAccount.CalcFields("Balance (LCY)");
        if SavingsAccount."Balance (LCY)" <= 0 then
            "Registration Fee" := RegFeeProduct."Minimum Contribution";
    end;

    local procedure ValidateMemberDeposits(LoanProduct: Record "Product Setup")
    var
        Member: Record Members;
        SavingsAccount: Record "Savings Accounts";
        DepositBalance: Decimal;
    begin
        if not Member.Get("Member No.") then
            Error('Member %1 not found.', "Member No.");

        // Find member's deposit account
        SavingsAccount.Reset();
        SavingsAccount.SetRange("Member No.", "Member No.");
        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Deposit Contribution");

        if not SavingsAccount.FindFirst() then
            Error('Member does not have a deposit contribution account.');

        SavingsAccount.CalcFields("Balance (LCY)");
        DepositBalance := SavingsAccount."Balance (LCY)";

        // Validate minimum deposit requirement
        if LoanProduct."Min. Share Deposits" > 0 then begin
            if DepositBalance < LoanProduct."Min. Share Deposits" then
                Error('Member deposit balance of %1 is below the minimum required of %2.',
                      DepositBalance,
                      LoanProduct."Min. Share Deposits");
        end else begin
            if DepositBalance <= 0 then
                Error('Member does not have sufficient deposit balance. Current balance: %1', DepositBalance);
        end;
    end;

    local procedure ValidateMicroGroup()
    var
        GroupMember: Record Members;
        GroupLoan: Record Loans;
        DefaulterList: Text;
        GroupMemberCount: Integer;
    begin
        if "Group Code" = '' then
            exit;

        // Count group members
        GroupMember.Reset();
        GroupMember.SetRange("Group No.", "Group Code");
        if not GroupMember.FindFirst() then
            Error('Group %1 not found.', "Group Code");

        GroupMemberCount := GroupMember.Count;
        if GroupMemberCount < 5 then
            Error('Group must have at least 5 members. Current members: %1', GroupMemberCount);

        // Check for defaulting group members
        GroupLoan.Reset();
        GroupLoan.SetRange("Group Code", "Group Code");
        GroupLoan.SetRange(Source, GroupLoan.Source::MICRO);
        GroupLoan.SetFilter("Outstanding Principal", '>0');
        GroupLoan.SetFilter("Loans Category-SASRA", '<>%1&<>%2',
                            GroupLoan."Loans Category-SASRA"::Performing,
                            GroupLoan."Loans Category-SASRA"::Watch);

        if GroupLoan.FindSet() then begin
            repeat
                DefaulterList += StrSubstNo('- %1 - %2 - %3\',
                                            GroupLoan."Member No.",
                                            GroupLoan."Member Name",
                                            Format(GroupLoan."Loans Category-SASRA"));
            until GroupLoan.Next() = 0;

            Message('The following group members are defaulters:\%1', DefaulterList);
            if not Confirm('Do you want to send this for authorization?') then
                Error('Loan application cancelled.');
        end;
    end;

    local procedure ValidateMemberEligibility(LoanProduct: Record "Product Setup")
    var
        Member: Record Members;
        MemberAge: Integer;
        MinAge: Integer;
        MinAgeText: Text;
    begin
        if not Member.Get("Member No.") then
            Error('Member %1 not found.', "Member No.");

        case LoanProduct."Loan Clients" of
            LoanProduct."Loan Clients"::"Staff Members":
                if Member."Member Category" <> Member."Member Category"::"Staff Members" then
                    Error('This loan product is limited to staff members only.');

            LoanProduct."Loan Clients"::"Board Members":
                if Member."Member Category" <> Member."Member Category"::"Board Members" then
                    Error('This loan product is limited to board members only.');
        end;


        if (LoanProduct."Loan Application Period" <> DefaultDF) and (not Member."From Another Sacco") then begin
            if Member."Registration Date" <> 0D then begin
                if CalcDate(LoanProduct."Loan Application Period", Member."Registration Date") > Today then
                    Error('Member has not met the minimum membership period required for this loan product.');
            end;
        end;


        if (Member."Date of Birth" <> 0D) and (not Member."Group Account") then begin
            MemberAge := Date2DMY(Today, 3) - Date2DMY(Member."Date of Birth", 3);

            LoanProduct.TestField("Min. Customer Age");
            MinAgeText := DelChr(Format(LoanProduct."Min. Customer Age"), '=', 'Y');
            Evaluate(MinAge, MinAgeText);

            if MemberAge < MinAge then
                Error('Member age of %1 years is below the minimum required age of %2 years.',
                      MemberAge,
                      MinAge);
        end;
    end;

    local procedure CheckExistingLoans(LoanProduct: Record "Product Setup")
    var
        ExistingLoan: Record Loans;
        TopUp: Record "Loan Top Up";
        AppraisalTopUp: Record "Appraisal Top Up";
        ExistingLoanMessage: Text;
    begin
        ExistingLoan.Reset();
        ExistingLoan.SetRange("Member No.", "Member No.");
        ExistingLoan.SetRange(Posted, true);
        ExistingLoan.SetRange("Loan Product Type", "Loan Product Type");
        ExistingLoan.SetFilter("Outstanding Principal", '>0');
        if "Loan No." <> '' then
            ExistingLoan.SetFilter("Loan No.", '<>%1', "Loan No.");

        if ExistingLoan.FindSet() then begin
            repeat
                if LoanProduct."Allow Multiple Running Loans" then begin
                    ExistingLoanMessage := StrSubstNo(
                        'Member already has an existing loan %1 of the same product.',
                        ExistingLoan."Loan No."
                    );
                end else begin
                    TopUp.Reset();
                    TopUp.SetRange("Loan No.", "Loan No.");
                    TopUp.SetRange("Member No.", "Member No.");
                    TopUp.SetRange("Loan Top Up", ExistingLoan."Loan No.");
                    TopUp.SetFilter("Total Top Up", '>0');
                    if not TopUp.FindFirst() then begin

                        AppraisalTopUp.Reset();
                        AppraisalTopUp.SetRange("Loan No.", "Loan No.");
                        AppraisalTopUp.SetRange("Member No.", "Member No.");
                        AppraisalTopUp.SetRange("Loan Top Up", ExistingLoan."Loan No.");
                        AppraisalTopUp.SetFilter("Total Top Up", '>0');
                        if not AppraisalTopUp.FindFirst() then
                            Error(
                                '%1 does not allow multiple running loans. Member %2 already has running loan %3 (%4). Bridge/top up the existing loan before proceeding.',
                                LoanProduct.Description,
                                "Member No.",
                                ExistingLoan."Loan No.",
                                ExistingLoan."Loan Product Type Name");
                    end;

                    ExistingLoanMessage := StrSubstNo(
                        'Member already has an existing loan %1 of the same product, and it has been selected for bridging.',
                        ExistingLoan."Loan No.");
                end;

                if "Loan Product Type" <> 'L43' then
                    Message(ExistingLoanMessage);

            until ExistingLoan.Next() = 0;
        end;
    end;

    procedure CheckMultipleRunningLoanAllowed()
    var
        LoanProduct: Record "Product Setup";
    begin
        if ("Member No." = '') or ("Loan Product Type" = '') then
            exit;

        if LoanProduct.Get("Loan Product Type") then
            CheckExistingLoans(LoanProduct);
    end;

    local procedure SetLoanProductDetails(LoanProduct: Record "Product Setup")
    begin
        LoanProduct.TestField("Global Dimension 1 Code");

        "Loan Product Type Name" := LoanProduct.Description;
        "Annual Interest %" := LoanProduct."Interest Rate (Min.)";
        "Deposit Multiplier" := LoanProduct."Deposit Multiplier";
        "Interest Calculation Method" := LoanProduct."Interest Calculation Method";
        Source := LoanProduct."Loan Source";

        if LoanProduct."Use Tiered Debt Threshold" then
            Installments := GetTieredInstallments(LoanProduct."Product ID", "Approved Amount")
        else
            Installments := LoanProduct."Default Installments";

        "Repayment Frequency" := LoanProduct."Repayment Frequency";
        "Repay Mode" := LoanProduct."Repay Mode";
        "Global Dimension 1 Code" := LoanProduct."Global Dimension 1 Code";
        "Recovery Priority" := LoanProduct."Recovery Priority";

        if "Approved Amount" > 0 then
            Validate(Installments);
    end;

    local procedure ValidateArrears()
    var
        LoanWithArrears: Record Loans;
        TotalArrears: Decimal;
    begin
        TotalArrears := 0;

        LoanWithArrears.Reset();
        LoanWithArrears.SetRange("Member No.", "Member No.");
        LoanWithArrears.SetRange(Posted, true);
        LoanWithArrears.SetFilter("Principal Arrears", '>0');

        if LoanWithArrears.FindSet() then begin
            repeat
                LoanWithArrears.CalcFields("Total Arrears");
                TotalArrears += LoanWithArrears."Total Arrears";
            until LoanWithArrears.Next() = 0;
        end;

        if TotalArrears > 10 then
            Error('Member has total arrears of %1. Loan application cannot proceed.', TotalArrears);
    end;

    procedure GetTieredInstallments(ProductCode: Code[20]; LoanAmount: Decimal): Integer
    var
        InstallmentTier: Record "Tiered Debt Threshold";

    begin
        if LoanAmount = 0 then
            exit(0);

        InstallmentTier.Reset();
        InstallmentTier.SetRange("Loan Product", ProductCode);
        InstallmentTier.SetFilter("Lower Limit", '<=%1', LoanAmount);
        InstallmentTier.SetFilter("Upper Limit", '>=%1|%2', LoanAmount, 0);
        if InstallmentTier.FindFirst() then
            exit(InstallmentTier."Maximum Loan Term")
        else begin

            InstallmentTier.Reset();
            InstallmentTier.SetRange("Loan Product", ProductCode);
            InstallmentTier.SetCurrentKey("Loan Product", "Lower Limit");
            InstallmentTier.Ascending := false;
            if InstallmentTier.FindFirst() then
                exit(InstallmentTier."Maximum Loan Term");

            Error('No installment tier found for loan amount %1 in product %2.', LoanAmount, ProductCode);
        end;
    end;


    local procedure CalculateLoanRepayments(LoanAmount: Decimal)
    var
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
    begin
        TotalMRepay := 0;
        LPrincipal := 0;
        LInterest := 0;
        InterestRate := "Annual Interest %";
        RepayPeriod := Installments;
        LBalance := LoanAmount;

        if InterestRate > 0 then begin
            case "Interest Calculation Method" of
                "Interest Calculation Method"::Amortised:
                    begin
                        TestField("Annual Interest %");
                        TestField(Installments);

                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := SaccoActivities.SmartRound(LBalance / 100 / 12 * InterestRate);

                        Repayment := TotalMRepay;
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        Repayment := TotalMRepay;
                    end;

                "Interest Calculation Method"::"Straight Line":
                    begin
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := SaccoActivities.SmartRound((InterestRate / 12 / 100) * LoanAmount);
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                "Interest Calculation Method"::"Reducing Balance":
                    begin
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := SaccoActivities.SmartRound((InterestRate / 12 / 100) * LBalance);
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                "Interest Calculation Method"::"Reducing Flat":
                    begin
                        TestField(Installments);
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                        LInterest := SaccoActivities.SmartRound(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2);
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;
            end;
        end else begin
            LPrincipal := LoanAmount / RepayPeriod;
            Repayment := LPrincipal;
            "Loan Principle Repayment" := LPrincipal;
        end;

        // Handle single installment with upfront interest
        if Installments = 1 then begin
            if LoanType.Get("Loan Product Type") then
                if LoanType."Interest Recovered Upfront" then
                    Repayment := "Loan Principle Repayment";
        end;

        // Round values
        "Loan Interest Repayment" := Round(LInterest, 1, '>');
        "Principal Repayment" := Round(LPrincipal, 1, '>');
        "Loan Principle Repayment" := Round(LPrincipal, 1, '>');

        // Calculate final repayment
        Repayment := "Loan Interest Repayment" + "Principal Repayment";
    end;


    local procedure GetNextLineNo(LoanNo: Code[20]): Integer
    var
        BankAcc: Record "HR Employee Bank Accounts";
    begin
        BankAcc.Reset();
        BankAcc.SetRange("Loan No.", LoanNo);
        if BankAcc.FindLast() then
            exit(BankAcc."Line No." + 10000)
        else
            exit(10000);
    end;


}

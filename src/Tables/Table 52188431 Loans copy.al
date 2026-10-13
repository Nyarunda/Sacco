
Table 50378 "Legacy Loans"
{

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
            TableRelation = if (Source = const(BOSA)) "Product Setup"."Product ID" where("Loan Source" = filter(BOSA | FOSA | MICRO),
                                                                                        "Product Class" = const(Credit));

            trigger OnValidate()
            var
                AccNo: Code[20];
                MAcc: Record "Savings Accounts";
                DepAmt: Decimal;
                GuaranteedInApplication: Decimal;
                Committed: Decimal;
                Available: Decimal;
                PSetup: Record "Product Setup";
            begin
                "Approved Amount" := 0;
                "SMS Sent" := false;



                TestField("Member No.");

                if LoanType.Get("Loan Product Type") then begin
                    "Registration Fee" := 0;

                    if LoanType."Recover Registration Fee" then begin
                        ProductSetup.Reset;
                        ProductSetup.SetRange("Product Class", ProductSetup."product class"::Savings);
                        ProductSetup.SetRange("Product Category", ProductSetup."product category"::"Registration Fee");
                        if ProductSetup.FindFirst then begin
                            SavAcc.Reset;
                            SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                            SavAcc.SetFilter("Product Type", ProductSetup."Product ID");
                            if not SavAcc.Find('-') then begin
                                Members.Get("Member No.");
                                MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, false, ProductSetup."Repay Mode");
                            end;

                            SavAcc.Reset;
                            SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                            SavAcc.SetFilter("Product Type", ProductSetup."Product ID");
                            SavAcc.SetFilter("Balance (LCY)", '<=0');
                            if SavAcc.Find('-') then begin
                                "Registration Fee" := ProductSetup."Minimum Contribution";
                            end
                            else
                                Error('Member Does not have a registration fee Account');
                        end
                        else
                            Error('Registration Fee Product Not Set Up');
                    end;


                    AccNo := '';
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", "Member No.");
                    SavAcc.SetFilter(SavAcc."Product Category", '%1|%2', SavAcc."product category"::"Deposit Contribution", SavAcc."product category"::"Micro Member Deposit");
                    if SavAcc.Find('-') then begin
                        repeat
                            AccNo := SavAcc."No.";
                        until SavAcc.Next = 0;
                    end;

                    if Source = Source::MICRO then begin
                        if "Group Code" <> '' then begin
                            Cust.Reset;
                            Cust.SetRange("Group No.", "Group Code");
                            if Cust.FindFirst then begin
                                if Cust.Count + 1 < 5 then
                                    Error('Group Members Must be More than 5');

                                Loan.Reset;
                                Loan.SetRange("Group Code", "Group Code");
                                Loan.SetFilter("Outstanding Principal", '>0');
                                Loan.SetRange(Source, Loan.Source::MICRO);
                                Loan.SetFilter("Loans Category-SASRA", '<>%1&<>%2', Loan."loans category-sasra"::Performing, Loan."loans category-sasra"::Watch);
                                if Loan.Find('-') then begin
                                    repeat
                                        MicroDef += '\ - ' + Loan."Member No." + ' - ' + Loan."Member Name" + '-' + Format(Loan."Loans Category-SASRA");
                                    until Loan.Next = 0;
                                end;

                            end;
                        end;

                        if MicroDef <> '' then begin
                            Message('The following Group Members are Defaulters: \' + MicroDef);
                            if not Confirm('Do you want to send this for Authorization?') then
                                Error('Cancelled');
                        end;

                    end;



                    Members.Get("Member No.");
                    if LoanType."Loan Clients" <> LoanType."loan clients"::Member then begin
                        if LoanType."Loan Clients" = LoanType."loan clients"::"Staff Members" then
                            if Members."Member Category" <> Members."member category"::"Staff Members" then
                                Error('This Loan is Limited to STAFF only');

                        if LoanType."Loan Clients" = LoanType."loan clients"::"Board Members" then
                            if Members."Member Category" <> Members."member category"::"Board Members" then
                                Error('This Loan is Limited to Board Members only');


                        if LoanType."Loan Application Period" <> DefaultDF then begin
                            if not Members."From Another Sacco" then
                                If Members."Registration Date" <> 0D then begin
                                    if CalcDate(LoanType."Loan Application Period", Members."Registration Date") > Today then begin
                                        Error('Minimum Membership Period not achieved to apply this loan');
                                    end;
                                end;
                        end;

                    end;

                    LoanType.TestField("Global Dimension 1 Code");
                    "Global Dimension 1 Code" := LoanType."Global Dimension 1 Code";



                    TestField("Member No.");
                    GenSetup.Get();



                    //Get age of the client
                    if Cust.Get("Member No.") then begin
                        //if from another sacco
                        //Cust.TESTFIELD(Cust."Date of Birth");
                        if Cust."Date of Birth" <> 0D then begin
                            if Cust."Group Account" = false then begin


                                ClientAgeValue := Date2dmy(Today, 3) - Date2dmy(Cust."Date of Birth", 3);
                                LoanType.TestField(LoanType."Min. Customer Age");
                                ProdMinAgeText := DelChr(Format(LoanType."Min. Customer Age"), '=', 'Y');

                                Evaluate(ProdMinAge, ProdMinAgeText);
                            end;


                            if ProdMinAge > ClientAgeValue then
                                Error(Text005, LoanType."Min. Customer Age");

                        end;

                    end;

                    //confirm if loan exist of same type
                    LoanApp.Reset;
                    LoanApp.SetRange("Member No.", "Member No.");
                    LoanApp.SetRange(Posted, true);
                    LoanApp.SetRange("Loan Product Type", "Loan Product Type");
                    LoanApp.SetFilter("Outstanding Principal", '>0');
                    if LoanApp.Find('-') then begin
                        repeat
                            if LoanType.Get("Loan Product Type") then begin
                                if LoanType."Allow Multiple Running Loans" = false then
                                    Message('Member already has an existing Loan %1 of same product which needs bridging', LoanApp."Loan No.")
                                else
                                    Message('Member already has an existing Loan %1 of same product', LoanApp."Loan No.");
                            end;
                        until LoanApp.Next = 0;
                    end;



                    "Loan Product Type Name" := LoanType.Description;
                    "Annual Interest %" := LoanType."Interest Rate (Min.)";
                    "Deposit Multiplier" := LoanType."Deposit Multiplier";
                    "Interest Calculation Method" := LoanType."Interest Calculation Method";
                    Source := LoanType."Loan Source";

                    Installments := LoanType."Default Installments";
                    "Repayment Frequency" := LoanType."Repayment Frequency";
                    "Repay Mode" := LoanType."Repay Mode";


                    //Revalidate installments
                    if "Approved Amount" > 0 then
                        Validate(Installments);


                    Validate("Disbursement Date");
                    GetDisbAccount;
                end;


                GetLoanCharges;
                GetFreeShares;
            end;
        }
        field(4; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            var
                Groups: Record Customer;
            begin

                "SMS Sent" := false;

                if "Loan No." <> '' then
                    ClearLoanDetails;



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

                    if Unpaid <> '' then
                        Message(Text003 + Unpaid);

                    if LArrears <> '' then
                        Message(Text004 + LArrears);

                end;

                if Cust.Get("Member No.") then begin

                    if Cust."Member Status" <> Cust."Member Status"::Active then
                        if Confirm('This member is not active. Do you wish to continue with application ?', true) = false then
                            Error("InactiveErr:");

                    "Staff No" := Cust."Payroll/Staff No.";
                    "Member Name" := Cust.Name;
                    "Application Date" := Today;
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
                    // "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    //"Global Dimension 2 Code":=Cust."Global Dimension 2 Code";
                    if Cust."ID No." = '' then
                        Message('Kindly update the ID No for this member before proceeding');

                end
                else
                    Error('Member does not exist');

                if ("Member No." <> '') and ("Member No." <> xRec."Member No.") then begin
                    "Disbursement Account No" := '';
                end;


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
                    "Application Date" := Today;

                    //Check maximum and minimum loan amounts

                    if LoanType.Get("Loan Product Type") then begin

                        if (LoanType."Nature of Loan Type" = LoanType."nature of loan type"::Normal) then begin
                            if "Requested Amount" > 0 then
                                if ("Requested Amount" > LoanType."Maximum Loan Amount") or ("Requested Amount" < LoanType."Minimum Loan Amount") then
                                    Error(LoanAmountErr, LoanType."Minimum Loan Amount", LoanType."Maximum Loan Amount", "Loan Product Type", "Requested Amount");
                        end;
                    end;
                end;
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

                "Amount To Disburse" := "Approved Amount";

                //
                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := "Annual Interest %";
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";

                if InterestRate > 0 then begin
                    if "Interest Calculation Method" = "interest calculation method"::Amortised then begin
                        TestField("Annual Interest %");
                        TestField(Installments);

                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                        Repayment := TotalMRepay;
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        Repayment := TotalMRepay;

                    end;

                    if "Interest Calculation Method" = "interest calculation method"::"Straight Line" then begin
                        TestField(Installments);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    if "Interest Calculation Method" = "interest calculation method"::"Reducing Balance" then begin
                        TestField(Installments);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    if "Interest Calculation Method" = "interest calculation method"::"Reducing Flat" then begin
                        TestField(Installments);
                        //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1.0, '>');
                        //AmortisedInt:=TotalMRepay*Installments-"Approved Amount";
                        LInterest := ROUND(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                        //LInterest:=AmortisedInt/Installments;
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;
                end else begin
                    LPrincipal := LoanAmount / RepayPeriod;
                    Repayment := LPrincipal;
                end;




                if Installments = 1 then begin
                    if LoanType."Interest Recovered Upfront" then begin

                        "Repayment" := "Loan Principle Repayment";

                    end;
                end;

                //UpdateLoanCharges;
                GetLoanCharges();
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

                //Control
                if LoanType.Get("Loan Product Type") then begin
                    if Installments > LoanType."Default Installments" then
                        Error(Text006);
                end;

                IF "Approved Amount" > 0 THEN
                    VALIDATE("Approved Amount");



            end;
        }
        field(11; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

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



                "Schedule Start Date" := "Repayment Start Date";
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
            end;
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
                                                                        "Amount (LCY)" = filter(<> 0)));
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
            TableRelation = if ("Mode of Disbursement" = const("Transfer to Fosa")) Vendor."No." where("Member No." = field("Member No."),
                                                                                                                 "Product Category" = filter("Ordinary Savings" | Business))
            else
            if ("Mode of Disbursement" = filter("Cheque/EFT" | "M-Pesa")) "Bank Account"."No.";

            trigger OnValidate()
            begin

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
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
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
            OptionCaption = 'Open,Pending,Approved,Rejected,Deffered';
            OptionMembers = Open,Pending,Approved,Rejected,Deffered;

            trigger OnValidate()
            var
                portalLoans: Record "Portal Loans";
            begin

                LoanType.Get("Loan Product Type");


                IF Status = Status::Approved THEN BEGIN

                    IF Appraisal.GET("Loan No.") THEN BEGIN
                        IF Appraisal."Net Take Home" < 0 THEN
                            ERROR('Net take home Cannot be less than Zero');
                    END;

                    /* IF Cust.GET("Member No.") THEN BEGIN
                        MemberActivities.SendSms(SourceType::"Loan Approval", Cust."Mobile Phone No.", 'Your ' + "Loan Product Type Name" + ' of KES ' + FORMAT("Approved Amount") + ' ' +
                        'has been Approved', "Loan No.", "Disbursement Account No", TRUE, FALSE);
                    END; */

                    portalLoans.Reset();
                    ;
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
        field(52; "Loan Rejection Reason"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Recommended Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
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
            TableRelation = Customer where("Account Type" = const(Employer));
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
            OptionCaption = ' ,Transfer to Fosa,Cheque/EFT,M-Pesa';
            OptionMembers = " ","Transfer to Fosa","Cheque/EFT","M-Pesa";

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
        field(83; "Purpose of Loan"; Code[20])
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
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Deposit Boosting" >= "Approved Amount" then
                    Error('This amount should be less than the approved amount %1', "Approved Amount");

                //UpdateLoanCharges();
                GetLoanCharges();
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

                //UpdateLoanCharges();
                GetLoanCharges();
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
                                                                        "Transaction Type" = filter("Principal Repayment" | "Interest Paid" | "Penalty Paid" | "Appraisal Paid"),
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
                                                                        "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment" | "Interest Due" | "Interest Paid" | "Penalty Due" | "Penalty Paid" | "Appraisal Due" | "Appraisal Paid"),
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
            begin
                if "Schedule Start Date" < "Repayment Start Date" then
                    Error('Schedule Start Date cannot be less than repayment start date');

                if "Repayment Frequency" = "repayment frequency"::Monthly then begin
                    if "Schedule Start Date" > CalcDate('1M+CM', "Disbursement Date") then
                        Error('Start Date cannot be greater than %1', CalcDate('1M+CM', "Disbursement Date"));
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
        field(116; "Special Account"; Boolean)
        {
            CalcFormula = lookup(Members."Special Account" where("No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(117; "Cheque No."; Code[6])
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
            CalcFormula = lookup("SACCO Categorization"."Total Arrears" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(128; "SASRA Arrears"; Decimal)
        {
            CalcFormula = lookup("Sasra Categorization"."Total Arrears" where("Loan No." = field("Loan No.")));
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
            CalcFormula = lookup("SACCO Categorization"."Principal Arrears" where("Loan No." = field("Loan No.")));
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
            OptionMembers = " ","1","2";
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
            Editable = false;
        }
        field(165; "Bank Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(166; "Bank Branch"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(167; "Bank Account No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
                if "Standing Order Amount" > 0 then
                    TestField("Repay Mode", "Repay Mode"::"Internal Standing Order");
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
            begin

                "Requested Amount" := 0;
                "Approved Amount" := 0;
                "Recommended Amount" := 0;
                Installments := 0;
                "Relationship Officer" := '';
                if Appraisal.Get("Salary Appraisal No.") then begin
                    Validate("Loan Product Type", Appraisal."Loan Product Type");

                    "Requested Amount" := Appraisal."Requested Amount";
                    "Approved Amount" := Appraisal."Recommended Amount";
                    Installments := Appraisal.Period;
                    "Relationship Officer" := Appraisal."Captured By";
                    Validate("Approved Amount");

                    Clearance.Reset();
                    Clearance.SetRange("Loan Application No.", "Loan No.");
                    if Clearance.FindFirst() then
                        Clearance.DeleteAll();

                    NewTopUp.Reset();
                    NewTopUp.SetRange("Loan No.", "Loan No.");
                    if NewTopUp.FindFirst() then
                        NewTopUp.DeleteAll();


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
                            NewTopUp.Type := NewTopUp.Type::"Top Up";
                            NewTopUp.Validate("Loan No.", "Loan No.");
                            NewTopUp.Validate("Member No.", "Member No.");
                            NewTopUp.Validate("Loan Top Up", TopUp."Loan Top Up");
                            NewTopUp.Insert();

                        until TopUp.Next() = 0;
                    end;

                end;
            end;
        }


        field(182; "Debt Collector Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Walk In",Marketer,Staff,"Board Member",Member,Website;
        }

        field(183; "Debt Collector Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(184; "Debt Collector"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Debt Collector Type" = const(Marketer)) "Salesperson/Purchaser"
            else
            if ("Debt Collector Type" = const(Staff)) Employee
            else
            if ("Debt Collector Type" = const("Board Member")) Members where("Member Category" = const("Board Members"))
            else
            if ("Debt Collector Type" = const(Member)) Members where("Member Category" = const(Member));

            trigger OnValidate()
            begin
                "Debt Collector Name" := '';

                if "Debt Collector Type" = "Debt Collector Type"::Marketer then begin
                    SalespersonPurchaser.Reset;
                    SalespersonPurchaser.SetRange(Code, "Debt Collector");
                    if SalespersonPurchaser.Find('-') then begin
                        "Debt Collector Name" := SalespersonPurchaser.Name;
                    end;
                end
                else
                    if "Debt Collector Type" = "Debt Collector Type"::"Board Member" then begin
                        Members.Reset;
                        Members.SetRange("No.", "Debt Collector");
                        if Members.Find('-') then begin
                            "Debt Collector Name" := Members.Name;
                        end;
                    end
                    else
                        if "Debt Collector Type" = "Debt Collector Type"::Staff then begin
                            HREmployees.Reset;
                            HREmployees.SetRange("No.", "Debt Collector");
                            if HREmployees.Find('-') then begin
                                "Debt Collector Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                            end;
                        end
                        else
                            if "Debt Collector Type" = "Debt Collector Type"::Member then begin
                                Members.Reset;
                                Members.SetRange("No.", "Debt Collector");
                                if Members.Find('-') then begin
                                    "Debt Collector Name" := Members.Name;
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
        field(195; "Legacy"; Boolean)
        {
            DataClassification = ToBeClassified;

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

            NSetup.Get;
            NSetup.TestField("Loan Nos.");
            "Loan No." := NoSeries.GetNextNo(NSetup."Loan Nos.", WorkDate(), true);

        end;



        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");
        "Application Date" := Today;
        "Booking Branch" := UserSetup."Global Dimension 2 Code";
        "Captured By" := UserId;
    end;

    var
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
        GenSetup: Record "Sacco Setup";
        LoanApp: Record Loans;
        SavingsProduct: Record "Product Setup";
        Appraisal: Record "Loan Appraisal";
        HREmployees: Record Employee;
        GenJournalLine: Record "Gen. Journal Line";
        LoanCharges: Record "Loan Charges";
        SalaryDetails: Record "Appraisal Salary Details";
        LoanSecurity: Record "Loan Security";
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


            SalaryDetails.Reset;
            SalaryDetails.SetRange("Loan No", "Loan No.");
            if SalaryDetails.FindFirst then
                SalaryDetails.DeleteAll;
            UploadSalaryDetails;


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

            "Application Date" := Today;
            "Disbursement Date" := 0D;
            "Repayment Start Date" := 0D;
            "Schedule Start Date" := 0D;
            "Loan Product Type" := '';


        end;

    end;


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
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
            if PCharges.Find('-') then begin
                repeat
                    PChAmt := 0;
                    GL := '';
                    EDuty := 0;
                    MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", "Approved Amount", PChAmt, EDuty, GL);

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

                until PCharges.Next = 0;
            end;


            Members.get("Member No.");
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
            PCharges.Setfilter(PCharges."Charge Type", '%1|%2', PCharges."charge type"::Insurance, PCharges."charge type"::Non_Individual);
            if Members."Member Category" <> Members."Member Category"::"Staff Members" then
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

                        Value := "Approved Amount";

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

                            if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                                PChAmt := PChAmt * Installments / 10;


                            //Message('PCharges."Charge Type" %1 \ PCHamt %2', PCharges."Charge Type", PChAmt);

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

    local procedure UploadSalaryDetails()
    begin

        SalaryDetails.Init;
        SalaryDetails."Loan No" := "Loan No.";
        SalaryDetails.Type := SalaryDetails.Type::Basic;
        SalaryDetails.Description := Format(SalaryDetails.Type);
        SalaryDetails.Amount := 0;
        SalaryDetails.Insert;

        SalaryDetails.Init;
        SalaryDetails."Loan No" := "Loan No.";
        SalaryDetails.Type := SalaryDetails.Type::"House Allowance";
        SalaryDetails.Description := Format(SalaryDetails.Type);
        SalaryDetails.Amount := 0;
        SalaryDetails.Insert;

        SalaryDetails.Init;
        SalaryDetails."Loan No" := "Loan No.";
        SalaryDetails.Type := SalaryDetails.Type::"Commuter Allowance";
        SalaryDetails.Description := Format(SalaryDetails.Type);
        SalaryDetails.Amount := 0;
        SalaryDetails.Insert;

        SalaryDetails.Init;
        SalaryDetails."Loan No" := "Loan No.";
        SalaryDetails.Type := SalaryDetails.Type::"Other Allowances";
        SalaryDetails.Description := Format(SalaryDetails.Type);
        SalaryDetails.Amount := 0;
        SalaryDetails.Insert;


        SalaryDetails.Init;
        SalaryDetails."Loan No" := "Loan No.";
        SalaryDetails.Type := SalaryDetails.Type::"Bosa Deductions";
        SalaryDetails.Description := Format(SalaryDetails.Type);
        SalaryDetails.Amount := 0;
        SalaryDetails.Insert;
    end;


    procedure GetDisbAccount()
    begin
        Validate("Disbursement Account No", '');
        if "Mode of Disbursement" = "mode of disbursement"::"Transfer to Fosa" then begin
            LoanType.Get("Loan Product Type");
            DisbProducts.Reset;
            //DisbProducts.SetRange("Product ID", LoanType."Disbursement Product");
            DisbProducts.SetRange("Product Category", DisbProducts."product category"::"Ordinary Savings");
            if DisbProducts.FindFirst then begin

                Cust.Get("Member No.");
                /*
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", "Member No.");
                SavAcc.SetRange("Product Type", DisbProducts."Product ID");
                if not SavAcc.Find('-') then
                    MemberActivities.CreateSavingsAccount(DisbProducts, Cust, 0, false, ProductSetup."Repay Mode");
                    */



                SavAcc.Reset;
                SavAcc.SetRange("Member No.", "Member No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Ordinary Savings");
                if SavAcc.Find('-') then begin
                    if SavAcc.Count = 1 then
                        Validate("Disbursement Account No", SavAcc."No.")
                end
                else
                    Message('This member does not have a %1 loan disbursement savings account', DisbProducts."Product ID");

            end;
        end
    end;


    procedure UpdateLoanCharges()
    var
        PCharges: Record "Loan Product Charges.";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
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
                        MemberActivities.GetLoanChargeAmount("Loan Product Type", LoanCharges."Charge Code", 0, "Approved Amount", PChAmt, EDuty, GL);

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
                            else
                                "Free Shares" += ROUND(LRec."Outstanding Principal" / LRec."Deposit Multiplier");
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
}


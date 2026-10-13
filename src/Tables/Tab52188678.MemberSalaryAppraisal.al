table 50341 "Member Salary Appraisal"
{
    Caption = 'Member Salary Appraisal';
    DataClassification = ToBeClassified;
    LookupPageId = "Loan Appraisal List";
    DrillDownPageId = "Loan Appraisal List";

    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(3; "Last Modified By"; Code[20])
        {
            Caption = 'Last Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(5; "House Allowance"; Decimal)
        {
            Caption = 'House Allowance';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(6; "Commuter Allowance"; Decimal)
        {
            Caption = 'Commuter Allowance';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(7; "Other Allowances"; Decimal)
        {
            Caption = 'Other Allowances';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(8; "Gross Pay"; Decimal)
        {
            Caption = 'Gross Pay';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(9; Tax; Decimal)
        {
            Caption = 'Tax';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "BOSA Loans"; Decimal)
        {
            Caption = 'BOSA Loans';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(11; Pension; Decimal)
        {
            Caption = 'Pension';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(12; NHIF; Decimal)
        {
            Caption = 'SHA';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(13; NSSF; Decimal)
        {
            Caption = 'NSSF';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(14; "BOSA Savings"; Decimal)
        {
            Caption = 'BOSA Savings';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "BOSA Savings Manually Set" := true;
                GetValues();
            end;
        }
        field(15; "Other Deductions"; Decimal)
        {
            Caption = 'Other Deductions';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(16; "1/3 of Gross Pay"; Decimal)
        {
            Caption = '1/3 of Basic Pay';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "External Clearance"; Decimal)
        {
            Caption = 'External Clearance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "External Clearance Charges"; Decimal)
        {
            Caption = 'External Clearance Charges';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Top Up Loan"; Decimal)
        {
            Caption = 'Top Up Loan';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Top Up Commission"; Decimal)
        {
            Caption = 'Top Up Commission';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Upfront Interest"; Decimal)
        {
            Caption = 'Upfront Interest';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; Insurance; Decimal)
        {
            Caption = 'Insurance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "FOSA Loans"; Decimal)
        {
            Caption = 'FOSA Loans';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(24; STO; Decimal)
        {
            Caption = 'STO';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Net Salary"; Decimal)
        {
            Caption = 'Net Salary';
            DataClassification = ToBeClassified;
        }
        field(26; "Percentage of Net Salary"; Decimal)
        {
            Caption = 'Percentage of Net Salary';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "BOSA Loan To Run At"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Member Category"; Code[20])
        {
            Caption = 'Member Category';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; Qualification; Decimal)
        {
            Caption = 'Qualification';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; Period; Integer)
        {
            Caption = 'Period';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(31; "Monthly Repayment"; Decimal)
        {

            Caption = 'Monthly Repayment';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Principal Repayment"; Decimal)
        {
            Caption = 'Principal Repayment';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Interest Repayment"; Decimal)
        {
            Caption = 'Interest Repayment';
            DataClassification = ToBeClassified;
            Editable = false;
        }


        field(34; "To Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(35; "Max. Monthly Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Net Salary After Fosa Ded"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Recommended Loan Product Type';
            TableRelation = "Product Setup" where("Product Class" = const(credit), status = const(Active));

            trigger OnValidate()
            var
                LoanType: Record "Product Setup";
                MAcc: Record "Savings Accounts";
                DepAmt: Decimal;
                GuaranteedInApplication: Decimal;
                Committed: Decimal;
                Available: Decimal;
                LRec: Record Loans;
                ExistingLoan: Record Loans;
            begin

                Multiplier := 0;
                CheckIncompleteSameProductAppraisal();

                if LoanType.Get(Rec."Loan Product Type") then begin
                    Rec."Product Description" := LoanType.Description;
                    "Annual Interest %" := LoanType."Interest Rate (Max.)";


                    if LoanType."Use Tiered Debt Threshold" then begin
                        Period := LRec.GetTieredInstallments(LoanType."Product ID", "Requested Amount");
                        if Period = 0 then
                            Period := LoanType."Default Installments";
                        Validate(Period);
                    end else
                        Period := LoanType."Default Installments";

                    if Multiplier = 0 then
                        Multiplier := LoanType."Deposit Multiplier";

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
                            end
                            else
                                Error('Member Does not have a registration fee Account');
                        end
                        else
                            Error('Registration Fee Product Not Set Up');
                    end;

                    if Cust.get("Member No.") then begin

                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", Cust."No.");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Deposit Contribution");
                        if SavAcc.FindFirst then begin
                            SavAcc.CalcFields("Balance (LCY)");
                            if SavAcc."Balance (LCY)" <= 0 then
                                Error('Member does not have deposit balance %1', SavAcc."Balance (LCY)");

                            if (LoanType."Min. Share Deposits" > 0) and (SavAcc."Balance (LCY)" < LoanType."Min. Share Deposits") then
                                Error('Member deposit balance %1 is below the minimum required deposits %2', SavAcc."Balance (LCY)", LoanType."Min. Share Deposits");
                        end else
                            Error('Member does not have a deposit contribution account');

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

                    if LoanType."Loan Source" = LoanType."Loan Source"::MICRO then begin
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
                    //if LoanType."Loan Clients" <> LoanType."loan clients"::Members then begin
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
                        // end;

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

                    ExistingLoan.Reset();
                    ExistingLoan.SetRange("Member No.", "Member No.");
                    ExistingLoan.SetRange(Posted, true);
                    ExistingLoan.SetRange("Loan Product Type", "Loan Product Type");
                    ExistingLoan.SetFilter("Outstanding Principal", '>0');
                    if ExistingLoan.FindSet() then
                        Message('Member already has an existing Loan %1 of same product', ExistingLoan."Loan No.");


                    "Annual Interest %" := LoanType."Interest Rate (Min.)";
                    "Deposit Multiplier" := LoanType."Deposit Multiplier";
                    "Repay Mode" := LoanType."Repay Mode";


                    if LoanType."Check Arrears" then begin
                        //arrears
                        Loan.Reset;
                        Loan.SetRange("Member No.", "Member No.");
                        Loan.SetRange(Posted, true);
                        Loan.SetFilter("Total Arrears", '>0');
                        if Loan.Find('-') then
                            repeat
                                Loan.CalcFields("Total Arrears");
                                TTotalArrears += Loan."Total Arrears";
                            until Loan.Next() = 0;

                        if TTotalArrears > 0 then
                            Message('You have total arrears of %1', TTotalArrears);
                    end;
                end;

                //GetLoanCharges;
                //GetFreeShares;
                UpdateShareCapitalBandRequirement();
                GetValues();
            end;


        }
        field(38; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
                LRec: record Loans;
            begin
                LoanType.Get("Loan Product Type");
                if "Requested Amount" > LoanType."Maximum Loan Amount" then
                    Error('Requested amount exeeds the maximum loan limit');

                if "Requested Amount" < LoanType."Minimum Loan Amount" then
                    Error('Requested amount cannot be less then minimum loan limit');



                if LoanType."Use Tiered Debt Threshold" then begin
                    Period := LRec.GetTieredInstallments(LoanType."Product ID", "Requested Amount");
                    Validate(Period);
                end else
                    Period := LoanType."Default Installments";

                // Re-evaluate sub type terms when amount changes.
                PopulateSubType();

                UpdateShareCapitalBandRequirement();
                GetValues();
            end;
        }
        field(39; "Total Charges"; Decimal)
        {
            //DataClassification = ToBeClassified;
            CalcFormula = sum("Loan Charges"."Total Charge" where("Loan No." = field("Appraisal No.")));
            FieldClass = FlowField;
        }

        field(40; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = ToBeClassified;
            //TableRelation = Members;
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                Name := '';
                Members.Reset();
                Members.SetRange("Payroll/Staff No.", "Staff No.");
                if Members.FindFirst() then begin
                    Name := Members.Name;
                    "Member No." := Members."No."
                end;



                if Members."Member Category" = Members."Member Category"::"Staff Members" then begin

                    "Member Type" := "Member Type"::Staff;
                    if "Appraisal Type" <> "Appraisal Type"::Business then
                        "Appraisal Type" := "Appraisal Type"::Staff;
                end
                else
                    "Member Type" := "Member Type"::Member;




            end;
        }
        field(41; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()
            var
                Members: Record Members;
                SaccoSetup: Record "Sacco Setup";
                LoanSecurity: Record "Loan Security";
                Legacy: Codeunit Legacy;
                DepositAccountNo: Code[20];
                Savings: Record "Savings Accounts";
            begin
                Name := '';
                if Members.get(Rec."Member No.") then begin
                    if Members."Member Status" <> Members."Member Status"::Active then
                        Error('Only Active members can apply for a Loan.');
                    Name := Members.Name;
                    "Staff No." := Members."Payroll/Staff No.";
                    "ID Number" := Members."ID No.";
                    "KRA PIN" := Members."KRA PIN";
                    "P.O. Box" := Members."Address";
                    "Post Code" := Members."Post Code";
                    Town := Members.City;

                    "Mobile No." := Members."Mobile Phone No.";
                    "Alternate Mobile No." := Members."Phone No.";
                    "Email Address" := Members."E-Mail";
                    "Residential Address" := Members."Residential";
                    "Place of Work" := Members."Employer name";
                    Occupation := Members."Position Held";

                end;


                if Members."Member Category" = Members."Member Category"::"Staff Members" then begin

                    "Member Type" := "Member Type"::Staff;
                    if "Appraisal Type" <> "Appraisal Type"::Business then
                        "Appraisal Type" := "Appraisal Type"::Staff;
                end
                else
                    "Member Type" := "Member Type"::Member;

                CheckIncompleteSameProductAppraisal();

                SaccoSetup.Get();

                Loan.Reset();
                Loan.SetRange("Member No.", Rec."Member No.");
                Loan.SetRange(Source, Loan.Source::BOSA);
                Loan.SetRange(Posted, true);
                Loan.SetFilter("Outstanding Principal", '>0');
                Loan.SetFilter("Principal Paid", '=0');
                if Loan.FindFirst() then
                    if not SaccoSetup."Exempt Loan Principal Check" then
                        Error(
                            'Member %1 has an active BOSA loan with outstanding principal and no payments made.',
                            Rec."Member No."
                        );

                // Clear existing self guarantee if member changes
                LoanSecurity.Reset();
                LoanSecurity.SetRange("Loan No.", "Appraisal No.");
                LoanSecurity.SetRange("Member No", Rec."Member No.");
                if LoanSecurity.FindFirst() then
                    LoanSecurity.Delete();

                if "Member No." = '' then
                    exit;

                UpdateShareCapitalBandRequirement();

                // Get deposit account
                DepositAccountNo := Legacy.GetDepositAccounts("Member No.");
                if DepositAccountNo = '' then
                    exit;

                if not Savings.Get(DepositAccountNo) then
                    exit;

                if Rec."Appraisal No." <> '' then
                    InserLoneeGuarantor(DepositAccountNo);
            end;
        }
        field(42; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(44; "Status"; Option)
        {
            OptionMembers = Open,Pending,Approved,Rejected;
            Editable = false;
        }

        field(45; "Annual Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; "Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Net Loan Take Home"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(48; "Recommended Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(49; "Member Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,Pensioner,Staff;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(50; "Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(51; "Share Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }

        field(52; "BOSA Loan balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(53; "Maximum Credit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(54; "Deposit Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }

        field(55; "FOSA Loan To Run At"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Net Salary Multiplier %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(57; "Appraisal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Business,Staff;
            OptionCaption = 'Member,Staff';
            ValuesAllowed = Business, Staff;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(58; "Appraisal Completed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59; "Housing levy"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }

        field(60; "BOSA Loans Manual"; Decimal)
        {
            Caption = 'BOSA Loans Manual';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(61; "FOSA Loans Manual"; Decimal)
        {
            Caption = 'FOSA Loans Manual';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(62; "Commission Excise"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            //CalcFormula = sum("Appraisal Top Up"."Commision Excise" where("Loan No." = field("Appraisal No.")));
            //FieldClass = FlowField;
        }

        field(63; "Global Dimension 1 Code"; Code[20])
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
        field(64; "Booking Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(65; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = BOSA,FOSA,MICRO;
            ValuesAllowed = BOSA;
        }
        field(66; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Approved On"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Total Loan to Pay"; Decimal)
        {
            Caption = 'Total Loan to Pay';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(81; "Total Yearly Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


        field(85; "Deposit Boosting"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                //GetLoanCharges();
                GetValues();
            end;
        }
        field(86; "Deposit Boosted Charge"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                //GetLoanCharges();
                GetValues();
            end;
        }

        field(90; "Share Capital Boosting"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                GetValues();
                // GetLoanCharges("Share Capital Boosting");
            end;
        }
        field(92; "Required Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(93; "Current Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(91; "Product Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Product Setup".Description where("Product ID" = field("Loan Product Type")));
            Editable = false;
        }

        field(94; "Business Gross Pay"; Decimal)
        {
            Caption = 'Business Gross Pay';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }


        field(95; "FOSA Loan balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                GetValues();
            end;
        }
        field(96; "Repay Mode"; Enum "Repay Mode Enum")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = " ", Cash, Salary, "Check Off", "Dividends", "Internal Standing Order", "External Standing Order";

        }
        field(97; "Qualification As Per Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Qualification as Per Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "Qualification as Per Guarantor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "No. of Guarantors"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Members.No. WHERE (Group Account=CONST(Yes))';
            TableRelation = Members."No." where("Group Account" = const(true));
        }
        field(102; "Arrears to Recover"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Portal Loan Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(104; "Deposit Boosted"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()

            begin
                //GetLoanCharges();
                GetValues();
            end;
        }
        field(105; "Total Arrears"; Decimal)
        {
            CalcFormula = sum("SACCO Categorization"."Total Arrears" where("Member No." = field("Member No.")));
            FieldClass = FlowField;
        }
        field(106; "ID Number"; Code[20])
        {
            Caption = 'ID Number';
            DataClassification = CustomerContent;
        }

        field(107; "KRA PIN"; Code[20])
        {
            Caption = 'KRA PIN Number';
            DataClassification = CustomerContent;
        }

        field(108; "P.O. Box"; Code[20])
        {
            Caption = 'P.O. Box';
            DataClassification = CustomerContent;
        }

        field(109; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
        }

        field(110; Town; Text[50])
        {
            Caption = 'Town';
            DataClassification = CustomerContent;
        }

        field(111; "Mobile No."; Text[30])
        {
            Caption = 'Mobile No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }

        field(112; "Alternate Mobile No."; Text[30])
        {
            Caption = 'Alternate Mobile No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }

        field(113; "Email Address"; Text[80])
        {
            Caption = 'Email Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }

        field(114; "Residential Address"; Text[100])
        {
            Caption = 'Residential Address';
            DataClassification = CustomerContent;
        }

        field(115; "Place of Work"; Text[100])
        {
            Caption = 'Place of Work';
            DataClassification = CustomerContent;
        }

        field(116; Occupation; Text[250])
        {
            Caption = 'Occupation';
            DataClassification = CustomerContent;
        }

        field(117; "Net Income Per Month"; Decimal)
        {
            Caption = 'Net Income Per Month';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                GetValues();
            end;
        }

        field(118; "Monthly Expenditure"; Decimal)
        {
            Caption = 'Monthly Expenditure';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                GetValues();
            end;
        }
        field(119; "Loan Officer"; code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
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

            TableRelation = "Sasra Sectorial Level 2"."Sub-Sector Level 2 Code";
            trigger OnValidate()
            var
                LevelTwo: Record "Sasra Sectorial Level 2";
                LevelOne: Record "Sasra Sectorial Level 1";
                MainSector: Record "Sasra Main Sector";
            begin
                "Sub-Sector Level 2 Description" := '';
                "Sub-Sector Level 1 Code" := '';
                "Main Sector Code" := '';

                LevelTwo.Reset();
                LevelTwo.SetRange("Sub-Sector Level 2 Code", "Sub-Sector Level 2 Code");
                if LevelTwo.FindFirst() then begin
                    "Sub-Sector Level 2 Description" := LevelTwo."Sub-Sector Level 2 Description";
                    if "Sub-Sector Level 1 Code" = '' then begin
                        "Sub-Sector Level 1 Code" := LevelTwo."Sub-Sector Level 1 Code";
                        "Sub-Sector Level 1 Description" := LevelTwo."Sub-Sector Level 1 Description";

                        LevelOne.Reset();
                        LevelOne.SetRange("Sub-Sector Level 1 Code", "Sub-Sector Level 1 Code");
                        if LevelOne.FindFirst() then begin
                            "Sub-Sector Level 1 Description" := LevelOne."Sub-Sector Level 1 Description";
                            if "Main Sector Code" = '' then begin

                                MainSector.Reset();
                                MainSector.SetRange("Main Sector Code", LevelOne."Main Sector Code");
                                if MainSector.FindFirst() then begin
                                    "Main Sector Code" := MainSector."Main Sector Code";
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
        field(170; "Declaration 1"; Boolean)
        {
            Caption = 'Statements are correct and true';
            DataClassification = CustomerContent;
        }

        field(171; "Declaration 2"; Boolean)
        {
            Caption = 'Understand offence of false information';
            DataClassification = CustomerContent;
        }

        field(172; "Declaration 3"; Boolean)
        {
            Caption = 'Authorize deduction in case of default';
            DataClassification = CustomerContent;
        }

        field(173; "Declaration 4"; Boolean)
        {
            Caption = 'Agree to abide by Sacco bylaws';
            DataClassification = CustomerContent;
        }

        field(174; "Declaration 5"; Boolean)
        {
            Caption = 'Authorize credit checks';
            DataClassification = CustomerContent;
        }

        field(175; "Declaration 6"; Boolean)
        {
            Caption = 'Pledge to notify address changes';
            DataClassification = CustomerContent;
        }

        field(176; "Indemnity Accepted"; Boolean)
        {
            Caption = 'Indemnity Clause Accepted';
            DataClassification = CustomerContent;
        }

        field(177; "Applicant Signature Date"; Date)
        {
            Caption = 'Applicant Signature Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Applicant Signature Date" > Today then
                    Error('Applicant Signature Date cannot be in the future');
            end;
        }
        field(178; "Loan Restructured"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(183; "Loan Stage"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Loan Application","Loan Appraisal","Loan Approval",Finance;

        }
        field(184; "Document Type"; enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(185; "Loan Moratorium End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(186; "Loan Moratorium Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(188; "CEO Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(189; "Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            InitValue = "Reducing Balance";
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Reducing Flat,Zero Interest';
            OptionMembers = Amortised,"Reducing Balance","Straight Line","Reducing Flat","Zero Interest";
            trigger OnValidate()
            begin
                GetValues();
            end;
        }
        field(191; "Loan Purpose"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(192; "Appraiser Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(193; "Credit Committee Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(194; "Board Comments"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(195; "Business Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(196; "Type of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Full Disbursement,Partial Disbursement';
            OptionMembers = "Full Disbursement","Partial Disbursement";

            trigger OnValidate()
            var
                DisbErr: label 'The amount to disburse cannot be greater than or equal to approved amount';
                Text002: label 'Amount to disburse must be equal to amount approved';
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
        field(197; "Appraiser ID"; code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                if ("Appraiser ID" <> '') and ("Loan Appraisal Date" = 0D) then
                    "Loan Appraisal Date" := Today;
            end;
        }
        field(198; "Amount To Disburse"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                LRec: record Loans;
            begin


                if ("Amount To Disburse" < "Approved Amount") then begin
                    "Type of Disbursement" := "type of disbursement"::"Partial Disbursement";
                end
                else begin
                    if ("Amount To Disburse" > "Approved Amount") then
                        Error('Cannot be greater than Approved Amount');

                    "Type of Disbursement" := "type of disbursement"::"Full Disbursement";
                end;

                if LoanType.Get("Loan Product Type") then begin
                    if LoanType."Use Tiered Debt Threshold" then begin
                        Period := Lrec.GetTieredInstallments(LoanType."Product ID", "Amount To Disburse");
                        // Validate(Installments);
                    end;
                end;
                // LRec.CalculateLoanRepayments("Amount To Disburse");
                Getvalues()
            end;
        }
        field(199; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Approved Amount" > "Requested Amount" then
                    Error('Approved amount cannot be greater than requested amount');
                CheckAndSetFeeWaiverFlag(Rec);
                UpdateShareCapitalBandRequirement();
                GetValues();
            end;

        }
        field(200; "Consolidated Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckAndSetFeeWaiverFlag(Rec);
                GetValues();
            end;
        }
        field(201; "Rescheduled Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckAndSetFeeWaiverFlag(Rec);
                GetValues();
            end;
        }
        field(202; "Fee Waiver Applied"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(203; "Repayment Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(204; "Schedule Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Schedule Start Date" < "Repayment Start Date" then
                    Error('Schedule Start Date cannot be less than repayment start date');
            end;
        }
        field(205; "Source Application"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(206; "Product Sub Type"; Enum "Product Sub. Type")
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PopulateSubType;
            end;
        }
        field(207; "Loan Rejection Reason"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(208; "Total Principal Top Up"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Appraisal Top Up"."Principle Top Up" where("Loan No." = field("Appraisal No.")));
        }
        field(209; "BOSA Savings Manually Set"; Boolean)
        {
            DataClassification = ToBeClassified;
        }



        field(210; "CRB Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(211; "CRB Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(212; "CRB Status Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(213; "CRB Status Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(214; "CRB Status Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(215; "CRB Mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(216; "Date Captured"; Date)
        {
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(217; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin


                TestField(Status, Status::Open);
            end;
        }
        field(218; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Amount Guaranteed" where("Loan No." = field("Appraisal No."),
                                                                         Substituted = filter(false)));
            Description = 'Sum("Loan Guarantors and Security"."Amount Guaranteed" WHERE (Loan No=FIELD(Loan No.),Substituted=CONST(No)))';
            FieldClass = FlowField;
        }
        field(219; "Loan Appraisal Date"; Date)
        {
            Caption = 'Loan Appraisal Date';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Appraisal No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        NSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "user setup";


    begin

        if "Appraisal No." = '' then begin

            NSetup.Get;
            NSetup.TestField("Appraisal Nos");
            "Appraisal No." := NoSeries.GetNextNo(NSetup."Appraisal Nos", WorkDate(), true);

        end;

        if Date = 0D then
            "Date" := Today;
        "Date Captured" := Today;
        "Captured By" := UserId;
        "Document Type" := "Document Type"::Loan;
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");
        "Booking Branch" := UserSetup."Global Dimension 2 Code";

        if not UserSetup."Appraise loan" then
            Error(Text001);

        if "Appraisal No." <> '' then
            validate("Member No."); // To populate member details and validate member status
    end;

    /// <summary>
    /// GetValues.
    /// </summary>
    procedure GetValues()
    var
        Avg: Decimal;
        myInt: Integer;
        Payroll: Codeunit "Payroll Processing";
        Loans: Record Loans;
        RepAmt: Decimal;
        Legacy: Codeunit Legacy;
        MAct: Codeunit "Member Activities";
        SAct: Codeunit "Sacco Activities";
        PSetup: Record "Product Setup";
        ProductSetup: Record "Product Setup";
        LOanTopUp: Record "Appraisal Top Up";
        PVA: Decimal;
        RatesCeilings: Record "Payroll Rates";
        InsRelief: Decimal;
        OtherCommitementsClearance: Record "Other Committments Clearance";
        MonthlyInterest: Decimal;
        IntDue: Decimal;
        EndMonth: Date;
        TDays: Integer;
        Days: Integer;
        CurrDay: Integer;
        LSecurity: Record "Loan Security";
        Savings: Record "Savings Accounts";
        BusinessIncome: Record "Business Monthly Income";
        STOH: Record "Standing Order Header";
        LC: record "Loan Charges";
        RecoveryArrears: Record "Arrears Recovery";
        CommittedDeposits: Decimal;
        TotalBal: Decimal;
        MonthlyContributions: Record "Savings Accounts";
        HasOutstandingLoanNotToppedUp: Boolean;
        HREmp: Record "Staff Payroll Details";
        SelectedCharge: integer;
        Topup: Record "Appraisal Top Up";
        LoanCharges: Record "Loan Charges";
    begin
        RatesCeilings.Get();

        //"Gross Pay" := "Basic Pay" + "House Allowance" + "Commuter Allowance" + "Other Allowances";
        Tax := Payroll.fnGetEmployeePaye("Gross Pay" - NSSF);
        InsRelief := round(RatesCeilings."Insurance Relief" / 100 * (Pension + NHIF));
        Tax -= InsRelief;
        Tax -= RatesCeilings."Tax Relief";
        if Tax <= 0 then Tax := 0;
        "FOSA Loans" := 0;
        "BOSA Loans" := 0;
        "Captured By" := UserId;
        STO := 0;
        CommittedDeposits := 0;
        TotalBal := 0;


        //Get STO DEDUCTIONS
        STOH.Reset();
        STOH.SetRange("Member No.", "Member No.");
        STOH.SetRange(Status, STOH.Status::Approved);
        if STOH.FindSet() then begin
            repeat
                STO += STOH.Amount;
            until STOH.Next() = 0;
        end;

        // First, calculate loan repayments
        Loans.Reset();
        Loans.SetRange("Member No.", "Member No.");
        Loans.SetFilter("Outstanding Principal", '>0');
        if Loans.FindFirst() then begin
            repeat
                Loans.CalcFields("Total Outstanding Balance");
                RepAmt := Loans.Repayment;
                TotalBal := Loans."Total Outstanding Balance";
                if RepAmt > Loans."Total Outstanding Balance" then
                    RepAmt := Loans."Total Outstanding Balance";

                LOanTopUp.Reset();
                LOanTopUp.SetRange("Loan No.", "Appraisal No.");
                LOanTopUp.SetRange("Member No.", "Member No.");
                LOanTopUp.SetRange("Loan Top Up", Loans."Loan No.");
                if LOanTopUp.FindFirst() then begin
                    RepAmt := 0;
                    TotalBal := 0;
                end;

                if ProductSetup.Get(Loans."Loan Product Type") then begin
                    CommittedDeposits += CalculateCommittedDeposits(ProductSetup, TotalBal);

                    if ProductSetup."Repay Mode" <> ProductSetup."Repay Mode"::Dividends then begin
                        if "Member Type" = "Member Type"::Pensioner then begin
                            "FOSA Loans" += RepAmt;
                        end else begin
                            if ProductSetup."Loan Source" = ProductSetup."Loan Source"::BOSA then
                                "BOSA Loans" += RepAmt;
                            if ProductSetup."Loan Source" = ProductSetup."Loan Source"::fOSA then
                                "FOSA Loans" += RepAmt;
                        end;
                    end;
                end;
            until Loans.Next() = 0;
        end;

        // Calculate BOSA Savings
        // Skip auto-calculation if user has manually entered a value
        if not "BOSA Savings Manually Set" then begin
            HasOutstandingLoanNotToppedUp := false;

            Loans.Reset();
            Loans.SetRange("Member No.", Rec."Member No.");
            Loans.SetFilter("Outstanding Principal", '>0');
            if Loans.FindFirst() then begin
                repeat

                    LOanTopUp.Reset();
                    LOanTopUp.SetRange("Loan No.", "Appraisal No.");
                    LOanTopUp.SetRange("Member No.", "Member No.");
                    LOanTopUp.SetRange("Loan Top Up", Loans."Loan No.");
                    if not LOanTopUp.FindFirst() then
                        HasOutstandingLoanNotToppedUp := true;

                until (Loans.Next() = 0) or HasOutstandingLoanNotToppedUp;
            end;

            if HasOutstandingLoanNotToppedUp then
                "BOSA Savings" := 0
            else begin
                "BOSA Savings" := 0;

                MonthlyContributions.Reset();
                MonthlyContributions.SetRange("Member No.", "Member No.");
                MonthlyContributions.SetRange("Status", MonthlyContributions.Status::Active);
                MonthlyContributions.SetRange("Product Category", MonthlyContributions."Product Category"::"Deposit Contribution");
                if MonthlyContributions.FindFirst() then begin
                    repeat
                        "BOSA Savings" += MonthlyContributions."Monthly Contribution";
                    until MonthlyContributions.Next() = 0;
                end;

                if "BOSA Savings" = 0 then begin
                    if Savings.Get(Legacy.GetDepositAccounts("Member No.")) then begin
                        ProductSetup.Get(Savings."Product Type");
                        "BOSA Savings" := ProductSetup."Mandatory Contribution";
                    end;
                end;
            end;
        end;


        if "Appraisal Type" = "Appraisal Type"::Staff then begin
            HREmp.Get("Staff No.");
            "Basic Pay" := HREmp."Basic Pay";

            ValidateStaffLoanEligibility(HREmp);

            FetchLatestStaffPayrollDeductions(HREmp);

            "1/3 of Gross Pay" := round("Basic Pay" / 3);
            //"To Deduct" := "BOSA Loans" + "BOSA Savings" + tax + Pension + nssf + NHIF + "Housing levy" + "Other Deductions" + "1/3 of Gross Pay";
            "To Deduct" := "BOSA Loans Manual" + Pension + nssf + NHIF + "Housing levy" + "Other Deductions" + "1/3 of Gross Pay";

            "BOSA Loan To Run At" := 0;

            "BOSA Loan To Run At" := "1/3 of Gross Pay" - "BOSA Loans";

            //if Multiplier = 0 then
            //  Multiplier := 3;

            "Net Salary" := ("Basic Pay" + "Other Allowances") - ("BOSA Loans" + "FOSA Loans Manual" + Pension + nssf + NHIF + "Housing levy" + "Other Deductions"); //"1/3 of Gross Pay" + "BOSA Loan To Run At" + "Other Allowances";

            "Net Salary Multiplier %" := ProductSetup."Appraisal % on Amount";

            if "Net Salary Multiplier %" = 0 then
                "Net Salary Multiplier %" := 60;

            "Percentage of Net Salary" := round("Net Salary Multiplier %" / 100 * "Net Salary");

            "Net Salary After Fosa Ded" := "Percentage of Net Salary" - "FOSA Loans";
        end;

        "FOSA Loan To Run At" := "Net Salary After Fosa Ded";
        if "FOSA Loan To Run At" < 0 then
            if "Annual Interest %" > 0 then
                If Period > 0 then
                    PVA := ((1 - Power((1 + ("Annual Interest %" / 1200)), -Period)) / ("Annual Interest %" / 1200));



        if "Appraisal Type" = "Appraisal Type"::Business then
            "Share Deposits" := MAct.GetAccountBalance(Legacy.GetDepositAccounts("Member No.")) + MAct.GetAccountBalance(Legacy.GetMicroDepositAccount("Member No."))
        else
            "Share Deposits" := MAct.GetAccountBalance(Legacy.GetDepositAccounts("Member No."));

        "Deposit Multiplier" := "Share Deposits" * Multiplier;
        "BOSA Loan balance" := 0;

        if "Loan Product Type" = 'L01' then begin
            Loans.Reset();
            Loans.SetRange("Member No.", Rec."Member No.");
            Loans.SetRange("Loan Product Type", 'L01');
            Loans.SetFilter("Outstanding Principal", '>0');
            Loans.SetAutoCalcFields("Outstanding Principal");
            if Loans.FindFirst() then begin
                "BOSA Loan balance" := Loans."Outstanding Principal";
            end;
        end else
            if "Loan Product Type" <> 'L07' then
                "BOSA Loan balance" := Legacy.GetTotalBosaLoanPrincipalBalance("Member No.");

        "FOSA Loan balance" := Legacy.GetTotalFosaLoanPrincipalBalance("Member No.");

        "Maximum Credit" := "Deposit Multiplier";// - ("BOSA Loan balance" + "FOSA Loan balance");

        RecoveryArrears.reset();
        RecoveryArrears.SetRange("Application No.", "Appraisal No.");
        if RecoveryArrears.FindFirst() then begin
            RecoveryArrears.CalcSums("Interest Arrears Recovered", "Principal Arrears Recovered");
            "Arrears to Recover" := RecoveryArrears."Interest Arrears Recovered" + RecoveryArrears."Principal Arrears Recovered";
        end;

        LOanTopUp.Reset();
        LOanTopUp.SetRange("Loan No.", "Appraisal No.");
        LOanTopUp.SetRange("Member No.", "Member No.");
        if LOanTopUp.FindFirst() then begin
            repeat
                if Loans.Get(LOanTopUp."Loan Top Up") then
                    if PSetup.Get(Loans."Loan Product Type") then
                        if PSetup."Loan Source" = PSetup."Loan Source"::BOSA then
                            "Maximum Credit" += LOanTopUp."Principle Top Up";

            until LOanTopUp.Next() = 0;
        end;

        "Recommended Amount" := "Amount To Disburse";
        if "Appraisal Type" = "Appraisal Type"::Business then begin

            If "Recommended Amount" > "Maximum Credit" then
                "Recommended Amount" := "Maximum Credit";

            if "Recommended Amount" < 0 then
                "Recommended Amount" := 0;
        end;


        if ProductSetup.get("Loan Product Type") then begin
            if ProductSetup."Appraisal % on Amount" > 0 then
                "Net Salary Multiplier %" := ProductSetup."Appraisal % on Amount";

            "Percentage of Net Salary" := round("Net Salary Multiplier %" / 100 * "Net Salary");
            "Net Salary After Fosa Ded" := "Percentage of Net Salary" - "FOSA Loans Manual";

            "FOSA Loan To Run At" := "Net Salary After Fosa Ded";


            PVA := Period;

            //testfield("Annual Interest %");


            if "Appraisal Type" = "Appraisal Type"::Business then begin

                "Recommended Amount" := "Amount To Disburse";
                TestField("Annual Interest %");
                TestField(Period);
                "Monthly Repayment" := ROUND(("Annual Interest %" / 12 / 100) / (1 - Power((1 + ("Annual Interest %" / 12 / 100)), -Period)) * "Recommended Amount", 1, '>');

                "Interest Repayment" := ROUND("Recommended Amount" / 100 / 12 * "Annual Interest %", 0.05, '>');
                "Principal Repayment" := "Monthly Repayment" - "Interest Repayment";

                "BOSA Loans" := 0;
                "FOSA Loans" := 0;

                RepAmt := 0;
                Loans.Reset();
                Loans.SetRange("Member No.", "Member No.");
                Loans.SetFilter("Outstanding Principal", '>0');
                Loans.SetRange("Repay Mode", Loans."Repay Mode"::Business);
                if Loans.FindFirst() then begin
                    repeat
                        Loans.CalcFields("Total Outstanding Balance");
                        RepAmt := Loans.Repayment;
                        if RepAmt > Loans."Total Outstanding Balance" then
                            RepAmt := Loans."Total Outstanding Balance";
                        "FOSA Loans" += RepAmt;
                    until Loans.Next() = 0;
                end;

                "Net Salary Multiplier %" := ProductSetup."Business Appraisal % on Amount";
                Avg := 0;

                BusinessIncome.Reset();
                BusinessIncome.SetRange("Appraisal No.", "Appraisal No.");
                if BusinessIncome.FindFirst() then begin
                    //BusinessIncome.CalcSums("Gross Monthly Income");
                    Avg := Round(BusinessIncome."Free Money");// / BusinessIncome.Count);
                    "Business Gross Pay" := Avg;

                end;

                "Percentage of Net Salary" := round("Net Salary Multiplier %" / 100 * "Business Gross Pay");

                "BOSA Loan To Run At" := "Percentage of Net Salary";

                "Recommended Amount" := "Amount To Disburse";
                //if "Percentage of Net Salary" < ("FOSA Loans Manual" + "Monthly Repayment") then
                //    "Recommended Amount" := 0;

            end;

            if "Annual Interest %" = 0 then begin
                PVA := (Period * 100) / ((Period * 12 / 12) + 100);
            end
            else begin
                if Rec."Interest Calculation Method" = ProductSetup."Interest Calculation Method"::Amortised then
                    PVA := ((1 - Power((1 + ("Annual Interest %" / 1200)), -Period)) / ("Annual Interest %" / 1200))
                else
                    PVA := (Period * 100) / ((Period * ("Annual Interest %" / 12)) + 100);
            end;

            //RecomAppraisal :=GetAppraisalFee(PrincIntQual);
            "Qualification as Per Guarantor" := 0;

            LSecurity.Reset;
            LSecurity.SetRange("Loan No.", "Appraisal No.");
            if LSecurity.Find('-') then begin
                repeat
                    "Qualification as Per Guarantor" += LSecurity."Amount Guaranteed";
                    "No. of Guarantors" += 1;
                until LSecurity.Next = 0;
            end;

            if ProductSetup."Appraise Security" then begin

                if not ProductSetup."Appraise Deposits" and not ProductSetup."Appraise Salary" then //Asset loan
                    "Maximum Credit" := ProductSetup."Maximum Loan Amount";

            end;

            if (ProductSetup."Loan Source" = ProductSetup."Loan Source"::BOSA) or (ProductSetup."Loan Source" = ProductSetup."Loan Source"::MICRO) then
                Qualification := ROUND(("BOSA Loan To Run At") * PVA, 1, '<');

            if ProductSetup."Loan Source" = ProductSetup."Loan Source"::FOSA then
                Qualification := ROUND(("FOSA Loan To Run At") * PVA, 1, '<');

            "Recommended Amount" := "Amount To Disburse";

            "Qualification as Per Income" := Rec."BOSA Loan To Run At" * (PVA);

            "Qualification As Per Deposits" := "Deposit Multiplier" - "BOSA Loan balance"; //- "FOSA Loan balance";

            if ProductSetup."Appraise Salary" then begin
                if "Recommended Amount" > "Qualification as Per Income" then
                    "Recommended Amount" := "Qualification as Per Income";
            end;

            if ProductSetup."Appraise Deposits" then begin
                if "Qualification As Per Deposits" < 0 then
                    "Qualification As Per Deposits" := 0;

                if ProductSetup."Deposit Multiplier" > 0 then begin
                    if "Recommended Amount" > "Qualification As Per Deposits" then
                        "Recommended Amount" := "Qualification As Per Deposits";
                end;

                "Recommended Amount" := "Amount To Disburse";
            end;

            if ProductSetup."Appraise Security" then begin
                if (ProductSetup."Minimum Guarantors" > 0) and (ProductSetup."Guarantorship Type" = ProductSetup."guarantorship type"::Amount) then begin
                    if "Recommended Amount" > "Qualification as Per Guarantor" then
                        "Recommended Amount" := "Qualification as Per Guarantor";
                end;

                "Recommended Amount" := "Amount To Disburse";
            end;

            /*if "Recommended Amount" > Qualification then
                "Recommended Amount" := Qualification;
                */

            /*if ProductSetup."Loan Source" = ProductSetup."Loan Source"::BOSA then begin
                If "Recommended Amount" > "Maximum Credit" then
                    "Recommended Amount" := "Maximum Credit";
            end;*/

            if "Recommended Amount" < 0 then
                "Recommended Amount" := 0;

            if ProductSetup."Interest Due on Disbursement" <> ProductSetup."interest due on disbursement"::" " then begin

                MonthlyInterest := ROUND("Recommended Amount" * "Annual Interest %" / 1200, 0.01, '=');
                if ProductSetup."Loan Type" = ProductSetup."Loan Type"::Mavuno then
                    MonthlyInterest := ("Recommended Amount" * ProductSetup."Interest Rate (Max.)") / 100;

                IntDue := 0;
                "Upfront Interest" := 0;
                EndMonth := CalcDate('CM', TODAY);
                TDays := Date2dmy(EndMonth, 1);
                Days := TDays - Date2dmy(TODAY, 1) + 1;
                CurrDay := Date2DMY(Today, 1);


                if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::"Total Loan Interest - Straight Line" then
                    IntDue := ROUND(MonthlyInterest * Period);
                if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::"Full Interest" then
                    IntDue := ROUND(MonthlyInterest);
                if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::"Prorated Interest" then
                    IntDue := ROUND(MonthlyInterest * Days / TDays);
                if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::"Full Interest Before Cutoff" then begin
                    ProductSetup.TestField("Interest Due Cutoff Day");
                    if CurrDay <= ProductSetup."Interest Due Cutoff Day" then
                        IntDue := MonthlyInterest;
                end;
                if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::"Prorated Interest After CutOff" then begin
                    ProductSetup.TestField("Interest Due Cutoff Day");
                    if CurrDay > ProductSetup."Interest Due Cutoff Day" then
                        IntDue := ROUND(MonthlyInterest * Days / TDays);
                end;
                if ProductSetup."Interest Due on Disbursement" = ProductSetup."interest due on disbursement"::"Full/Prorated Interest Based on CutOff" then begin
                    ProductSetup.TestField("Interest Due Cutoff Day");
                    if CurrDay <= ProductSetup."Interest Due Cutoff Day" then
                        IntDue := MonthlyInterest;
                    if CurrDay > ProductSetup."Interest Due Cutoff Day" then
                        IntDue := ROUND(MonthlyInterest * Days / TDays);
                end;

                if IntDue > 0 then begin
                    IntDue := SaccoActivities.SmartRound(IntDue);
                    "Upfront Interest" := IntDue;
                end;
            end;

        end
        else begin
        end;


        if "Appraisal Type" = "Appraisal Type"::Business then begin


            if "Loan Product Type" <> '' then begin
                TestField("Annual Interest %");
                TestField(Period);
            end;

            "Monthly Repayment" := ROUND(("Annual Interest %" / 12 / 100) / (1 - Power((1 + ("Annual Interest %" / 12 / 100)), -Period)) * "Recommended Amount", 1, '>');
            "Interest Repayment" := ROUND("Recommended Amount" / 100 / 12 * "Annual Interest %", 0.05, '>');


            "Principal Repayment" := "Monthly Repayment" - "Interest Repayment";
        end;



        "Top Up Loan" := 0;
        "Top Up Commission" := 0;
        "Commission Excise" := 0;

        LOanTopUp.Reset();
        LOanTopUp.SetRange("Loan No.", "Appraisal No.");
        LOanTopUp.SetRange("Member No.", "Member No.");
        if LOanTopUp.FindFirst() then begin
            LOanTopUp.CalcSums("Total Top Up", Commision, "Commision Excise");
            "Top Up Commission" := LOanTopUp.Commision;
            "Top Up Loan" := LOanTopUp."Total Top Up";
            "Commission Excise" := LOanTopUp."Commision Excise";
        end;

        Insurance := 0;
        GetLoanCharges(Insurance);

        if Rec."Rescheduled Loan" or Rec."Fee Waiver Applied" then begin
            "Total Charges" := 0;
            "Top Up Commission" := 0;
            "Commission Excise" := 0;
        end;

        SelectedCharge := Rec.GetAssetChargeToPost(Rec);

        if SelectedCharge = 1 then begin
            // Processing Fee selected, clear Top Up Commission records
            TopUp.Reset();
            TopUp.SetRange("Loan No.", Rec."Appraisal No.");
            if TopUp.FindSet() then
                repeat
                    TopUp.Validate(Commision, 0);
                    TopUp.Modify(true);
                    Commit();
                until TopUp.Next() = 0;
        end;

        if SelectedCharge = 2 then begin
            // Top Up Commission selected, clear Processing Fee charge
            LoanCharges.Reset();
            LoanCharges.SetRange("Loan No.", Rec."Appraisal No.");
            LoanCharges.SetRange("Charge Type", LoanCharges."Charge Type"::"Loan Processing Fee");
            if LoanCharges.FindSet() then
                repeat
                    LoanCharges."Total Charge" := 0;
                    LoanCharges."Excise Duty" := 0;
                    LoanCharges."Charge %" := 0;
                    LoanCharges.Amount := 0;
                    LoanCharges.Modify(true);
                    Commit();
                until LoanCharges.Next() = 0;
        end;

        "Top Up Loan" := 0;
        "Top Up Commission" := 0;
        "Commission Excise" := 0;

        LOanTopUp.Reset();
        LOanTopUp.SetRange("Loan No.", "Appraisal No.");
        LOanTopUp.SetRange("Member No.", "Member No.");
        if LOanTopUp.FindFirst() then begin
            LOanTopUp.CalcSums("Total Top Up", Commision, "Commision Excise");
            "Top Up Commission" := LOanTopUp.Commision;
            "Top Up Loan" := LOanTopUp."Total Top Up";
            "Commission Excise" := LOanTopUp."Commision Excise";
        end;

        CalcFields("Total Charges");// := 0;

        "Deposit Boosting" := "Requested Amount" * ProductSetup."Share Deposit Capitilization %" * 0.01;

        "External Clearance" := 0;
        OtherCommitementsClearance.RESET;
        OtherCommitementsClearance.SETRANGE("Loan Application No.", "Appraisal No.");
        IF OtherCommitementsClearance.FINDFIRST THEN begin
            OtherCommitementsClearance.CalcSums(Amount);
            "External Clearance" := OtherCommitementsClearance.Amount;
        end;
        //"Recommended Amount" := "Requested Amount";

        if "Appraisal Type" = "Appraisal Type"::Staff then begin
            if "Approved Amount" > "Recommended Amount" then begin
                Rec.TestField("Appraiser Comments");
                "Net Loan Take Home" := "Approved Amount" - "External Clearance" - "Top Up Loan" - "Arrears to Recover" - "Upfront Interest" - "Total Charges" - "Share Capital Boosting" - "Deposit Boosting";
            end else
                "Net Loan Take Home" := "Recommended Amount" - "External Clearance" - "Top Up Loan" - "Arrears to Recover" - "Upfront Interest" - "Total Charges" - "Share Capital Boosting" - "Deposit Boosting";
        end else
            "Net Loan Take Home" := "Recommended Amount" - "External Clearance" - "Top Up Loan" - "Arrears to Recover" - "Upfront Interest" - "Total Charges" - "Share Capital Boosting" - "Deposit Boosting";

        if "Loan Product Type" <> '' then begin

            if "Annual Interest %" > 0 then begin

                if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then begin
                    TestField("Annual Interest %");
                    TestField(Period);


                    "Monthly Repayment" := ROUND(("Annual Interest %" / 12 / 100) / (1 - Power((1 + ("Annual Interest %" / 12 / 100)), -Period)) * "Recommended Amount", 1, '>');
                    "Interest Repayment" := ROUND("Recommended Amount" / 100 / 12 * "Annual Interest %", 0.05, '>');



                    "Principal Repayment" := "Monthly Repayment" - "Interest Repayment";



                    //HERE AGAIN
                    //"Total Yearly Interest" := "Interest Repayment" * Period;
                    "Total Loan to Pay" := ("Monthly Repayment" * period) + (Insurance * Period) + ("BOSA Savings" * Period);


                end;

                if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Straight Line" then begin
                    TestField(Period);
                    "Principal Repayment" := ROUND("Recommended Amount" / Period, 1, '>');
                    "Interest Repayment" := ROUND(("Annual Interest %" / 12 / 100) * "Recommended Amount", 1, '>');
                    "Monthly Repayment" := "Principal Repayment" + "Interest Repayment";
                end;

                if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance" then begin
                    TestField(Period);
                    "Principal Repayment" := ROUND("Recommended Amount" / Period, 1, '>');
                    "Interest Repayment" := ROUND(("Annual Interest %" / 12 / 100) * "Recommended Amount", 1, '>');
                    "Monthly Repayment" := "Principal Repayment" + "Interest Repayment";
                end;

                if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Flat" then begin
                    TestField(Period);
                    //"Monthly Repayment":=ROUND(("Annual Interest %"/12/100) / (1 - POWER((1 + ("Annual Interest %"/12/100)),- Period)) * "Recommended Amount",1,'>');
                    "Principal Repayment" := ROUND("Recommended Amount" / Period, 1.0, '>');
                    //AmortisedInt:="Monthly Repayment"*Period-"Approved Amount";
                    "Interest Repayment" := ROUND((("Recommended Amount" * "Annual Interest %" / 12 / 100) + ("Principal Repayment" * "Annual Interest %" / 12 / 100)) / 2, 1.0, '>');
                    //"Interest Repayment":=AmortisedInt/Period;
                    "Monthly Repayment" := "Principal Repayment" + "Interest Repayment";
                end;
            end else begin
                "Principal Repayment" := "Recommended Amount" / Period;
                "Monthly Repayment" := "Principal Repayment";
                "Interest Repayment" := 0;
            end;



            "Principal Repayment" := SaccoActivities.SmartRound("Principal Repayment");
            "Interest Repayment" := SaccoActivities.SmartRound("Interest Repayment");
            Insurance := SaccoActivities.SmartRound(Insurance);


            if Period = 1 then begin
                if "Upfront Interest" > 0 then begin
                    "Interest Repayment" := 0;
                    "Monthly Repayment" := "Principal Repayment";

                end;
            end;

            "Max. Monthly Deduction" := "Monthly Repayment" + "BOSA Savings" + Insurance;


            BusinessIncome.Reset();
            BusinessIncome.SetRange("Appraisal No.", "Appraisal No.");
            /* if BusinessIncome.FindFirst() then begin
                 repeat
                     BusinessIncome."Monthly Repayment" := "Monthly Repayment" + "FOSA Loans";
                     BusinessIncome."Deficit/Surplus" := BusinessIncome."Gross Monthly Income" - BusinessIncome."Monthly Repayment";
                     BusinessIncome.Modify();
                 until BusinessIncome.Next() = 0;
             end;*/

        end;

        Loans.Reset();
        Loans.SetRange("Salary Appraisal No.", "Appraisal No.");
        if Loans.FindFirst() then begin
            Loans.Validate("Recommended Amount", "Recommended Amount");
            Loans.Validate("Net To Be Disbursed", "Net Loan Take Home");
        end;


    end;

    procedure GetAssetChargeToPost(Loans: Record "Member Salary Appraisal"): Integer
    var
        LoanCharges: Record "Loan Charges";
        TopUp: Record "Appraisal Top Up";
        LoanType: Record "Product Setup";
        SelectedCharge: Integer;
        ProcFee: Decimal;
        TopUpComm: Decimal;
    begin
        if not LoanType.Get(Loans."Loan Product Type") then
            exit(0);

        if LoanType."Charge Comparison Type" = LoanType."Charge Comparison Type"::" " then
            exit(0);

        // Get Processing Fee
        Clear(ProcFee);
        Clear(TopUpComm);
        Clear(SelectedCharge);

        LoanCharges.Reset();
        LoanCharges.SetRange("Loan No.", Loans."Appraisal No.");
        LoanCharges.SetRange("Charge Type", LoanCharges."Charge Type"::"Loan Processing Fee");

        if LoanCharges.FindFirst() then
            ProcFee := LoanCharges.Amount;

        // Get Top Up Commission
        TopUp.Reset();
        TopUp.SetRange("Loan No.", Loans."Appraisal No.");
        if TopUp.FindSet() then begin
            TopUp.CalcSums(Commision);
            TopUpComm := TopUp.Commision;
        end;

        // Compare and reset the lower/higher amount depending on setup
        case LoanType."Charge Comparison Type" of

            LoanType."Charge Comparison Type"::Higher:
                begin
                    if (ProcFee >= TopUpComm) and (ProcFee > 0) then begin
                        // Take Processing Fee, reset Top Up Commission
                        TopUpComm := 0;
                        SelectedCharge := 1;
                    end else
                        if TopUpComm > 0 then begin
                            // Take Top Up Commission, reset Processing Fee
                            ProcFee := 0;
                            SelectedCharge := 2;
                        end;
                end;

            LoanType."Charge Comparison Type"::Lower:
                begin
                    if (ProcFee <= TopUpComm) and (ProcFee > 0) then begin
                        // Take Processing Fee, reset Top Up Commission
                        TopUpComm := 0;
                        SelectedCharge := 1;
                    end else
                        if TopUpComm > 0 then begin
                            // Take Top Up Commission, reset Processing Fee
                            ProcFee := 0;
                            SelectedCharge := 2;
                        end;
                end;
        end;

        exit(SelectedCharge);

    end;

    local procedure InserLoneeGuarantor(DepositAccountNo: Code[20])
    var
        LoanSecurity: Record "Loan Security";
    begin
        // Insert self guarantee line if not exists
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", "Appraisal No.");
        LoanSecurity.SetRange("Account No.", DepositAccountNo);
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Guarantor);

        if not LoanSecurity.FindFirst() then begin
            LoanSecurity.Init();
            LoanSecurity."Loan No." := "Appraisal No.";
            LoanSecurity."Guarantor Type" := LoanSecurity."Guarantor Type"::Guarantor;
            LoanSecurity."Self Guarantee" := Rec."Self Guarantee";
            LoanSecurity.Validate("Account No.", DepositAccountNo);
            LoanSecurity."Member No" := "Member No.";
            LoanSecurity."Security Details" := '';
            LoanSecurity."Member Guaranteed" := "Member No.";
            LoanSecurity."Loanee Name" := Members.Name;
            LoanSecurity.Date := Today;
            LoanSecurity.Insert();

        end;
    end;

    local procedure ValidateStaffLoanEligibility(HREmp: Record "Staff Payroll Details")
    var
        StaffLoanProduct: Record "Product Setup";
        MinEmploymentYears: Integer;
        EmploymentYears: Decimal;
        MaxAllowedRepayment: Decimal;
        ExistingMonthlyObligations: Decimal;
        NetAvailableForRepayment: Decimal;
    begin
        if "Loan Product Type" = '' then
            exit;

        MaxAllowedRepayment := 0;
        ExistingMonthlyObligations := 0;
        NetAvailableForRepayment := 0;

        StaffLoanProduct.Get("Loan Product Type");

        if StaffLoanProduct."Loan Clients" <> StaffLoanProduct."Loan Clients"::"Staff Members" then
            Error(
                'Loan product %1 - %2 is not a staff loan product.',
                StaffLoanProduct."Product ID",
                StaffLoanProduct.Description);

        MinEmploymentYears := GetStaffLoanMinEmploymentYears(StaffLoanProduct);

        EmploymentYears := GetStaffEmploymentYears(HREmp);

        if EmploymentYears < MinEmploymentYears then
            Error(
                'Staff member %1 does not qualify for %2. Minimum employment period is %3 year(s), but current employment period is %4 year(s).',
                "Staff No.",
                StaffLoanProduct.Description,
                MinEmploymentYears,
                Round(EmploymentYears, 0.01));

        MaxAllowedRepayment := Round("Basic Pay" / 3, 0.01);

        ExistingMonthlyObligations := GetStaffExistingMonthlyObligations();

        NetAvailableForRepayment := MaxAllowedRepayment - ExistingMonthlyObligations;

        if NetAvailableForRepayment < 0 then
            NetAvailableForRepayment := 0;

        if "Monthly Repayment" > NetAvailableForRepayment then begin
            LimitStaffRecommendedAmount(NetAvailableForRepayment);

            Message(
                'Staff loan affordability limit applied.\Basic Pay: %1\1/3 Basic Pay: %2\Existing Monthly Obligations: %3\Available Repayment Capacity: %4\Recommended Amount has been limited to %5.',
                "Basic Pay",
                MaxAllowedRepayment,
                ExistingMonthlyObligations,
                NetAvailableForRepayment,
                "Recommended Amount"
            );
        end;
    end;

    local procedure GetStaffLoanMinEmploymentYears(StaffLoanProduct: Record "Product Setup"): Integer
    begin
        StaffLoanProduct.TestField("Minimum Sacco Period");
        exit(StaffLoanProduct."Minimum Sacco Period");

        // Safer default for any staff loan product not explicitly listed.
        exit(0);
    end;

    local procedure GetStaffEmploymentYears(HREmp: Record "Staff Payroll Details"): Decimal
    var
        EmploymentStartDate: Date;
        Employee: Record Employee;
    begin
        Employee.Get(HREmp."Employee Code");

        EmploymentStartDate := Employee."Employment Date";

        if EmploymentStartDate = 0D then
            Error('Employment start date is missing for staff member %1.', "Staff No.");

        exit((Today - EmploymentStartDate) / 365);
    end;

    local procedure GetStaffExistingMonthlyObligations(): Decimal
    begin

        exit(
            Pension +
            NSSF +
            NHIF +
            "Housing levy" +
            "BOSA Loans Manual" +
            "FOSA Loans Manual" +
            "Other Deductions"
        );
    end;

    local procedure LimitStaffRecommendedAmount(NetAvailableForRepayment: Decimal)
    var
        PresentValueFactor: Decimal;
    begin
        if NetAvailableForRepayment <= 0 then begin
            "Recommended Amount" := 0;
            "Monthly Repayment" := 0;
            "Interest Repayment" := 0;
            "Principal Repayment" := 0;
            exit;
        end;

        TestField(Period);

        if "Annual Interest %" > 0 then begin
            if "Interest Calculation Method" = "Interest Calculation Method"::Amortised then
                PresentValueFactor := ((1 - Power((1 + ("Annual Interest %" / 1200)), -Period)) / ("Annual Interest %" / 1200))
            else
                PresentValueFactor := (Period * 100) / ((Period * ("Annual Interest %" / 12)) + 100);
        end else
            PresentValueFactor := Period;

        "Recommended Amount" := Round(NetAvailableForRepayment * PresentValueFactor, 1, '<');

        if "Recommended Amount" > "Amount To Disburse" then
            "Recommended Amount" := "Amount To Disburse";

        if "Recommended Amount" < 0 then
            "Recommended Amount" := 0;

        RecalculateStaffMonthlyRepayment();
    end;

    local procedure RecalculateStaffMonthlyRepayment()
    begin
        if "Recommended Amount" <= 0 then begin
            "Monthly Repayment" := 0;
            "Interest Repayment" := 0;
            "Principal Repayment" := 0;
            exit;
        end;

        TestField(Period);

        if "Annual Interest %" > 0 then begin
            case "Interest Calculation Method" of
                "Interest Calculation Method"::Amortised:
                    begin
                        TestField("Annual Interest %");
                        "Monthly Repayment" :=
                            Round(
                                ("Annual Interest %" / 12 / 100) /
                                (1 - Power((1 + ("Annual Interest %" / 12 / 100)), -Period)) *
                                "Recommended Amount",
                                1,
                                '>');

                        "Interest Repayment" :=
                            Round("Recommended Amount" / 100 / 12 * "Annual Interest %", 0.05, '>');

                        "Principal Repayment" := "Monthly Repayment" - "Interest Repayment";
                    end;

                "Interest Calculation Method"::"Straight Line":
                    begin
                        "Principal Repayment" := Round("Recommended Amount" / Period, 1, '>');
                        "Interest Repayment" := Round(("Annual Interest %" / 12 / 100) * "Recommended Amount", 1, '>');
                        "Monthly Repayment" := "Principal Repayment" + "Interest Repayment";
                    end;

                "Interest Calculation Method"::"Reducing Balance":
                    begin
                        "Principal Repayment" := Round("Recommended Amount" / Period, 1, '>');
                        "Interest Repayment" := Round(("Annual Interest %" / 12 / 100) * "Recommended Amount", 1, '>');
                        "Monthly Repayment" := "Principal Repayment" + "Interest Repayment";
                    end;

                "Interest Calculation Method"::"Reducing Flat":
                    begin
                        "Principal Repayment" := Round("Recommended Amount" / Period, 1.0, '>');
                        "Interest Repayment" :=
                            Round(
                                (("Recommended Amount" * "Annual Interest %" / 12 / 100) +
                                 ("Principal Repayment" * "Annual Interest %" / 12 / 100)) / 2,
                                1.0,
                                '>');
                        "Monthly Repayment" := "Principal Repayment" + "Interest Repayment";
                    end;
            end;
        end else begin
            "Principal Repayment" := Round("Recommended Amount" / Period, 1, '>');
            "Interest Repayment" := 0;
            "Monthly Repayment" := "Principal Repayment";
        end;
    end;

    procedure CalculateCommittedDeposits(ProductSetup: Record "Product Setup"; TotalBal: Decimal): Decimal
    begin
        if (ProductSetup."Nature of Loan Type" = ProductSetup."Nature of Loan Type"::Defaulter) or
           (ProductSetup."Loan Type" = ProductSetup."Loan Type"::"Salary In Advance") or
           (ProductSetup."Deposit Multiplier" = 0) then
            exit(0);

        exit(TotalBal / ProductSetup."Deposit Multiplier");
    end;

    local procedure UpdateShareCapitalBandRequirement()
    var
        RequiredShareCapital: Decimal;
        CurrentShareCapital: Decimal;
    begin
        "Required Share Capital" := 0;
        "Current Share Capital" := 0;
        "Share Capital Boosting" := 0;

        if ("Member No." = '') or ("Loan Product Type" = '') or ("Requested Amount" = 0) then
            exit;

        RequiredShareCapital := GetRequiredShareCapital("Loan Product Type", "Requested Amount");
        CurrentShareCapital := GetMemberShareCapital("Member No.");

        "Required Share Capital" := RequiredShareCapital;
        "Current Share Capital" := CurrentShareCapital;

        if CurrentShareCapital < RequiredShareCapital then
            Error(
                'Member share capital %1 is below the required share capital %2 for loan amount %3.',
                CurrentShareCapital,
                RequiredShareCapital,
                "Requested Amount");
    end;

    local procedure GetRequiredShareCapital(LoanProduct: Code[20]; LoanAmount: Decimal): Decimal
    var
        ShareCapitalBand: Record "Loan Share Capital Band";
        ProductSetup: Record "Product Setup";
    begin
        ShareCapitalBand.Reset();
        ShareCapitalBand.SetCurrentKey("Loan Product", "Minimum Amount", "Maximum Amount");
        ShareCapitalBand.SetRange("Loan Product", LoanProduct);
        ShareCapitalBand.SetFilter("Minimum Amount", '<=%1', LoanAmount);
        if ShareCapitalBand.FindSet() then
            repeat
                if (ShareCapitalBand."Maximum Amount" = 0) or (LoanAmount <= ShareCapitalBand."Maximum Amount") then
                    exit(ShareCapitalBand."Required Share Capital");
            until ShareCapitalBand.Next() = 0;

        if ProductSetup.Get(LoanProduct) then
            exit(ProductSetup."Appraisal Min. Shares");

        exit(0);
    end;

    local procedure GetMemberShareCapital(MemberNo: Code[20]): Decimal
    var
        Savings: Record "Savings Accounts";
        ShareCapitalBalance: Decimal;
    begin
        Savings.Reset();
        Savings.SetRange("Member No.", MemberNo);
        Savings.SetRange(Status, Savings.Status::Active);
        Savings.SetRange("Product Category", Savings."Product Category"::"Share Capital");
        if Savings.FindSet() then
            repeat
                Savings.CalcFields("Balance (LCY)");
                ShareCapitalBalance += Savings."Balance (LCY)";
            until Savings.Next() = 0;

        exit(ShareCapitalBalance);
    end;

    procedure GetLoanCharges(Var Ins: Decimal) Tcharges: Decimal;
    var
        PCharges: Record "Loan Product Charges.";
        PChAmt: Decimal;
        GL: Code[20];
        EDuty: Decimal;
        Members: Record Members;
        Continue: Boolean;
        LoanCharges: Record "Loan Charges";
        GenSetup: Record "Sacco Setup";
        MemberActivities: Codeunit "Member Activities";
        Value: Decimal;
        otherComm: Record "Other Committments Clearance";
        IsWaived: Boolean;
        PlatinumTopUpOfNonPlatinum: Boolean;
    begin
        Tcharges := 0;
        IsWaived := Rec."Fee Waiver Applied";
        PlatinumTopUpOfNonPlatinum := IsPlatinumTopUpOfNonPlatinumLoan();

        LoanCharges.Reset;
        LoanCharges.SetRange("Loan No.", "Appraisal No.");
        if LoanCharges.FindFirst then
            LoanCharges.DeleteAll;


        Ins := 0;
        "External Clearance Charges" := 0;


        GenSetup.Get;

        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
        PCharges.SetFilter(PCharges."Charge Type", '%1|%2', PCharges."Charge Type"::General, PCharges."Charge Type"::"Loan Processing Fee");
        if PCharges.Find('-') then begin
            repeat
                PChAmt := 0;
                GL := '';
                EDuty := 0;

                Value := "Recommended Amount";
                CalcFields("Total Principal Top Up");

                if PCharges."Charging Option" = PCharges."Charging Option"::"Amount to Disburse Less Topup" then begin
                    Value := "Amount To Disburse" - "Total Principal Top Up";
                end;
                //changes added on 092426 Cal0019
                if PCharges."Charging Option" = PCharges."Charging Option"::"Approved Amount Less Topup" then begin
                    Value := "Approved Amount" - "Total Principal Top Up";
                end;

                MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Value, PChAmt, EDuty, GL);

                if IsWaived then begin
                    PChAmt := 0;
                    EDuty := 0;
                end;

                if PCharges."Charge Type" = PCharges."Charge Type"::"Loan Processing Fee" then begin

                    if (Rec."Total Principal Top Up" = 0) and (Rec."Loan Product Type" <> 'L01') then begin
                        PChAmt := 0;
                        EDuty := 0;
                    end;
                end;

                LoanCharges.Init;
                LoanCharges."Loan No." := "Appraisal No.";
                LoanCharges."Loan Product Type" := "Loan Product Type";
                LoanCharges."Charge Code" := PCharges."Charge Code";
                LoanCharges."Charge %" := PCharges.Percentage;
                LoanCharges.Amount := PChAmt;
                LoanCharges."Excise Duty" := EDuty;
                LoanCharges."Total Charge" := PChAmt + EDuty;
                LoanCharges."Account Type" := PCharges."Account Type";
                LoanCharges."Account No." := PCharges."Account No.";
                LoanCharges."Posting Type" := PCharges."Posting Type";
                LoanCharges."Is Sms Charge" := PCharges."Is Sms Alert";
                LoanCharges."Charge Type" := PCharges."Charge Type";

                if PlatinumTopUpOfNonPlatinum then
                    LoanCharges.Description := CopyStr(PCharges.Description + ' - PLATINUM TOP-UP WAIVED', 1, MaxStrLen(LoanCharges.Description))
                else begin
                    if IsWaived and (PCharges."Charge Type" = PCharges."Charge Type"::"Loan Processing Fee") then
                        LoanCharges.Description := CopyStr(PCharges.Description + ' - WAIVED', 1, MaxStrLen(LoanCharges.Description))
                    else
                        LoanCharges.Description := PCharges.Description;
                end;


                if EDuty > 0 then begin
                    GenSetup.TestField("Excise Duty GL");
                    LoanCharges."Duty GL" := GenSetup."Excise Duty GL";
                end;
                LoanCharges.Insert;
                Tcharges += LoanCharges."Total Charge";

            until PCharges.Next = 0;
        end;

        Members.get("Member No.");
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", "Loan Product Type");
        PCharges.Setfilter(PCharges."Charge Type", '%1|%2|%3', PCharges."charge type"::Insurance, PCharges."charge type"::"External Clearance", PCharges."charge type"::Non_Individual);
        if PCharges.Find('-') then begin
            repeat
                //Message('%1: ', PCharges."Product Code");
                Continue := false;
                Value := "Amount To Disburse";

                if PCharges."Charging Option" = PCharges."Charging Option"::"Amount to Disburse Less Topup" then begin
                    CalcFields("Total Principal Top Up");
                    Value := "Amount To Disburse" - "Total Principal Top Up";
                end;
                //changes added on 092426 Cal0019
                if PCharges."Charging Option" = PCharges."Charging Option"::"Approved Amount Less Topup" then begin
                    Value := "Approved Amount" - "Total Principal Top Up";
                end;


                if Members."Account Category" = Members."Account Category"::Individual then begin
                    if Members.Type = Members.Type::Group then begin
                        if PCharges."Charge Type" = PCharges."Charge Type"::Non_Individual then
                            Continue := true;
                    end
                    else
                        // if Members.Type = Members.Type::Member then begin

                        if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                            Continue := true;
                    // end;

                end
                else begin

                    if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then
                        Continue := true;

                    if PCharges."Charge Type" = PCharges."Charge Type"::Non_Individual then
                        Continue := true;
                end;

                if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then
                    Continue := true;


                //Message('0-');


                //Message('Value B4 %1', Value);
                if Continue then begin


                    if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then begin
                        otherComm.Reset();
                        otherComm.SetRange("Loan Application No.", "Appraisal No.");
                        if otherComm.FindFirst() then begin
                            otherComm.CalcSums(Amount);
                            Value := otherComm.Amount;
                        end;
                    end;

                    PChAmt := 0;
                    GL := '';
                    EDuty := 0;

                    //Message('Value %1', Value);

                    MemberActivities.GetLoanChargeAmount("Loan Product Type", PCharges."Charge Code", PCharges."Charge Type", Value, PChAmt, EDuty, GL);

                    //Message('1-');
                    if PCharges."Charge Type" = PCharges."Charge Type"::Insurance then begin
                        //Message('Test');
                        // if "Member Type" <> "Member Type"::Staff then begin

                        PChAmt := PChAmt;/// * Period / 10;

                        Ins := PChAmt;

                        //Message('PCharges."Charge Type" %1 \ PCHamt %2', PCharges."Charge Type", PChAmt);
                        //end;
                    end;

                    if Pcharges."Charge Type" <> PCharges."charge type"::Insurance then begin
                        LoanCharges.Init;
                        LoanCharges."Loan No." := "Appraisal No.";
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

                        Tcharges += LoanCharges."Total Charge";


                        if PCharges."Charge Type" = PCharges."Charge Type"::"External Clearance" then begin
                            "External Clearance Charges" := LoanCharges."Total Charge";
                        end;
                    end;

                end;
            until PCharges.Next = 0;
        end;

    end;

    local procedure IsPlatinumTopUpOfNonPlatinumLoan(): Boolean
    var
        TopUp: Record "Appraisal Top Up";
        TopUpLoan: Record Loans;
        TopUpProductCode: Code[20];
    begin
        if not IsPlatinumLoanProduct("Loan Product Type") then
            exit(false);

        TopUp.Reset();
        TopUp.SetRange("Loan No.", "Appraisal No.");
        if TopUp.FindSet() then
            repeat
                TopUpProductCode := TopUp."Loan Type";
                if TopUpProductCode = '' then
                    if TopUpLoan.Get(TopUp."Loan Top Up") then
                        TopUpProductCode := TopUpLoan."Loan Product Type";

                if (TopUpProductCode <> '') and (not IsPlatinumLoanProduct(TopUpProductCode)) then
                    exit(true);
            until TopUp.Next() = 0;

        exit(false);
    end;

    local procedure IsPlatinumLoanProduct(ProductCode: Code[20]): Boolean
    begin
        exit((ProductCode = 'L09') or (ProductCode = 'L10'));
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

    procedure SetCEOComment(NewCEOComments: Text)
    var
        OutStream: OutStream;
    begin
        Clear("CEO Comments");
        "CEO Comments".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewCEOComments);
        Modify();
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

    procedure GetMemberAge(): Integer
    var
        Members: Record Members;
    begin
        if Members.Get(Rec."Member No.") then
            if Members."Date of Birth" <> 0D then
                exit(Date2DMY(Today, 3) - Date2DMY(Members."Date of Birth", 3));

        exit(0);
    end;

    procedure CheckAndSetFeeWaiverFlag(var LoanApp: Record "Member Salary Appraisal")
    var
        LoanSecurity: Record "Loan Security";
        MemberAccounts: Record "Savings Accounts";
        AvailableUncommittedDeposits: Decimal;
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
    begin
        LoanApp."Fee Waiver Applied" := false;

        if LoanApp."Approved Amount" <= 0 then
            exit;

        // Rule 1: Restructured
        if (LoanApp."Rescheduled Loan") or (LoanApp."Self Guarantee") then begin
            LoanApp."Fee Waiver Applied" := true;
            exit;
        end;


        // Rule 2: Consolidated + deposits cover the loan
        if LoanApp."Consolidated Loan" then begin
            MemberAccounts.Reset();
            MemberAccounts.SetRange("Member No.", LoanApp."Member No.");
            MemberAccounts.SetRange("Product Category", MemberAccounts."Product Category"::"Deposit Contribution");
            MemberAccounts.SetLoadFields("No.");
            if MemberAccounts.FindFirst() then begin
                LoanSecurity.CalculateAvailableShares(
                    MemberAccounts, DepAmt, GuaranteedInApplication,
                    Committed, AvailableUncommittedDeposits, true);

                if AvailableUncommittedDeposits >= LoanApp."Approved Amount" then
                    LoanApp."Fee Waiver Applied" := true;
            end;
        end;
    end;

    procedure HasSubType(): Boolean
    var
        ProductSubType: Record "Loan Sub. Types";
    begin
        ProductSubType.RESET;
        ProductSubType.SETRANGE("Loan Type", "Loan Product Type");
        ProductSubType.SETFILTER(ProductSubType."Product Sub. Type", '<>%1', ProductSubType."Product Sub. Type"::" ");
        EXIT(ProductSubType.FINDFIRST);
    end;

    procedure PopulateSubType()
    var
        ProductSubType: Record "Loan Sub. Types";
    begin
        IF HasSubType THEN BEGIN
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
                            Period := ProductSubType.Installement;

                    end;
                until ProductSubType.Next() = 0;
            end;
        END;
    end;


    procedure ApplyStaffLoanProductFilter()
    var
        StaffLoanProductFilter: Text;
    begin
        StaffLoanProductFilter := GetStaffLoanProductFilter();

        if StaffLoanProductFilter = '' then
            Error('No active credit loan product is marked as Staff Members in Product Setup.');

        //Rec.SetFilter("Loan Product Type", StaffLoanProductFilter);
    end;

    procedure GetStaffLoanProductFilter(): Text
    var
        ProductSetup: Record "Product Setup";
        ProductFilter: Text;
    begin
        ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange(Status, ProductSetup.Status::Active);
        ProductSetup.SetRange("Loan Clients", ProductSetup."Loan Clients"::"Staff Members");

        if ProductSetup.FindSet() then
            repeat
                if ProductFilter = '' then
                    ProductFilter := ProductSetup."Product ID"
                else
                    ProductFilter += '|' + ProductSetup."Product ID";
            until ProductSetup.Next() = 0;

        exit(ProductFilter);
    end;

    local procedure FetchLatestStaffPayrollDeductions(HREmp: Record "Staff Payroll Details")
    var
        PeriodTransaction: Record "Payroll Period Transactions";
        PayrollPeriod: Date;
        EmployeeNo: Code[20];
    begin
        if "Appraisal Type" <> "Appraisal Type"::Staff then
            exit;

        EmployeeNo := HREmp."Employee Code";

        if EmployeeNo = '' then
            Error('Employee Code is missing in Staff Payroll Details for staff no. %1.', "Staff No.");

        PayrollPeriod := GetLatestClosedPayrollPeriodWithTransactions(EmployeeNo);

        if PayrollPeriod = 0D then
            Error('No closed payroll period transactions were found for staff no. %1, employee code %2.', "Staff No.", EmployeeNo);

        ClearPayrollDeductionFields();

        PeriodTransaction.Reset();
        PeriodTransaction.SetRange("Employee Code", EmployeeNo);
        PeriodTransaction.SetRange("Payroll Period", PayrollPeriod);
        PeriodTransaction.SetRange("Entry Type", PeriodTransaction."Entry Type"::Employee);

        if PeriodTransaction.FindSet() then
            repeat
                ApplyPayrollTransactionToAppraisal(PeriodTransaction);
            until PeriodTransaction.Next() = 0;

        // If payroll did not have basic pay, fall back to Staff Payroll Details basic pay.
        if "Basic Pay" = 0 then
            "Basic Pay" := HREmp."Basic Pay";

        if "Gross Pay" = 0 then
            "Gross Pay" := "Basic Pay" + "House Allowance" + "Commuter Allowance" + "Other Allowances";

        if "Net Salary" = 0 then
            "Net Salary" :=
                "Gross Pay" -
                ("BOSA Loans Manual" +
                 "FOSA Loans Manual" +
                 Pension +
                 NSSF +
                 NHIF +
                 "Housing levy" +
                 "Other Deductions");
    end;

    local procedure GetLatestClosedPayrollPeriodWithTransactions(EmployeeNo: Code[20]): Date
    var
        PayrollPeriod: Record "Payroll Periods";
        PeriodTransaction: Record "Payroll Period Transactions";
    begin
        PayrollPeriod.Reset();
        PayrollPeriod.SetRange(Closed, false);
        if PayrollPeriod.FindLast() then
            exit(PayrollPeriod."Date Opened");

        exit(0D);
    end;

    local procedure ClearPayrollDeductionFields()
    begin
        "Basic Pay" := 0;
        "House Allowance" := 0;
        "Commuter Allowance" := 0;
        "Other Allowances" := 0;
        "Gross Pay" := 0;

        Tax := 0;
        Pension := 0;
        NSSF := 0;
        NHIF := 0;
        "Housing levy" := 0;

        //"BOSA Loans Manual" := 0;
        //"FOSA Loans Manual" := 0;
        //"Other Deductions" := 0;
    end;

    local procedure ApplyPayrollTransactionToAppraisal(PeriodTransaction: Record "Payroll Period Transactions")
    begin
        case PeriodTransaction.Grouping of
            PeriodTransaction.Grouping::"Basic Salary":
                begin
                    if (PeriodTransaction."Sub Group" = PeriodTransaction."Sub Group"::" ") or
                       (PeriodTransaction."Sub Group" = PeriodTransaction."Sub Group"::BasicPay) then
                        "Basic Pay" += PeriodTransaction.Amount
                    else
                        "Other Allowances" += PeriodTransaction.Amount;
                end;

            PeriodTransaction.Grouping::Allowances:
                "Other Allowances" += PeriodTransaction.Amount;

            PeriodTransaction.Grouping::"Gross Salary":
                "Gross Pay" += PeriodTransaction.Amount;

            PeriodTransaction.Grouping::Statutories:
                ApplyPayrollStatutoryToAppraisal(PeriodTransaction);

            PeriodTransaction.Grouping::Deductions:
                ApplyPayrollDeductionToAppraisal(PeriodTransaction);

            PeriodTransaction.Grouping::"Net Salary":
                "Net Salary" += PeriodTransaction.Amount;
        end;
    end;

    local procedure ApplyPayrollStatutoryToAppraisal(PeriodTransaction: Record "Payroll Period Transactions")
    begin
        case PeriodTransaction."Sub Group" of
            PeriodTransaction."Sub Group"::NSSF:
                NSSF += Abs(PeriodTransaction.Amount);

            PeriodTransaction."Sub Group"::NHIF:
                NHIF += Abs(PeriodTransaction.Amount);

            PeriodTransaction."Sub Group"::PAYE:
                Tax += Abs(PeriodTransaction.Amount);

            PeriodTransaction."Sub Group"::"Housing Levy":
                "Housing levy" += Abs(PeriodTransaction.Amount);
        end;
    end;

    local procedure ApplyPayrollDeductionToAppraisal(PeriodTransaction: Record "Payroll Period Transactions")
    var
        DeductionAmount: Decimal;
    begin
        if PeriodTransaction."Transaction Code" = 'TOT-DED' then
            exit;

        DeductionAmount := Abs(PeriodTransaction.Amount);

        if DeductionAmount = 0 then
            exit;

        if IsPensionTransaction(PeriodTransaction."Transaction Code") then begin
            Pension += DeductionAmount;
            exit;
        end;

        // If this payroll deduction is linked to a SACCO loan, classify it as BOSA/FOSA using the loan product source.
        if ApplyPayrollLoanDeductionToAppraisal(PeriodTransaction, DeductionAmount) then
            exit;

        // Anything else from payroll deductions goes to Other Deductions.
        "Other Deductions" += DeductionAmount;
    end;

    local procedure ApplyPayrollLoanDeductionToAppraisal(PeriodTransaction: Record "Payroll Period Transactions"; DeductionAmount: Decimal): Boolean
    var
        StaffLoan: Record Loans;
        StaffLoanProduct: Record "Product Setup";
    begin
        if PeriodTransaction."Loan No." = '' then
            exit(false);

        if not StaffLoan.Get(PeriodTransaction."Loan No.") then
            exit(false);

        if not StaffLoanProduct.Get(StaffLoan."Loan Product Type") then
            exit(false);

        case StaffLoanProduct."Loan Source" of
            StaffLoanProduct."Loan Source"::BOSA:
                "BOSA Loans Manual" += DeductionAmount;

            StaffLoanProduct."Loan Source"::FOSA:
                "FOSA Loans Manual" += DeductionAmount;

            else
                "Other Deductions" += DeductionAmount;
        end;

        exit(true);
    end;

    local procedure IsPensionTransaction(TransactionCode: Code[20]): Boolean
    begin
        exit(
            (TransactionCode = 'D001') or
            (TransactionCode = 'D020') or
            (TransactionCode = 'D002') or
            (TransactionCode = 'D017'));
    end;

    procedure CheckIncompleteSameProductAppraisal()
    var
        ExistingAppraisal: Record "Member Salary Appraisal";
    begin
        if ("Member No." = '') or ("Loan Product Type" = '') then
            exit;

        ExistingAppraisal.Reset();
        ExistingAppraisal.SetRange("Member No.", "Member No.");
        ExistingAppraisal.SetRange("Loan Product Type", "Loan Product Type");
        ExistingAppraisal.SetRange("Appraisal Completed", false);
        ExistingAppraisal.SetFilter(Status, '<>%1', ExistingAppraisal.Status::Rejected);
        if "Appraisal No." <> '' then
            ExistingAppraisal.SetFilter("Appraisal No.", '<>%1', "Appraisal No.");

        if ExistingAppraisal.FindFirst() then
            Error(
                'Member %1 already has incomplete loan appraisal %2 for loan product %3. Complete or cancel that appraisal before capturing another one. Rejected appraisals are allowed to be recreated.',
                "Member No.",
                ExistingAppraisal."Appraisal No.",
                "Loan Product Type");
    end;

    procedure CheckMultipleRunningLoanAllowed(LoanType: Record "Product Setup")
    var
        ExistingLoan: Record Loans;
        TopUp: Record "Appraisal Top Up";
    begin
        if ("Member No." = '') or ("Loan Product Type" = '') then
            exit;

        ExistingLoan.Reset();
        ExistingLoan.SetRange("Member No.", "Member No.");
        ExistingLoan.SetRange(Posted, true);
        ExistingLoan.SetRange("Loan Product Type", "Loan Product Type");
        ExistingLoan.SetFilter("Outstanding Principal", '>0');
        if ExistingLoan.FindSet() then
            repeat
                if LoanType."Allow Multiple Running Loans" then begin
                    if "Loan Product Type" <> 'L43' then
                        Message('Member already has an existing Loan %1 of same product', ExistingLoan."Loan No.");
                end else begin
                    TopUp.Reset();
                    TopUp.SetRange("Loan No.", "Appraisal No.");
                    TopUp.SetRange("Member No.", "Member No.");
                    TopUp.SetRange("Loan Top Up", ExistingLoan."Loan No.");
                    TopUp.SetFilter("Total Top Up", '>0');
                    if not TopUp.FindFirst() then
                        Error(
                            '%1 does not allow multiple running loans. Member %2 already has running loan %3 (%4). Refinance/top up the existing loan before proceeding.',
                            LoanType.Description,
                            "Member No.",
                            ExistingLoan."Loan No.",
                            ExistingLoan."Loan Product Type Name");
                end;
            until ExistingLoan.Next() = 0;
    end;

    procedure CheckRequestAmountAgainstDepositMuitplier()
    var
        DepositQualification: Decimal;
    begin
        if ("Member No." = '') or ("Loan Product Type" = '') or ("Requested Amount" <= 0) then
            exit;

        if not ProductSetup.Get("Loan Product Type") then
            exit;

        if (ProductSetup."Deposit Multiplier" <= 0) then
            exit;

        GetValues();

        DepositQualification := Rec."Deposit Multiplier";
        if DepositQualification < 0 then
            DepositQualification := 0;

        if "Requested Amount" > DepositQualification then
            Error(
                'Requested amount %1 exceeds the deposit qualification of %2. Deposits: %3, deposit multiplier: %4, existing BOSA loan balance: %5.',
                "Requested Amount",
                DepositQualification,
                "Share Deposits",
                ProductSetup."Deposit Multiplier",
                "BOSA Loan balance");
    end;

    var
        TotalMRepay: Decimal;
        DefaultDF: DateFormula;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        ShareBoostComm: Decimal;
        TTotalArrears: Decimal;
        "Shares Boosted": Boolean;
        DimMgt: Codeunit DimensionManagement;
        ClientAge: Text;
        ClientAgeValue: Integer;
        ClientAgePart: Text;
        ProdMinAgeText: Text;
        MemberAge: Integer;
        ProductSetup: Record "Product Setup";
        SavAcc: Record "Savings Accounts";
        Cust: Record Members;
        AccNo: Code[20];
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
        MicroDef: Text;
        GenSetup: Record "Sacco Setup";
        Loan: Record Loans;
        Members: Record Members;
        LoanType: Record "Product Setup";
        DisbProducts: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
        SaccoActivities: Codeunit "Sacco Activities";
        LSecurity: Record "Loan Security";

        Text001: Label 'You do not permission to Appraise loans. Please contact ICT';
        Text005: label 'This Member age is less than the limit of %1';
}

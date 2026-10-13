Table 55007 "Old Loans"
{
    // IF Installments <=0 THEN
    //  ERROR('Number of installments must be greater than Zero!');
    // 
    // IF LoanType.GET("Lease product type") THEN BEGIN
    // IF LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Reducing Balances" THEN BEGIN
    //   IF Interest = 0 THEN
    //     Repayment := ROUND("Loan Amount"/ Installments,0.0001,'>')
    //   ELSE
    //     Repayment := ROUND(DebtService("Loan Amount",Interest,Installments),0.0001,'>');
    // END;
    // END;
    // "Total Repayment":=Installments*Repayment;
    // //


    fields
    {
        field(1; "Loan  No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "Loan  No." <> xRec."Loan  No." then begin

                end;
            end;
        }
        field(2; "Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Application Date" > Today then
                    Error('Application date can not be in the future.');
            end;
        }
        field(3; "Loan Product Type"; Code[20])
        {
            Editable = true;
            //TableRelation = "Product Setup"."Product ID" where ("Product Class"=const(Credit));

        }
        field(4; "Member No."; Code[20])
        {
            //TableRelation = Member."No.";

        }
        field(5; "Group Code"; Code[20])
        {
        }
        field(6; Savings; Decimal)
        {
            Editable = false;
        }
        field(7; "Existing Loan"; Decimal)
        {
            Editable = false;
        }
        field(8; "Requested Amount"; Decimal)
        {

        }
        field(9; "Approved Amount"; Decimal)
        {
            Editable = true;

        }
        field(16; Interest; Decimal)
        {

        }
        field(17; Insurance; Decimal)
        {
            Editable = false;
        }
        field(21; "Source of Funds"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

        }
        field(22; "Client Cycle"; Integer)
        {
            Editable = false;
        }
        field(26; "Client Name"; Text[50])
        {
            Editable = false;
        }
        field(27; "Loan Status"; Option)
        {
            OptionMembers = Application,Appraisal,Rejected,Approved,Issued;
        }
        field(29; "Issued Date"; Date)
        {
        }
        field(30; Installments; Integer)
        {

        }
        field(34; "Loan Disbursement Date"; Date)
        {

        }
        field(35; "Mode of Disbursement"; Option)
        {
            OptionCaption = ' Individual Cheques,Cheque,Transfer to FOSA,FOSA Loans,M-Pesa,Partial Disbursement';
            OptionMembers = "Individual Cheques",Cheque,"Transfer to FOSA","FOSA Loans","M-Pesa","Partial Disbursement";
        }
        field(53; "Affidavit - Item 1 Details"; Text[100])
        {
            Enabled = false;
        }
        field(54; "Affidavit - Estimated Value 1"; Decimal)
        {
            Enabled = false;
        }
        field(55; "Affidavit - Item 2 Details"; Text[100])
        {
            Enabled = false;
        }
        field(56; "Affidavit - Estimated Value 2"; Decimal)
        {
            Enabled = false;
        }
        field(57; "Affidavit - Item 3 Details"; Text[100])
        {
            Enabled = false;
        }
        field(58; "Affidavit - Estimated Value 3"; Decimal)
        {
            Enabled = false;
        }
        field(59; "Affidavit - Item 4 Details"; Text[100])
        {
            Enabled = false;
        }
        field(60; "Affidavit - Estimated Value 4"; Decimal)
        {
            Enabled = false;
        }
        field(61; "Affidavit - Item 5 Details"; Text[100])
        {
            Enabled = false;
        }
        field(62; "Affidavit - Estimated Value 5"; Decimal)
        {
            Enabled = false;
        }
        field(63; "Magistrate Name"; Text[30])
        {
            Enabled = false;
        }
        field(64; "Date for Affidavit"; Date)
        {
            Enabled = false;
        }
        field(65; "Name of Chief/ Assistant"; Text[30])
        {
            Enabled = false;
        }
        field(66; "Affidavit Signed?"; Boolean)
        {
            Enabled = false;
        }
        field(67; "Date Approved"; Date)
        {
        }
        field(53048; "Grace Period"; DateFormula)
        {
        }
        field(53049; "Instalment Period"; DateFormula)
        {
        }
        field(53050; Repayment; Decimal)
        {

            trigger OnValidate()
            begin
                "Adjusted Loan Repayment" := xRec.Repayment;
                Advice := true;
            end;
        }
        field(53051; "Pays Interest During GP"; Boolean)
        {
        }
        field(53053; "Percent Repayments"; Decimal)
        {
            Editable = false;
        }
        field(53054; "Paying Bank Account No"; Code[20])
        {
            //TableRelation = "Bank Account"."No.";
        }
        field(53055; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            //TableRelation = "No. Series";
        }
        field(53056; "Loan Product Type Name"; Text[100])
        {
            Editable = false;
        }
        field(53057; "Cheque Number"; Code[20])
        {
        }
        field(53058; "Bank No"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = "Bank Account"."No.";
        }
        field(53059; "Slip Number"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53060; "Total Paid"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(53061; "Schedule Repayments"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Repayment" where("Loan No." = field("Loan  No."),
                                                                                   "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53062; "Doc No Used"; Code[10])
        {
        }
        field(53065; "Batch No."; Code[20])
        {

        }
        field(53066; "Edit Interest Rate"; Boolean)
        {
        }
        field(53067; Posted; Boolean)
        {
            Editable = true;
        }
        field(53068; "Product Code"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(53077; "Document No 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(53078; "Field Office"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Dimension Code"=const('FIELD OFFICE'));
        }
        field(53079; Dimension; Code[20])
        {
        }
        field(53080; "Amount Disbursed"; Decimal)
        {
        }
        field(53081; "Fully Disbursed"; Boolean)
        {
        }
        field(53082; "New Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(53083; "New No. of Instalment"; Integer)
        {
            Editable = false;
        }
        field(53084; "New Grace Period"; DateFormula)
        {
            Editable = false;
        }
        field(53085; "New Regular Instalment"; DateFormula)
        {
            Editable = false;
        }
        field(53086; "Loan Balance at Rescheduling"; Decimal)
        {
            Editable = false;
        }
        field(53087; "Loan Reschedule"; Boolean)
        {
        }
        field(53088; "Date Rescheduled"; Date)
        {
            Caption = 'Date Rescheduled';
        }
        field(53089; "Reschedule by"; Code[50])
        {
        }
        field(53090; "Flat Rate Principal"; Decimal)
        {
        }
        field(53091; "Flat rate Interest"; Decimal)
        {
        }
        field(53092; "Total Repayment"; Decimal)
        {
            Editable = false;
        }
        field(53093; "Interest Calculation Method"; Option)
        {
            OptionMembers = ,"No Interest","Flat Rate","Reducing Balances";
        }
        field(53094; "Edit Interest Calculation Meth"; Boolean)
        {
        }
        field(53095; "Balance BF"; Decimal)
        {
        }
        field(53099; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(53101; "Cheque Date"; Date)
        {
        }

        field(53103; "Loan to Share Ratio"; Decimal)
        {
        }
        field(53104; "Shares Balance"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(53105; "Max. Installments"; Integer)
        {
            Editable = false;
        }
        field(53106; "Max. Loan Amount"; Decimal)
        {
            Editable = false;
        }
        field(53107; "Loan Cycle"; Integer)
        {
            Editable = false;
        }
        field(53110; "Current Deposits- Long term"; Decimal)
        {
        }
        field(53112; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants,"Zero Interest";

        }
        field(53113; "Grace Period - Principle (M)"; Integer)
        {

            trigger OnValidate()
            begin
                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53114; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(53115; Adjustment; Text[100])
        {
        }
        field(53116; "Payment Due Date"; Text[100])
        {
        }
        field(53117; "Tranche Number"; Integer)
        {
        }
        field(53118; "Amount Of Tranche"; Decimal)
        {
        }
        field(53119; "Total Disbursment to Date"; Decimal)
        {
        }
        field(53133; "Copy of ID"; Boolean)
        {
        }
        field(53134; Contract; Boolean)
        {
        }
        field(53135; Payslip; Boolean)
        {
        }
        field(53136; "Contractual Shares"; Decimal)
        {
        }
        field(53184; "Appraisal Status"; Option)
        {
            OptionCaption = 'Expresion of Interest,Desk Appraisal,Loan form purchased,Loan Officer Approved,Management Approved,Credit Subcommitee Approved,Trust Board Approved';
            OptionMembers = "Expresion of Interest","Desk Appraisal","Loan form purchased","Loan Officer Approved","Management Approved","Credit Subcommitee Approved","Trust Board Approved";

            trigger OnValidate()
            begin
                if "Appraisal Status" = "appraisal status"::"Management Approved" then begin
                    if "Requested Amount" > 5000000 then
                        Error('Management can only approve a request below or equal to 5,000,000.')
                    else
                        "Loan Status" := "loan status"::Appraisal;

                end;

                if "Appraisal Status" = "appraisal status"::"Credit Subcommitee Approved" then begin
                    if "Requested Amount" > 10000000 then
                        Error('Creit Subcommittee can only approve a request below or equal to 10,000,000.')
                    else
                        "Loan Status" := "loan status"::Appraisal;

                end;

                if "Appraisal Status" = "appraisal status"::"Trust Board Approved" then
                    "Loan Status" := "loan status"::Appraisal;
            end;
        }
        field(53189; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(53190; "Repayment Start Date"; Date)
        {
        }
        field(53191; "Installment Including Grace"; Integer)
        {

            trigger OnValidate()
            begin
                if "Installment Including Grace" > "Max. Installments" then
                    Error('Installments cannot be greater than the maximum installments.');

                Installments := "Installment Including Grace" - "Grace Period - Principle (M)"
            end;
        }
        field(53193; "Schedule Interest"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53195; "Schedule Interest to Date"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Interest" where("Loan No." = field("Loan  No."),
                                                                                  "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(53196; "Repayments BF"; Decimal)
        {
        }
        field(68000; "Disbursement Account No"; Code[20])
        {
            Editable = true;

        }
        field(68001; "BOSA No"; Code[20])
        {
            //TableRelation = "SACCO Account";
        }
        field(68002; "Staff No"; Code[20])
        {
            Editable = false;

        }
        field(68003; "BOSA Loan Amount"; Decimal)
        {
        }
        field(68005; "Loan Received"; Boolean)
        {
        }
        field(68006; "Period Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68011; "Document No. Filter"; Code[100])
        {
            FieldClass = FlowFilter;
        }
        field(68012; "Cheque No."; Code[20])
        {
        }
        field(68013; "Personal Loan Off-set"; Decimal)
        {
        }
        field(68014; "Old Account No."; Code[20])
        {
        }
        field(68015; "Loan Principle Repayment"; Decimal)
        {

            trigger OnValidate()
            begin
                Repayment := "Loan Principle Repayment" + "Loan Interest Repayment";
                Advice := true;
                Validate(Repayment);
            end;
        }
        field(68016; "Loan Interest Repayment"; Decimal)
        {
        }
        field(68017; "Contra Account"; Code[20])
        {
        }
        field(68018; "Transacting Branch"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(68019; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(68020; "Net Income"; Decimal)
        {
        }
        field(68021; "No. Of Guarantors"; Integer)
        {
            CalcFormula = count("Loan Guarantors" where("Loan No" = field("Loan  No."),
                                                         Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(68022; "Total Loan Guaranted"; Decimal)
        {
            CalcFormula = sum("Loan Guarantors".Shares where("Loan No" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(68023; "Shares Boosted"; Boolean)
        {
        }
        field(68024; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Net Income":=("Basic Pay"+"House Allowance"+"Other Allowance"+"Cleared Effects")-"Total Deductions";
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68025; "House Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68026; "Other Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68027; "Total Deductions"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68028; "Cleared Effects"; Decimal)
        {

            trigger OnValidate()
            begin
                //"Net Income":=("Basic Pay"+"House Allowance"+"Other Allowance"+"Milage Allowance"+"Transport Allowance"+"Other Benefits")
                //-"Total Deductions";
            end;
        }
        field(68029; Remarks; Text[60])
        {
        }
        field(68030; Advice; Boolean)
        {
        }
        field(68032; "Bridging Loan Posted"; Boolean)
        {
        }
        field(68033; "BOSA Loan No."; Code[20])
        {
            ////TableRelation = Loans."Loan  No.";
        }
        field(68034; "Adjusted Loan Repayment"; Decimal)
        {
            Description = '// bandari loan adjustment';
        }
        field(68035; "No Loan in MB"; Boolean)
        {
        }
        field(68036; "Recovered Balance"; Decimal)
        {
        }
        field(68037; "Recon Issue"; Boolean)
        {
        }
        field(68038; "Loan Purpose 1"; Text[50])
        {
            ////TableRelation = "Loans Purpose".Code;
        }
        field(68039; Reconciled; Boolean)
        {
        }
        field(68040; "Appeal Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if Posted = false then
                    Error('Appeal only applicable for issued loans.');
                "Approved Amount" := "Appeal Amount" + "Approved Amount";
                Validate("Approved Amount");
            end;
        }
        field(68041; "Appeal Posted"; Boolean)
        {
        }
        field(68043; "Project Account No"; Code[20])
        {
        }
        field(68046; "Discounted Amount"; Decimal)
        {
            Editable = false;
        }
        field(68047; "Transport Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Mileage Allowance" := 0;
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68048; "Mileage Allowance"; Decimal)
        {

            trigger OnValidate()
            begin
                "Transport Allowance" := 0;
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance") - "Total Deductions";
            end;
        }
        field(68049; "System Created"; Boolean)
        {
        }
        field(68050; "Boosting Commision"; Decimal)
        {
        }
        field(68051; "Voluntary Deductions"; Decimal)
        {
        }
        field(68052; "4 % Bridging"; Boolean)
        {

            trigger OnValidate()
            begin
                //IF CONFIRM('Are you sure you want to charge 7.5%') = TRUE THEN
            end;
        }
        field(68054; Defaulted; Boolean)
        {
        }
        field(68055; "Bridging Posting Date"; Date)
        {
        }
        field(68056; "Commitements Offset"; Decimal)
        {
        }
        field(68057; Gender; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(68058; "Captured By"; Code[50])
        {
        }
        field(68059; "Branch Code"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
            //ValidateTableRelation = false;
        }
        field(68060; "Recovered From Guarantor"; Boolean)
        {
        }
        field(68061; "Guarantor Amount"; Decimal)
        {
        }
        field(68062; "External EFT"; Boolean)
        {

        }
        field(68063; "Defaulter Overide Reasons"; Text[150])
        {
        }
        field(68064; "Defaulter Overide"; Boolean)
        {


        }
        field(68066; "Other Benefits"; Decimal)
        {

            trigger OnValidate()
            begin
                "Net Income" := ("Basic Pay" + "House Allowance" + "Other Allowance" + "Mileage Allowance" + "Transport Allowance" + "Other Benefits")
                - "Total Deductions";
            end;
        }
        field(68067; "Recovered Loan"; Code[20])
        {
            ////TableRelation = Loans."Loan  No.";
        }
        field(68068; "1st Notice"; Date)
        {
        }
        field(68069; "2nd Notice"; Date)
        {
        }
        field(68070; "Final Notice"; Date)
        {
        }
        field(68072; "Last Advice Date"; Date)
        {
        }
        field(68073; "Advice Type"; Option)
        {
            OptionMembers = " ","Fresh Loan",Adjustment,Reintroduction,Stoppage;
        }
        field(68090; "Compound Balance"; Decimal)
        {
        }
        field(68091; "Repayment Rate"; Decimal)
        {
        }
        field(68092; "Exp Repay"; Decimal)
        {
        }
        field(68093; "ID NO"; Code[20])
        {

        }
        field(68094; RAmount; Decimal)
        {
        }
        field(68095; "Employer Code"; Code[50])
        {
        }
        field(68097; "Lst LN1"; Boolean)
        {
        }
        field(68098; "Lst LN2"; Boolean)
        {
        }
        field(68099; "Last loan"; Code[20])
        {
        }
        field(69000; "Loans Category"; Option)
        {
            OptionCaption = 'Perfoming,Watch1,Watch2,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch1,Watch2,Substandard,Doubtful,Loss;
        }
        field(69001; "Loans Category-SASRA"; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69002; "Qualifying Repayment"; Decimal)
        {
            Description = '>Bandari Sacco-To capture Recomended amount Monthly repayment';
        }
        field(69003; "Net Amount"; Decimal)
        {
        }
        field(69004; "Bank code"; Code[10])
        {
            //TableRelation = Banks;

            trigger OnValidate()
            begin
                /*banks.RESET;
                banks.SETRANGE(banks.Code,"Bank code");
                
                IF  banks.FIND('-') THEN BEGIN
                
                "Bank code":=banks.Code;
                "Bank Name":=banks."Bank Name";
                "Bank Branch":=banks.Branch;
                
                Loan.MODIFY;
                END;*/

            end;
        }
        field(69005; "Bank Name"; Text[150])
        {
        }
        field(69006; "Bank Branch"; Text[150])
        {
        }

        field(69012; Defaulter; Boolean)
        {
        }
        field(69013; DefaulterInfo; Text[50])
        {
        }
        field(69014; "Total Earnings(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69015; "Total Deductions(Salary)"; Decimal)
        {
            FieldClass = Normal;
        }
        field(69016; "Share Purchase"; Decimal)
        {
        }
        field(69017; "Currency Code"; Code[30])
        {
        }
        field(69018; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            //TableRelation = Currency;
        }
        field(69021; "Appln. between Currencies"; Option)
        {
            Caption = 'Appln. between Currencies';
            OptionCaption = 'None,EMU,All';
            OptionMembers = "None",EMU,All;
        }
        field(69022; "Expected Date of Completion"; Date)
        {
        }
        field(69023; "Total Schedule Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Repayment" where("Loan No." = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69024; "Recovery Mode"; Option)
        {
            OptionCaption = ' ,Checkoff,Salary,Dividend,Salary Arrears';
            OptionMembers = " ",Checkoff,Salary,Dividend,"Salary Arrears";
        }
        field(69025; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly,Yearly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly,Yearly;

            trigger OnValidate()
            begin
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    Evaluate("Instalment Period", '1D')
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        Evaluate("Instalment Period", '1W')
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            Evaluate("Instalment Period", '1M')
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                Evaluate("Instalment Period", '1Q');
            end;
        }
        field(69026; "Approval Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69027; "Old Vendor No"; Code[20])
        {
        }
        field(69028; "Total Loans Default"; Decimal)
        {
        }
        field(69029; "Installment Defaulted"; Decimal)
        {
        }
        field(69032; "Has BLA"; Boolean)
        {
        }
        field(69035; "Expected Repayment"; Decimal)
        {
            CalcFormula = sum("Loan Repayment Schedule"."Monthly Repayment" where("Loan No." = field("Loan  No."),
                                                                                   "Repayment Date" = field("Date filter")));
            FieldClass = FlowField;
        }
        field(69037; "Entry Type"; Option)
        {
            Description = '//>Oketch Determine the kind of entry type for adjusted repayment on check off advice';
            OptionCaption = 'Insertion,Modification,Deletion';
            OptionMembers = Insertion,Modification,Deletion;
        }
        field(69038; "Cleared Date"; Date)
        {
            Description = '//Aziz - Assist in identifying Loans Cleared through receipts for Monthly Advice Purposes';
        }
        field(69039; "Reject Loan"; Boolean)
        {

            trigger OnValidate()
            begin

                if "Reject Loan" then begin
                    if "Loan Rejection Reason" = '' then
                        Error('Please enter the Rejection Reason')
                    else
                        "Loan Status" := "loan status"::Rejected;
                end
                else begin
                    "Loan Status" := "loan status"::Application;
                    "Loan Rejection Reason" := '';

                end;
            end;
        }
        field(69040; "Loan Rejection Reason"; Text[50])
        {

        }
        field(69041; "Urgent Loan"; Boolean)
        {
        }
        field(69045; "Master Loan No."; Code[10])
        {
            Description = '//Aziz - to hold Master Loan No for partially disbursed loans';
            // //TableRelation = "Partial Disbursment Table"."Loan No.";

        }
        field(69046; "Partial Disbursement"; Boolean)
        {
        }
        field(69047; "Partial Amount Disbursed"; Decimal)
        {

            trigger OnValidate()
            begin

                if not "Partial Disbursement" then
                    Error('This Loan Application is not set for Partial Disbursment');
            end;
        }
        field(69048; "Recommended Amount"; Decimal)
        {
        }
        field(69049; "Responsibility Center"; Code[20])
        {
            Description = '//Cyrus- Must be standard on all Databases';
            // //TableRelation = "Responsibility Center BR";
        }
        field(69050; "Application SMS sent"; Boolean)
        {
            Description = '//Cyrus- Prevent double sending of SMS to the member incase the loan is open';
        }
        field(69051; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("Loan  No.")));
            FieldClass = FlowField;
        }
        field(69052; "payslip month"; Option)
        {
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(69053; "Speed Charge"; Boolean)
        {
        }
        field(69057; "Last Interest Calc Date"; Date)
        {
            Description = '//daudi bandari';
        }
        field(69058; "Interest Buffer"; Decimal)
        {
        }
        field(69059; "Loan Purpose 2"; Text[50])
        {
            //TableRelation = "Loans Purpose".Code;
        }
        field(69060; "Loan Purpose 3"; Text[50])
        {
            //TableRelation = "Loans Purpose".Code;
        }
        field(69061; "Account Exists"; Boolean)
        {
        }
        field(69062; "Loan Account"; Code[20])
        {
            Editable = true;
            //TableRelation = "SACCO Account"."No.";
        }
        field(69063; "Loan Span"; Option)
        {
            OptionCaption = ' ,Short Term,Long Term';
            OptionMembers = " ","Short Term","Long Term";
        }
        field(69064; "Recovery Priority"; Integer)
        {
        }
        field(69065; "Current Deposits- Short term"; Decimal)
        {
        }
        field(69066; Refference; Code[20])
        {
        }
        field(69067; "Tax Excempt"; Boolean)
        {
        }
        field(69069; "Imported Last Pay Date"; Date)
        {
        }
        field(69071; Appraisal; Boolean)
        {
        }
        field(69074; Disclaimer; Text[150])
        {
        }
        field(69077; "Client Code"; Integer)
        {
        }
        field(69079; "Last Alert Sent(Days)"; Integer)
        {
        }
        field(69080; "Msacco Penalty Charged"; Boolean)
        {
        }
        field(69081; "Recovered from Deposits"; Boolean)
        {
        }
        field(69082; "Offset Document No."; Text[30])
        {
        }
        field(69083; "Picked Mobile Loan"; Boolean)
        {
        }
        field(69084; "Sasra Main"; Code[10])
        {
            ////TableRelation = "SASRA Main Sector"."Main Code";
        }
        field(69085; "Sasra Sub I"; Code[10])
        {
            ////TableRelation = "SASRA Sub Sector I"."Sub Code" where ("Main Code"=field("Sasra Main"));
        }
        field(69086; "Sasra Sub II"; Code[10])
        {
        }
        field(69087; "Dept Collector Loan"; Boolean)
        {
        }
        field(69088; "Dated Markd Debtor Collector"; Date)
        {
        }
        field(69089; "User Marked Debtor Collector"; Code[50])
        {
        }
        field(69090; "Portfolio Manager"; Code[50])
        {
            //TableRelation = "User Setup"."User ID";
        }
        field(69091; "Int Billing Stopped"; Boolean)
        {
        }
        field(69092; "Int Billing Date Stopped"; Date)
        {
        }
        field(69093; "Int Stopped By"; Text[70])
        {
        }
        field(69094; "Int Started By"; Text[70])
        {
        }
        field(69095; "Int Started Date"; Date)
        {
        }
        field(69096; "IFRS Stage"; Option)
        {
            OptionCaption = ' ,Stage 1,Stage 2,Stage 3';
            OptionMembers = " ","Stage 1","Stage 2","Stage 3";
        }
        field(69098; "Defaulter SMS Date"; Date)
        {
        }
        field(69099; "Interest Paid"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan  No.")
        {
            Clustered = true;
        }
        key(Key2; Posted)
        {
        }
        key(Key3; "Loan Product Type")
        {
            SumIndexFields = "Requested Amount";
        }
        key(Key4; Source, "Member No.", "Loan Product Type", "Issued Date")
        {
        }
        key(Key5; "Batch No.", Source, "Loan Status", "Loan Product Type")
        {
            SumIndexFields = "Approved Amount", "Appeal Amount";
        }
        key(Key6; "BOSA Loan No.", "Disbursement Account No", "Batch No.")
        {
        }
        key(Key7; "Old Account No.")
        {
        }
        key(Key8; "Member No.", "Loan  No.")
        {
            SumIndexFields = Interest;
        }
        key(Key9; "Staff No")
        {
        }
        key(Key10; "BOSA No")
        {
        }
        key(Key11; "Loan Product Type", "Member No.", Posted)
        {
        }
        key(Key12; "Member No.", "Loan Product Type", Posted, "Issued Date")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key13; "Loan Product Type", "Application Date", Posted)
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key14; Source, "Mode of Disbursement", "Issued Date", Posted)
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key15; "Issued Date", "Loan Product Type")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key16; "Application Date")
        {
        }
        key(Key17; "Disbursement Account No")
        {
            SumIndexFields = "Approved Amount";
        }
        key(Key18; "Loan Product Type", "Loan Disbursement Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan  No.", "Loan Product Type", "Member No.", "Approved Amount")
        {
        }
    }

    trigger OnDelete()
    begin

        if "Loan Status" = "loan status"::Approved then
            Error('A loan cannot be deleted once it has been approved');
    end;

    trigger OnModify()
    begin
        /*
         IF ("Loan Status"="Loan Status"::Approved) AND ("Batch No."='')  THEN
         ERROR('A loan cannot be modified once it has been approved');
        
        IF "Batch No."<>'' THEN BEGIN
        IF LoansBatches.GET("Batch No.") THEN BEGIN
        IF LoansBatches.Status<>LoansBatches.Status::Open THEN
        ERROR('You cannot modify the loan because the batch is already %1',LoansBatches.Status);
        END;
        END;
        */
        /*
  //Check overwriting
  IF ("Loan Status"=xRec."Loan Status") AND (USERID<>"Captured By") THEN
  ERROR('This loan no. %1 is open for %2 and cannot modify',"Loan  No.","Captured By");
          */

    end;
}
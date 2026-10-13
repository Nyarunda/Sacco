

/// <summary>
/// Table Loan Security (ID 50113).
/// </summary>
Table 50558 "Loan Security II"
{
    DrillDownPageID = "Loan Security";
    LookupPageID = "Loan Security";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }

        field(50002; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = if ("Guarantor Type" = const(Guarantor)) "Savings Accounts"."No." where("Product Category" = filter("Deposit Contribution" | "Micro Member Deposit" | "Micro Group Deposit" | "Fixed Deposit"), Status = filter(Active | Dormant))
            else
            if ("Guarantor Type" = const(Collateral)) Members."No."
            else
            if ("Guarantor Type" = const(Lien)) "Savings Accounts"."No." where("Product Category" = filter("Fixed Deposit" | Business | "Ordinary Savings" | "Junior Savings" | "Unallocated Fund" | "MFI Deposit" | Jiajiri | Investment), Status = filter(Active | Dormant));

            trigger OnLookup()
            begin

            end;

            trigger OnValidate()
            var
                LSecurity: Record "Loan Security";
            begin

                "SMS Sent" := false;

                GenSetUp.Get;

                "Self Guarantee" := false;
                SelfGuaranteedA := 0;
                Date := Today;


                Staff_Board := false;
                /* 
                LoanSec.Reset();
                 LoanSec.SetRange("Account No.", Rec."Account No.");
                 if LoanSec.FindSet() then
                     repeat
                         LoansR.Reset();
                         LoansR.SetRange("Loan No.", LoanSec."Loan No.");
                         LoansR.SetRange(Posted, false);
                         if LoansR.FindFirst() then
                             Message('Their is an existing loan application No.%1 with %2 as a guarantor.', LoansR."Loan No.", LoanSec.Name);

                     until LoanSec.Next() = 0;
                 */

                //Set Member Guaranteed
                if LoansR.Get("Loan No.") then begin
                    "Member Guaranteed" := LoansR."Member No.";
                    "Loanee Name" := LoansR."Member Name";
                    if Members.Get(LoansR."Member No.") then
                        if (Members."Member Category" = Members."member category"::"Board Members") or
                          (Members."Member Category" = Members."member category"::"Staff Members") then
                            Staff_Board := true;
                end;

                if "Guarantor Type" = "guarantor type"::Guarantor then begin

                    //Evaluate guarantor basic info
                    if Savings.Get("Account No.") then begin
                        if Members."No." = Savings."Member No." then
                            "Self Guarantee" := true;

                        Members.TestField("Block Guarantorship", false);

                        LoansR.Reset;
                        LoansR.SetRange("Member No.", Savings."Member No.");
                        LoansR.SetFilter("Outstanding Principal", '>0');
                        //LoansR.SetFilter("Loans Category-SASRA", '<>%1', LoansR."loans category-sasra"::Perfoming);
                        if LoansR.FindFirst then begin
                            repeat
                                LoansR.CalcFields("Principal Arrears");
                                "Gua. Arrears" += LoansR."Principal Arrears";
                            until LoansR.Next() = 0;
                        end;

                        // if "Gua. Arrears" > 0 then
                        //    Message('Member has defaulted loan %1, Arrears %2', LoansR."Loan Product Type", LoansR."Principal Arrears");

                        if Savings.Status <> Savings.Status::Active then
                            Error('Member No. %1 is not an Active Member', Savings."No.");

                        Members.Get(Savings."Member No.");

                        if Employer.Get(Members."Employer Code") then begin

                            if Employer."Cannot Guarantee" then
                                Error('Members under %1 are not allowed to Guarantee', Employer.Name);
                        end;

                        "Gua. Employer Code" := Members."Employer Code";
                        "Gua. Status" := Format(Members.Status);

                        Savings.CalcFields(Savings."Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");
                        Name := Savings.Name;
                        "ID No." := Savings."ID No.";
                        "Staff/Payroll No." := Savings."Payroll/Staff No.";
                        "Guarantor Deposits" := Savings."Balance (LCY)";
                        "Current Guarantor Deposits" := Savings."Balance (LCY)";
                        "Gua. Employer Code" := Savings."Employer Code";

                        //if GenSetUp."Guarantors Multiplier" > 0 then
                        // "Guarantor Deposits" := Savings."Balance (LCY)" * GenSetUp."Guarantors Multiplier";


                        /* DimVal.Reset();
                         DimVal.SetRange(Code, Members."Global Dimension 2 Code");
                         DimVal.SetFilter("Guarantor Multiplier", '>0');
                         if DimVal.FindFirst() then begin
                             "Guarantor Deposits" := Savings."Balance (LCY)" * DimVal."Guarantor Multiplier";
                         end;*/

                        "ID No." := Savings."ID No.";
                        "Member No" := Savings."Member No.";


                        //"Available Guarantorship"=CalculateAvailableShares(Savings,"Guarantor Deposits","Application Amount Guaranteed","Total Guarantor Commitment","Available Guarantorship");


                        CalculateAvailableShares(Savings, "Deposit Multiplier", "Application Amount Guaranteed", "Total Guarantor Commitment", "Available Guarantorship", "Self Guarantee");

                        if "Available Guarantorship" < 0 then
                            "Available Guarantorship" := 0;

                    end;

                end
                else
                    if "Guarantor Type" = "guarantor type"::Collateral then begin
                        if Members.Get("Account No.") then begin

                            Name := Members.Name;
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            "ID No." := Members."ID No.";
                            "Member No" := "Account No.";

                        end;
                    end
                    else begin
                        if Savings.Get("Account No.") then begin
                            if Savings.Status <> Savings.Status::Active then
                                Error('Member No. %1 is not an Active Member', Savings."No.");

                            Savings.CalcFields("Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");

                            Name := Savings.Name;
                            "Staff/Payroll No." := Savings."Payroll/Staff No.";
                            "Guarantor Deposits" := MemberActivities.GetAccountBalance(Savings."No.");
                            "Gua. Employer Code" := Savings."Employer Code";
                            "Current Guarantor Deposits" := Savings."Balance (LCY)";
                            "ID No." := Savings."ID No.";
                            "Staff/Payroll No." := Savings."Payroll/Staff No.";
                            "Staff/Payroll No." := Savings."Payroll/Staff No.";
                            "Member No" := Savings."Member No.";
                            "Application Amount Guaranteed" := MemberActivities.GetMemberCommittedLien("Account No.", false);
                            "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetMemberCommittedLien("Account No.", true);
                            "Available Guarantorship" := "Guarantor Deposits";// - "Total Guarantor Commitment";

                            if "Available Guarantorship" < 0 then
                                "Available Guarantorship" := 0;
                            //"Amount Guaranteed":=Savings."Lien Placed";

                        end;
                    end;



                if LoanApp.Get("Loan No.") then begin

                    if not GenSetUp."Staff Can Guarantee Loan" then
                        if LoanApp."Member No." <> "Member No" then begin
                            if not Staff_Board then begin
                                if Members.Get("Member No") then
                                    if (Members."Member Category" = Members."member category"::"Board Members") or
                                      (Members."Member Category" = Members."member category"::"Staff Members") then
                                        Error('Staff/Board cannot Guarantee a Loan');
                            end;
                        end;


                    Loans.Reset;
                    Loans.SetRange("Member No.", LoanApp."Member No.");
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            //MESSAGE('0');
                            Loans.CalcFields("Outstanding Principal");
                            LoanTopUp.Reset;
                            LoanTopUp.SetRange("Loan No.", "Loan No.");
                            LoanTopUp.SetRange("Member No.", LoanApp."Member No.");
                            LoanTopUp.SetRange("Loan Top Up", Loans."Loan No.");
                            if LoanTopUp.FindFirst then begin
                                //MESSAGE('1');;
                                //MESSAGE('y%1',Loans."Outstanding Balance");
                                if Loans."Member No." = "Member No" then begin
                                    "Available Guarantorship" += LoanTopUp."Principle Top Up";
                                end
                                else begin
                                    //  MESSAGE('t1');
                                    LoanSec.Reset;
                                    LoanSec.SetRange("Loan No.", LoanTopUp."Loan Top Up");
                                    LoanSec.SetFilter("Account No.", '%1', "Account No.");
                                    if LoanSec.FindFirst then begin
                                        "Available Guarantorship" += LoanSec."Current Committed";

                                    end;
                                end;
                            end;
                        until Loans.Next = 0;
                    end;
                end;
            end;
        }
        field(50003; Name; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Guarantor Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Guarantor Deposits"; Decimal)
        {
            Caption = 'Total Deposits';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("Account No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)
                                                            ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; Substituted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Emp: Record Customer;
                Members: Record Members;
                CheckControl: Boolean;
            begin
                "SMS Sent" := false;
                CheckControl := false;
                Members.get("Member no");
                if Members."Employer Code" = '' then begin
                    CheckControl := true;
                end
                else begin
                    if Emp.get(Members."Employer Code") then begin
                        if not Emp."Remove Loan Restriction" then begin

                            CheckControl := true;
                        end;
                    end
                    else begin
                        CheckControl := true;
                    end;
                end;

                if CheckControl then begin

                    //if "Amount Guaranteed" > "Available Guarantorship" then
                    if "Amount Guaranteed" > "Available Guarantorship" then
                        Error(
                            'Security amount exceeds available guarantorship.\Loan No.: %1\Guarantor Type: %2\Member No.: %3\Name: %4\Account No.: %5\Collateral No.: %6\Amount Entered: %7\Available Guarantorship: %8',
                            "Loan No.", "Guarantor Type", "Member No", Name, "Account No.", "Collateral Reg. No.", "Amount Guaranteed", "Available Guarantorship");

                    if "Guarantor Type" = "Guarantor Type"::Guarantor then
                        if "Amount Guaranteed" > "Current Guarantor Deposits" then
                            Error('You cannot guarantee more than the your deposit of %1', "Current Guarantor Deposits");
                end;

                "Current Committed" := "Amount Guaranteed";
                SendAnSmsToTheGuarantor();
                CollateralHistory;

            end;
        }
        field(50012; "Staff/Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    Savings.Reset();
                    Savings.SetRange("Payroll/Staff No.", Rec."Staff/Payroll No.");
                    Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
                    if Savings.FindFirst() then begin
                        if Confirm(Savings.Name + ' ??') then begin
                            Validate("Account No.", Savings."No.");
                        end;
                    end;
                end;

            end;
        }
        field(50014; "Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "ID No."; Code[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    Savings.Reset();
                    Savings.SetRange("ID No.", "ID No.");
                    Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
                    if Savings.FindFirst() then begin
                        if Confirm(Savings.Name + ' ??') then begin
                            Validate("Account No.", Savings."No.");
                        end;
                    end;
                end;

            end;
        }
        field(50016; "Outstanding Principal"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry".Amount where("Loan No." = field("Loan No."),
                                                                "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment"),
                                                                "User ID" = filter(<> ''),
                                                                Amount = filter(<> 0),
                                                                "Amount (LCY)" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(50057; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry".Amount where("Loan No." = field("Loan No."),
                                                                "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                "User ID" = filter(<> ''),
                                                                Amount = filter(<> 0),
                                                                "Amount (LCY)" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(50017; "Member Guaranteed"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Total Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Available Guarantorship"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50022; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin
                    Savings.Reset();
                    Savings.SetRange("Member No.", "Member No");
                    Savings.SetRange("Product Category", Savings."Product Category"::"Deposit Contribution");
                    if Savings.FindFirst() then begin
                        // if Confirm(Savings.Name + ' ??') then begin
                        Validate("Account No.", Savings."No.");
                        //end;
                    end;
                end;

            end;
        }
        field(50023; "Loan Type"; Code[20])
        {
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50024; "Loan Type Name"; Text[50])
        {
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50025; "Loanee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Guarantor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Guarantor,Collateral,Lien';
            OptionMembers = Guarantor,Collateral,Lien;
        }
        field(50027; "Collateral Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Guarantor Type" = const(Collateral)) "Loan Collateral Register" where(Status = const(Approved),
                                                                                                      "Inward/Outward" = const("In-Store"),
                                                                                                      "Account No." = field("Member No"));

            trigger OnValidate()
            begin


                if SecReg.Get("Collateral Reg. No.") then begin
                    TestField("Guarantor Type", "guarantor type"::Collateral);
                    SaccoSetup.Get;
                    if SaccoSetup."Collateral % of Limit To Use" <= 0 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    if SaccoSetup."Collateral % of Limit To Use" > 100 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    "Guarantor Deposits" := ROUND(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);
                    "Collateral Value" := SecReg."Collateral Value";
                    "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateral("Collateral Reg. No.", false);
                    "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateral("Collateral Reg. No.", true);
                    "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";

                    "Security Details" := SecReg."Collateral Description";


                    if "Available Guarantorship" < 0 then
                        "Available Guarantorship" := 0;

                    if SecReg."Insurance Expiry Date" <> 0D then
                        if SecReg."Insurance Expiry Date" <= Today then
                            Error('Collateral Insurance Date has passed');

                    if SecReg."Next Valuation Date" <> 0D then
                        if SecReg."Next Valuation Date" <= Today then
                            Error('Collateral Next Valuation is due, kindly revalue to continue!');

                    if SecReg."Valuation Type" = SecReg."valuation type"::" " then begin
                        //IF SecReg."Next Valuation Date" <= TODAY THEN
                        // ERROR('Next Valuation Date has passed. Kindly Revaluate');

                        /*
                        Loans.GET("Loan No");
                
                        IF Loans."Expected Date of Completion" = 0D THEN BEGIN
                            MemberActivities.GenerateRepaymentSchedule(Loans);
                            RSchedule.RESET;
                            RSchedule.SETRANGE("Loan No.",Loans."Loan No.");
                            IF RSchedule.FINDLAST THEN BEGIN
                                Loans."Expected Date of Completion":=RSchedule."Repayment Date";
                                Loans.MODIFY;
                            END;
                        END;
                
                        IF SecReg."Next Valuation Date" < Loans."Expected Date of Completion" THEN
                          MESSAGE('Note that the Expected Date of Loan Completion exceeds the Next Valuation Date');
                        */

                    end;

                end;

                /*
                LoanSec.RESET;
                LoanSec.SETFILTER("Outstanding Balance",'>0');
                LoanSec.SETRANGE("Collateral Reg. No.","Collateral Reg. No.");
                IF LoanSec.FIND('-') THEN BEGIN
                  LoanSec.CALCFIELDS("Outstanding Balance");
                  ERROR(Text004,LoanSec."Loan No",LoanSec."Outstanding Balance");
                END;
                */

            end;
        }
        field(50028; "Collateral Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Current Committed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Application Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Total Guarantor Commitment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Total Loan Guarantorship"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Amount Guaranteed" where("Loan No." = field("Loan No."),
                                                                       Substituted = const(false)));
            FieldClass = FlowField;
        }
        field(50041; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Defaulter Release"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Defaulter Recovered"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50044; Released; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Security Amount"; Decimal)
        {
            CalcFormula = sum("Loan Security"."Amount Guaranteed" where("Loan No." = field("Loan No."),
                                                                         "Guarantor Type" = const(Collateral)));
            FieldClass = FlowField;
        }
        field(50046; "Security Details"; Text[200])
        {
            CalcFormula = lookup("Loan Collateral Register"."Collateral Details" where("No." = field("Collateral Reg. No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50047; "Total Committed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Sub. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Def. Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50050; "Substituted Member"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(50051; Picture; Blob)
        {
            DataClassification = ToBeClassified;
        }

        field(50052; Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }

        field(50055; "Current Guarantor Deposits"; Decimal)
        {
            Caption = 'Deposits';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50056; "Old Member No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50059; "Gua. Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50060; "Gua. Employer Code"; code[20])
        {
            // DataClassification = ToBeClassified;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No")));
        }
        field(50061; "Gua. Status"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50062; "Gua. Loan Balance"; Decimal)
        {
            CalcFormula = sum("Credit Ledger Entry".Amount where("Member No." = field("Member No"),
                                                                "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment"),
                                                                "User ID" = filter(<> ''),
                                                                Amount = filter(<> 0),
                                                                "Amount (LCY)" = filter(<> 0)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50063; "Cap Guarantorship"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Deposit Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50065; "Mobile Loan"; Boolean)
        {
            CalcFormula = lookup("Loans"."Mobile Loan" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50066; "No of Loans Gua."; Integer)
        {
            CalcFormula = count("Loan Security" where("Member No" = field("Member No")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Account No.", "Collateral Reg. No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ShipmentTermsTranslation: Record "Shipment Method Translation";
    begin
    end;

    var
        GenSetUp: Record "Sacco Setup";
        SelfGuaranteedA: Decimal;
        Staff_Board: Boolean;
        LoansR: Record Loans;
        Members: Record Members;
        Savings: Record "Savings Accounts";
        Employer: Record Customer;
        MemberActivities: Codeunit "Member Activities";
        LoanApp: Record Loans;
        LoanSec: Record "Loan Security";
        Loans: Record Loans;
        LoanTopUp: Record "Loan Top Up";
        SecReg: Record "Loan Collateral Register";
        SaccoSetup: Record "Sacco Setup";
        DepAmt: Decimal;
        GuaranteedInApplication: Decimal;
        Committed: Decimal;
        Available: Decimal;

        DimVal: Record "Dimension Value";


    /// <summary>
    /// CalculateAvailableShares.
    /// </summary>
    /// <param name="Savings">Record "Savings Accounts".</param>
    /// <param name="DepAmt">VAR Decimal.</param>
    /// <param name="GuaranteedInApplication">VAR Decimal.</param>
    /// <param name="Committed">VAR Decimal.</param>
    /// <param name="Available">VAR Decimal.</param>
    procedure CalculateMobileLoansAvailableShares(Savings: Record "Savings Accounts"; var MultiDepAmt: Decimal; var GuaranteedInApplication: Decimal; var Committed: Decimal; var Available: Decimal; SelfGuarantee: Boolean; LoanProduct: Code[20])
    var
        LRec: Record Loans;
        LRec2: Record Loans;
        LoanTopUp: Record "Loan Top Up";
        LoanG: Record "Loan Security";
        ProductSetup: Record "Product Setup";
        SProduct: Record "Product Setup";
        Cust: Record Members;
        TotalCommited: Decimal;
        TotalLoanBal: decimal;
        TotalLoanApplyingBal: decimal;
        RunningAvailBal: Decimal;
        MaxLoanAmount: decimal;
        DepositsComm: Decimal;
        LRec2Bal: Decimal;
        Continue: Boolean;
    begin


        GenSetUp.Get;
        GenSetUp.TestField("Mobile Loan Deposits Limit %");
        TotalLoanBal := 0;
        TotalLoanApplyingBal := 0;
        RunningAvailBal := 0;
        MaxLoanAmount := 0;
        DepositsComm := 0;
        LRec2Bal := 0;
        Continue := true;


        Savings.CalcFields(Savings."Balance (LCY)");
        MultiDepAmt := Savings."Balance (LCY)";



        if GenSetUp."Guarantors Multiplier" > 0 then
            MultiDepAmt := Savings."Balance (LCY)" * GenSetUp."Guarantors Multiplier";
        //MESSAGE('%1',SelfGuarantee);

        cust.get(Savings."Member No.");

        DimVal.Reset();
        DimVal.SetRange(Code, cust."Global Dimension 2 Code");
        DimVal.SetFilter("Guarantor Multiplier", '>0');
        if DimVal.FindFirst() then begin
            MultiDepAmt := Savings."Balance (LCY)" * DimVal."Guarantor Multiplier";
        end;

        SProduct.Get(Savings."Product Type");
        ProductSetup.Get(LoanProduct);
        //GuaranteedInApplication := MemberActivities.GetMemberCommittedDeposits(Savings."No.", FALSE);
        if ProductSetup."Guarantorship Option" = ProductSetup."Guarantorship Option"::"Self Guarantee" then begin
            LRec.Reset;
            LRec.SetRange("Member No.", Savings."Member No.");
            LRec.SetFilter("Outstanding Principal", '>0');
            //LRec.SetRange(Source, LRec.Source::BOSA);
            LRec.SetFilter("Loan Product Type", '<>%1', 'L43');
            if LRec.Find('-') then begin
                repeat
                    DepositsComm := 0;
                    LRec.CalcFields("Outstanding Principal", "Total Outstanding Balance");

                    SProduct.Get(LRec."Loan Product Type");

                    //Current commited to you loan
                    LoanG.Reset;
                    LoanG.SetRange("Guarantor Type", LoanG."guarantor type"::Guarantor);
                    LoanG.SetRange("Account No.", Savings."No.");
                    LoanG.SetRange("Loan No.", LRec."Loan No.");
                    LoanG.SetRange(Substituted, false);
                    if LoanG.FindFirst() then begin
                        Report.Run(Report::"Update Guarantor Commitment", false, false, LoanG);
                        Commit();
                    end;

                    if LRec."Mobile Loan" then begin
                        TotalLoanBal += LRec."Total Outstanding Balance";
                        if (Lrec."Loan Product Type" = 'L45') and (Continue = true) then begin
                            LRec2.Reset();
                            LRec2.SetRange("Member No.", Savings."Member No.");
                            LRec2.SetRange("Loan Product Type", 'L45');
                            LRec2.SetFilter("Outstanding Principal", '>0');
                            if LRec2.Find('-') then begin
                                repeat
                                    LRec2.CalcFields("Total Outstanding Balance");
                                    LRec2Bal += LRec2."Total Outstanding Balance";
                                until LRec2.Next = 0;
                                TotalLoanBal := TotalLoanBal - LRec2Bal;
                                Continue := false;
                            end;
                        end;
                    end else begin

                        LoanG.Reset;
                        LoanG.SetRange("Guarantor Type", LoanG."guarantor type"::Guarantor);
                        LoanG.SetRange("Account No.", Savings."No.");
                        LoanG.SetRange("Loan No.", LRec."Loan No.");
                        LoanG.SetRange(Substituted, false);
                        if LoanG.FindFirst() then begin
                            DepositsComm += LoanG."Current Committed";
                        end;

                        //Incase you're not part of the securities
                        if SProduct."Deposit Multiplier" > 0 then
                            TotalLoanBal += ROUND((LRec."Outstanding Principal" - DepositsComm) / SProduct."Deposit Multiplier", 0.01, '>')
                        else
                            TotalLoanBal += ROUND(LRec."Outstanding Principal" - DepositsComm, 0.01, '>')
                    end;

                until LRec.Next = 0;

            end;

        end else begin

            LoanApp.Reset();
            LoanApp.SetRange("Member No.", Savings."Member No.");
            LoanApp.SetRange("Mobile Loan", true);
            //LoanApp.SetFilter("Loan Product Type", '<>%1&<>%2&<>%3&<>%4', 'L43', 'L44', 'L45', LoanProduct);
            LoanApp.SetFilter("Loan Product Type", '<>%1&<>%2&<>%3', 'L43', 'L45', LoanProduct);
            LoanApp.SetFilter("Outstanding Principal", '>0');
            LoanApp.SetAutoCalcFields("Outstanding Principal");
            if LoanApp.FindFirst() then
                repeat
                    TotalLoanBal += LoanApp."Outstanding Principal";
                until LoanApp.Next() = 0;
        end;

        Committed := MemberActivities.GetCurrentSelfCommittedDeposits(Savings."No.", true, ProductSetup) + TotalLoanBal;

        TotalCommited := Committed;

        MultiDepAmt := (Savings."Balance (LCY)" * GenSetUp."Mobile Loan Deposits Limit %" * 0.01) - TotalCommited;

        MultiDepAmt := MultiDepAmt * ProductSetup."Deposit %" * 0.01;

        MaxLoanAmount := ProductSetup."Maximum Loan Amount";

        //end;
        if MultiDepAmt > MaxLoanAmount then
            MultiDepAmt := MaxLoanAmount;

        RunningAvailBal := MultiDepAmt;

        if ProductSetup."Allow Multiple Running Loans" then begin
            LoanApp.Reset();
            LoanApp.SetRange("Member No.", Savings."Member No.");
            LoanApp.SetRange("Mobile Loan", true);
            LoanApp.SetFilter("Outstanding Principal", '>0');
            LoanApp.SetRange("Loan Product Type", LoanProduct);
            LoanApp.SetAutoCalcFields("Outstanding Principal");
            if LoanApp.FindFirst() then
                repeat
                    TotalLoanApplyingBal += LoanApp."Outstanding Principal";
                until LoanApp.Next() = 0;
        end;

        Available := RunningAvailBal - TotalLoanApplyingBal;

        //MESSAGE('DepAmt %1\Committed %2',DepAmt,Committed);
        //if SelfGuarantee then
        //  Available := DepAmt
        //else
        /*if SelfGuarantee then begin
            //If you have a self guaranteed loan then use deposits with  GenSetUp."Self Guarantee %"
            GenSetUp.TestField("Self Guarantee %");
            if Savings."Balance (LCY)" > TotalCommited then begin
                MultiDepAmt := (Savings."Balance (LCY)" - TotalCommited) * GenSetUp."Self Guarantee %" / 100;
            end else
                MultiDepAmt := 0;
 
            Available := MultiDepAmt;
        end else begin
            //If you have have a any self guaranteed loan then use deposits without
            LoanSec.Reset;
            LoanSec.SetRange("Self Guarantee", true);
            LoanSec.SetFilter("Account No.", '%1', "Account No.");
            LoanSec.SetFilter("Outstanding Principal", '>0');
            if LoanSec.FindFirst then begin
                MultiDepAmt := Savings."Balance (LCY)";
            end;
            Available := MultiDepAmt - TotalCommited;
 
        end;*/
        //MESSAGE('available %1',Available);
    end;

    procedure CalculateAvailableShares(Savings: Record "Savings Accounts"; var MultiDepAmt: Decimal; var GuaranteedInApplication: Decimal; var Committed: Decimal; var Available: Decimal; SelfGuarantee: Boolean)
    var
        LRec: Record Loans;
        LoanTopUp: Record "Loan Top Up";
        LoanG: Record "Loan Security";
        ProductSetup: Record "Product Setup";
        SProduct: Record "Product Setup";
        Cust: Record Members;
        TotalCommited: Decimal;
        SelfGuaranteeCommitment: Decimal;
        DepositsLessSelfGuarantee: Decimal;
        CommitedMobileLoan: Decimal;
    begin


        GenSetUp.Get;
        CommitedMobileLoan := 0;
        SelfGuaranteeCommitment := 0;

        Savings.CalcFields(Savings."Balance (LCY)");
        MultiDepAmt := Savings."Balance (LCY)";



        if GenSetUp."Guarantors Multiplier" > 0 then
            MultiDepAmt := Savings."Balance (LCY)" * GenSetUp."Guarantors Multiplier";
        //MESSAGE('%1',SelfGuarantee);

        cust.get(Savings."Member No.");

        DimVal.Reset();
        DimVal.SetRange(Code, cust."Global Dimension 2 Code");
        DimVal.SetFilter("Guarantor Multiplier", '>0');
        if DimVal.FindFirst() then begin
            MultiDepAmt := Savings."Balance (LCY)" * DimVal."Guarantor Multiplier";
        end;

        SProduct.Get(Savings."Product Type");

        GuaranteedInApplication := MemberActivities.GetMemberCommittedDeposits(Savings."No.", FALSE);

        Committed := MemberActivities.GetMemberCommittedDeposits(Savings."No.", true); //commited to other members

        SelfGuaranteeCommitment := MemberActivities.GetSelfGuaranteeCommitment(Savings."No.", true); //commited to other members

        if SelfGuarantee then
            Committed += GetMobileLoanBalances("Member No");

        TotalCommited := Committed + GuaranteedInApplication;

        if not SelfGuarantee then begin
            MultiDepAmt := (Savings."Balance (LCY)" - SelfGuaranteeCommitment) * GenSetUp."Guarantors Multiplier";
            Available := MultiDepAmt - TotalCommited;
        end;

        //MESSAGE('GuaranteedIn %1 |CommittedDeposits %2 ',GuaranteedInApplication,MemberActivities.GetMemberCommittedDeposits('0004056',TRUE));
        DepositsLessSelfGuarantee := Savings."Balance (LCY)" - SelfGuaranteeCommitment;

        //MESSAGE('DepAmt %1\Committed %2',DepAmt,Committed);
        //if SelfGuarantee then
        //  Available := DepAmt
        //else
        if SelfGuarantee then begin
            //If you have a self guaranteed loan then use deposits with  GenSetUp."Self Guarantee %" 
            GenSetUp.TestField("Self Guarantee %");
            if Savings."Balance (LCY)" > TotalCommited then begin
                MultiDepAmt := (Savings."Balance (LCY)" - TotalCommited) * GenSetUp."Self Guarantee %" / 100;
            end else
                MultiDepAmt := 0;

            Available := MultiDepAmt;
        end else begin
            //If you have have a any self guaranteed loan then use deposits without 


            // LoanSec.Reset;
            // LoanSec.SetRange("Self Guarantee", true);
            // LoanSec.SetFilter("Account No.", '%1', "Account No.");
            // LoanSec.SetRange("Mobile Loan", false);
            // LoanSec.SetFilter("Outstanding Principal", '>0');
            // if LoanSec.FindFirst then begin
            //     //MultiDepAmt := Savings."Balance (LCY)";
            //     MultiDepAmt := Savings."Balance (LCY)" - Committed - CommitedMobileLoan;
            //     Available := (MultiDepAmt * GenSetUp."Guarantors Multiplier") - GuaranteedInApplication;
            // end else
            //Available := MultiDepAmt;


            //if Available > DepositsLessSelfGuarantee then
            //   Available := DepositsLessSelfGuarantee;

        end;
        //MESSAGE('available %1',Available);
    end;

    local procedure GetMobileLoanBalances(MemberNo: Code[20]) Bal: Decimal
    var
        Loans: Record Loans;
    begin
        Bal := 0;
        Loans.Reset();
        Loans.SetRange("Member No.", MemberNo);
        Loans.SetRange("Mobile Loan", true);
        Loans.SetFilter("Total Outstanding Balance", '>0');
        Loans.SetAutoCalcFields("Total Outstanding Balance");
        if Loans.FindFirst() then
            repeat
                Bal += Loans."Total Outstanding Balance";
            until Loans.Next() = 0;

        exit(bal);
    end;

    local procedure SendAnSmsToTheGuarantor()
    var
        SaccoSetup: Record "Sacco Setup";
        Member: Record Members;
        Loan: Record Loans;
        Msg: Text;
        MemberActivities: Codeunit "Member Activities";
        Smssource: Enum "SMS Source Enum";
        Sky: Codeunit "Sky MBanking";
    begin

        SaccoSetup.get;
        if Loan.Get(Rec."Loan No.") then
            if Member.Get("Member No") then begin

                /*  Msg := 'Dear ' + Sky.FirstName(Member.Name) + ', You have guaranteed ' + Loan."Member Name" + ' for a ' + Loan."Loan Product Type Name" + ' of KES ' + Format("Amount Guaranteed") + '. Call ' + SaccoSetup."Sacco Contacts" + ' if in dispute.';

                  //TestField("Disbursement Account No");
                  if "Member No" <> Loan."Member No." then
                      MemberActivities.SendSms(Smssource::"Loan Guarantors", Member."Mobile Phone No.", Msg,
                      Loan."Loan No.", Loan."Disbursement Account No", true, false);
                */
            end;

    end;

    procedure CollateralHistory()
    var
        CHistory: Record "Collateral History";
    begin
        if ("Guarantor Type" = "Guarantor Type"::Collateral) and ("Collateral Reg. No." <> '') then begin

            CHistory.Reset();
            CHistory.SetRange("Loan No.", "Loan No.");
            if CHistory.FindFirst() then CHistory.Delete();

            CHistory.Init();
            CHistory."Col. Reg. No" := "Collateral Reg. No.";
            CHistory."Loan No." := "Loan No.";
            CHistory."Amount Guaranteed" := "Amount Guaranteed";
            CHistory.Insert();
        end;
    end;
}

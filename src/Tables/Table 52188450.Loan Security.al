

/// <summary>
/// Table Loan Security (ID 50113).
/// </summary>
Table 50113 "Loan Security"
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

            TableRelation = if ("Guarantor Type" = const(Guarantor)) "Savings Accounts"."No." where("Product Category" = filter("Deposit Contribution"), Status = filter(Active | Dormant))
            else if ("Guarantor Type" = const(Collateral)) Members."No."
            else if ("Guarantor Type" = const(Lien)) "Savings Accounts"."No." where("Product Category" = filter("Fixed Deposit" | "Holiday Savings" | "Junior Savings"), Status = filter(Active | Dormant));

            trigger OnValidate()
            var
                GuarantorMember: Record Members;
                LoaneeAvailableShares: Decimal;
            begin
                InitializeGuarantorFields();
                SetLoaneeInformation();

                case "Guarantor Type" of
                    "Guarantor Type"::Guarantor:
                        ProcessGuarantorType(Rec);
                    "Guarantor Type"::Collateral:
                        ProcessCollateralType();
                    "Guarantor Type"::Lien:
                        ProcessLienType(rec);
                end;

                if Rec."Guarantor Type" in [Rec."Guarantor Type"::Guarantor, Rec."Guarantor Type"::Lien] then
                    CalculateGuarantorArrears(Rec."Member No");

                ValidateStaffBoardGuarantorship();

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
            trigger OnValidate()
            begin
                CalculateAvailableGuarantorship(Rec);
            end;
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
            TableRelation = if ("Guarantor Type" = const(Collateral)) "Collateral ALlocation" where("Member No." = field("Member No"));

            trigger OnValidate()
            var
                CollateralAllocation: Record "Collateral Allocation";
                MemberAllocatedValue: Decimal;
                HasAllocation: Boolean;
            begin
                if SecReg.Get("Collateral Reg. No.") and (SecReg."No." <> '') then begin
                    TestField("Guarantor Type", "guarantor type"::Collateral);
                    SaccoSetup.Get;

                    if SaccoSetup."Collateral % of Limit To Use" <= 0 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    if SaccoSetup."Collateral % of Limit To Use" > 100 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    // Check if collateral has allocations
                    CollateralAllocation.Reset();
                    CollateralAllocation.SetRange("Collateral No.", "Collateral Reg. No.");
                    CollateralAllocation.SetFilter("Collateral Allocation", '>0');
                    HasAllocation := not CollateralAllocation.IsEmpty;

                    if HasAllocation then begin
                        // Get member's specific allocation
                        CollateralAllocation.SetRange("Member No.", "Member No");
                        if not CollateralAllocation.FindFirst() then
                            MemberAllocatedValue := SecReg."Charged Value" else
                            MemberAllocatedValue := CollateralAllocation."Collateral Allocation";

                        "Guarantor Deposits" := MemberAllocatedValue;
                        "Collateral Value" := MemberAllocatedValue;


                        "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateralWithAllocation("Collateral Reg. No.", "Member No", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" +
                                                      MemberActivities.GetCommittedCollateralWithAllocation("Collateral Reg. No.", "Member No", true);
                    end else begin

                        "Guarantor Deposits" := Round(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);
                        "Collateral Value" := SecReg."Charged Value";

                        "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateral("Collateral Reg. No.", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" +
                                                      MemberActivities.GetCommittedCollateral("Collateral Reg. No.", true);
                    end;

                    "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";
                    "Security Details" := SecReg."Collateral Description";
                    "Collateral Type" := SecReg."Collateral Type";
                    "Third-party Collateral" := SecReg."Third-party Collateral";
                    if "Third-party Collateral" then begin
                        CheckCollateralReuse();
                    end;

                    if "Available Guarantorship" < 0 then
                        "Available Guarantorship" := 0;

                    if SecReg."Insurance Expiry Date" <> 0D then
                        if SecReg."Insurance Expiry Date" <= Today then
                            Error('Collateral Insurance Date has passed');

                    if SecReg."Next Valuation Date" <> 0D then
                        if SecReg."Next Valuation Date" <= Today then
                            Error('Collateral Next Valuation is due, kindly revalue to continue!');
                end;
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
        field(50030; "Collateral Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Title Deed,Motor Vehicle, NSE Shares,Money Market Fund,Insurance,Fixed Deposit External';
            OptionMembers = " ","Title Deed","Motor Vehicle","NSE Shares","Money Market Fund",Insurance,"Fixed Deposit External";
            ValuesAllowed = " ", "Title Deed", "Motor Vehicle", "NSE Shares", "Money Market Fund", Insurance, "Fixed Deposit External";
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
        field(50046; "Security Details"; Text[250])
        {
            CalcFormula = lookup("Loan Collateral Register".Remarks where("No." = field("Collateral Reg. No.")));
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
            CalcFormula = count("Loan Security" where("Loan No." = field("Loan No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(50008; "Member Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(89; "Third-party Collateral"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(90; "Guaranteed By"; Option)
        {
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission",Investment,Jiajiri,"Salary Account","MFI Deposit";
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts"."Product Category" where("No." = field("Account No.")));

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
        Apprisal: Record "Member Salary Appraisal";
        DimVal: Record "Dimension Value";

    procedure CalculateAvailableShares(Savings: Record "Savings Accounts"; var MultiDepAmt: Decimal; var GuaranteedInApplication: Decimal; var Committed: Decimal; var Available: Decimal; SelfGuarantee: Boolean)
    var
        Cust: Record Members;
        GenSetUp: Record "Sacco SetUp";
        DimVal: Record "Dimension Value";
        MemberActivities: Codeunit "Member Activities";
        TotalCommited: Decimal;
        SelfGuaranteeCommitment: Decimal;
        OtherGuaranteeCommitment: Decimal;
        DepositBalance: Decimal;
        HasActiveSelfGuarantee: Boolean;
        MobileLoanBalance: Decimal;
        GuarantorMultiplier: Decimal;
        SelfGuaranteeMultiplier: Decimal;
    begin
        // 1. Safe Initialization
        if not GenSetUp.Get() then
            Error('General Setup not found.');


        GenSetUp.TestField("Guarantors Multiplier");
        GenSetUp.TestField("Self Guarantee %");

        // 2. Fetch Base Deposit Data
        Savings.CalcFields("Balance (LCY)");
        DepositBalance := MaxLimit(Savings."Balance (LCY)", 0);

        if not Cust.Get(Savings."Member No.") then
            exit;

        // 3. Resolve Multipliers dynamically
        GuarantorMultiplier := GenSetUp."Guarantors Multiplier";
        SelfGuaranteeMultiplier := GenSetUp."Self Guarantee %" / 100;


        // 4. Fetch All Commitments
        GetGuarantorshipCommitments(
            Savings."No.",
            Savings."Member No.",
            OtherGuaranteeCommitment,
            SelfGuaranteeCommitment
        );

        GuaranteedInApplication := MemberActivities.GetMemberCommittedDeposits(Savings."No.", false);

        // Assuming this is a local function in your object
        MobileLoanBalance := GetMobileLoanBalances(Savings."Member No.");

        HasActiveSelfGuarantee := (SelfGuaranteeCommitment > 0);

        // 5. Core Logic Branching
        if SelfGuarantee then begin
            // --- CASE 1: Calculating for SELF guarantee ---

            if HasActiveSelfGuarantee then begin
                // Already has self-guaranteed loan - use setup % of remaining deposits
                TotalCommited := OtherGuaranteeCommitment + SelfGuaranteeCommitment + GuaranteedInApplication + MobileLoanBalance;
                MultiDepAmt := MaxLimit((DepositBalance - TotalCommited) * SelfGuaranteeMultiplier, 0);

                Available := MultiDepAmt;
                Committed := TotalCommited;
            end else begin
                TotalCommited := SelfGuaranteeCommitment + GuaranteedInApplication + MobileLoanBalance;
                Available := MaxLimit(MultiDepAmt - TotalCommited, 0);
                Committed := TotalCommited;
            end;

        end else begin
            // --- CASE 2: Calculating for GUARANTEEING OTHERS ---

            //if HasActiveSelfGuarantee then begin
            // Policy: Has self-guaranteed loan - CANNOT guarantee others
            MultiDepAmt := 0;
            Available := 0;
            Committed := OtherGuaranteeCommitment + SelfGuaranteeCommitment;
            MultiDepAmt := MaxLimit((DepositBalance * SaccoSetup."Third Party Multiplier %" * 0.01) - Committed, 0);
            Available := MultiDepAmt;
            // end else begin
            //     // Policy: No self-guaranteed loan - can guarantee others up to the multiplier limit
            //     TotalCommited := OtherGuaranteeCommitment + GuaranteedInApplication;
            //     MultiDepAmt := MaxLimit((DepositBalance - SelfGuaranteeCommitment) * GuarantorMultiplier, 0);

            //     Available := MaxLimit(MultiDepAmt - TotalCommited, 0);
            //     Committed := OtherGuaranteeCommitment;
            // end;
        end;
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

            if Loans.Get("Loan No.") then begin

                CHistory.Reset();
                CHistory.SetRange("Loan No.", "Loan No.");
                if CHistory.FindFirst() then CHistory.Delete();

                CHistory.Init();
                CHistory."Col. Reg. No" := "Collateral Reg. No.";
                CHistory."Loan No." := Loans."Loan No.";
                CHistory."Member No." := Loans."Member No.";
                CHistory."Amount Guaranteed" := "Amount Guaranteed";
                CHistory.Insert();
            end
        end;
    end;

    procedure InitializeGuarantorFields()
    begin
        "SMS Sent" := false;
        "Self Guarantee" := false;
        SelfGuaranteedA := 0;
        Date := Today;
        Staff_Board := false;

        GenSetUp.Get();
    end;

    procedure SetLoaneeInformation()
    begin
        // Set information about the member being guaranteed (loanee)
        if LoansR.Get("Loan No.") then begin
            "Member Guaranteed" := LoansR."Member No.";
            "Loanee Name" := LoansR."Member Name";
            CheckIfStaffOrBoard(LoansR."Member No.");
        end else if Apprisal.Get("Loan No.") then begin
            "Member Guaranteed" := Apprisal."Member No.";
            "Loanee Name" := Apprisal.Name;
            CheckIfStaffOrBoard(Apprisal."Member No.");
        end;
    end;

    local procedure CheckIfStaffOrBoard(MemberNo: Code[20])
    begin
        if Members.Get(MemberNo) then
            Staff_Board := (Members."Member Category" in [
                Members."member category"::"Board Members",
                Members."member category"::"Staff Members"
            ]);
    end;

    procedure ProcessGuarantorType(var LoanSecurity: Record "Loan Security")
    var
        GuarantorMember: Record Members;
        SavingsAcc: Record "Savings Accounts";
    begin

        // 1. Strict Validation & Error Handling
        if LoanSecurity."Account No." = '' then
            exit;

        if not SavingsAcc.Get(LoanSecurity."Account No.") then
            Error('Savings Account %1 not found.', LoanSecurity."Account No.");

        if not GuarantorMember.Get(SavingsAcc."Member No.") then
            Error('Member record for account %1 not found.', LoanSecurity."Account No.");


        VerifySelfGuaranteeSequence(LoanSecurity);

        // 3. Eligibility Checks 
        ValidateGuarantorEligibility(GuarantorMember);

        SetGuarantorBasicInfo();

        CalculateAvailableGuarantorship(LoanSecurity);

        LoanSecurity."Available Guarantorship" := MaxLimit(LoanSecurity."Available Guarantorship", 0);
    end;

    procedure CalculateAvailableGuarantorship(var LoanSecurity: Record "Loan Security")
    var
        SaccoSetup: Record "Sacco Setup";
        Savings: Record "Savings Accounts";
        TotalDeposits: Decimal;
        ThirdPartyCommitment: Decimal;
        SelfGuaranteeCommitment: Decimal;
        MaxTotalCapacity: Decimal;
        RemainingGlobalCapacity: Decimal;
        SpecificAvailable: Decimal;
        TopUpRelease: Decimal;
    begin
        // 1. Safety Check: Ensure setup and master records exist
        if not SaccoSetup.Get() then
            Error('Sacco Setup is not configured.');

        // Assuming "Member No." or "Account No." is the link on the Loan Security record
        if not Savings.Get(LoanSecurity."Account No.") then
            Error('Member savings account %1 not found.', LoanSecurity."Account No.");

        // 2. Prepare Data
        Savings.CalcFields("Balance (LCY)");
        TotalDeposits := Savings."Balance (LCY)";

        // Get existing commitments (Your existing helper function)
        GetGuarantorshipCommitments(
            Savings."No.",
            Savings."Member No.",
            ThirdPartyCommitment,
            SelfGuaranteeCommitment
        );

        TopUpRelease := GetTopUpReleaseAmount(LoanSecurity);
        //Get back here in the near future JN***************************************************************************
        //if LoanSecurity."Self Guarantee" then
        SelfGuaranteeCommitment -= TopUpRelease;
        //else
        //ThirdPartyCommitment -= TopUpRelease;

        // Ensure we don't go below zero (Sanity Check)
        SelfGuaranteeCommitment := MaxLimit(SelfGuaranteeCommitment, 0);
        ThirdPartyCommitment := MaxLimit(ThirdPartyCommitment, 0);

        // 3. Apply Global Ceiling (The 150% Rule)
        // Total allowed exposure = 150% of deposits
        MaxTotalCapacity := TotalDeposits * (SaccoSetup."Max Total Exposure %" / 100);

        // Remaining headroom in the member's "guarantee bucket"
        RemainingGlobalCapacity := MaxLimit(MaxTotalCapacity - (ThirdPartyCommitment + SelfGuaranteeCommitment), 0);

        // 4. Branch Logic based on Guarantee Type
        if LoanSecurity."Self Guarantee" then begin
            // Own Loan: Max 95% of deposits minus what's already used for self-guarantee
            SpecificAvailable := (TotalDeposits * (SaccoSetup."Self Guarantee Multiplier %" / 100)) - SelfGuaranteeCommitment;
            LoanSecurity."Deposit Multiplier" := SaccoSetup."Self Guarantee Multiplier %" / 100;
        end else begin
            // Third Party: Max 150% of deposits minus what's already used for others
            SpecificAvailable := (TotalDeposits * (SaccoSetup."Third Party Multiplier %" / 100)) - ThirdPartyCommitment;
            LoanSecurity."Deposit Multiplier" := SaccoSetup."Third Party Multiplier %" / 100;
        end;

        // 5. Final Calculation: Use the lesser of the Specific Limit or the Global Headroom
        LoanSecurity."Available Guarantorship" := GetMin(MaxLimit(SpecificAvailable, 0), RemainingGlobalCapacity);

        // 6. Update Stats for the UI
        LoanSecurity."Guarantor Deposits" := TotalDeposits;
        LoanSecurity."Total Guarantor Commitment" := ThirdPartyCommitment + SelfGuaranteeCommitment;
    end;

    local procedure MaxLimit(Val: Decimal; Limit: Decimal): Decimal
    begin
        if Val < Limit then exit(Limit);
        exit(Val);
    end;

    local procedure GetMin(Val1: Decimal; Val2: Decimal): Decimal
    begin
        if Val1 < Val2 then exit(Val1);
        exit(Val2);
    end;

    local procedure ValidateGuarantorEligibility(GuarantorMember: Record Members)
    begin
        GuarantorMember.TestField("Block Guarantorship", false);

        if Savings.Status <> Savings.Status::Active then
            Error('Member No. %1 is not an Active Member', Savings."No.");

        // Check employer restrictions
        if Employer.Get(GuarantorMember."Employer Code") then
            if Employer."Cannot Guarantee" then
                Error('Members under %1 are not allowed to Guarantee', Employer.Name);

        "Gua. Employer Code" := GuarantorMember."Employer Code";
        "Gua. Status" := Format(GuarantorMember.Status);
    end;

    local procedure IsLoanMarkedAsSelfGuaranteed(LoanNo: Code[20]): Boolean
    var
        LoanRec: Record Loans;
        SaccoSetup: Record "Sacco Setup";
        MemberSavings: Record "Savings Accounts";
        TotalSavings: Decimal;
        SelfGuaranteeThreshold: Decimal;
        LoanAmount: Decimal;
    begin
        if not SaccoSetup.Get() then
            exit(false);

        if LoanRec."Loan No." <> '' then
            if not LoanRec.Get(LoanNo) then
                exit(false);

        // Get member's total savings
        TotalSavings := 0;
        MemberSavings.Reset();
        MemberSavings.SetRange("Member No.", LoanRec."Member No.");
        if MemberSavings.FindSet() then begin
            repeat
                MemberSavings.CalcFields("Balance (LCY)");
                TotalSavings += MemberSavings."Balance (LCY)";
            until MemberSavings.Next() = 0;
        end;

        // Calculate threshold from setup
        SelfGuaranteeThreshold := TotalSavings * (SaccoSetup."Self Guarantee Multiplier %" / 100);

        // Get loan amount to check
        LoanRec.CalcFields("Outstanding Principal");
        if LoanRec."Outstanding Principal" > 0 then
            LoanAmount := LoanRec."Outstanding Principal"
        else
            LoanAmount := LoanRec."Approved Amount";

        // Return true if loan amount ≤ threshold
        exit(LoanAmount <= SelfGuaranteeThreshold);
    end;

    local procedure GetGuarantorshipCommitments(
    AccountNo: Code[20];
    MemberNo: Code[20];
    var ThirdPartyCommitment: Decimal;
    var SelfGuaranteeCommitment: Decimal
)
    var
        LoanSecurity: Record "Loan Security";
        SecurityLoan: Record Loans;
    begin
        ThirdPartyCommitment := 0;
        SelfGuaranteeCommitment := 0;

        // Get all existing guarantees for this account
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Account No.", AccountNo);
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Guarantor);
        LoanSecurity.SetRange("Member No", MemberNo);
        if LoanSecurity.FindSet() then begin
            repeat
                // Check if the guarantee is still active (loan not fully paid)
                if SecurityLoan.Get(LoanSecurity."Loan No.") then begin
                    SecurityLoan.CalcFields("Outstanding Principal");

                    if SecurityLoan."Outstanding Principal" > 0 then begin
                        // Determine if this is self-guarantee or third-party
                        if LoanSecurity."Member Guaranteed" = MemberNo then begin
                            // This guarantor IS the borrower - self guarantee
                            SelfGuaranteeCommitment += LoanSecurity."Current Committed";

                        end else begin
                            // This guarantor is NOT the borrower - third party
                            ThirdPartyCommitment += LoanSecurity."Current Committed";

                        end;
                    end;
                end;
            until LoanSecurity.Next() = 0;
        end;

    end;

    local procedure CheckExistingSelfGuarantee(MemberNo: Code[20]; var SelfGuaranteeExists: Boolean; var SelfGuaranteedAmount: Decimal)
    var
        LoanSecurity: Record "Loan Security";
        MemberSavings: Record "Savings Accounts";
    begin
        SelfGuaranteeExists := false;
        SelfGuaranteedAmount := 0;

        // Find the member's deposit contribution account
        MemberSavings.Reset();
        MemberSavings.SetRange("Member No.", MemberNo);
        MemberSavings.SetRange("Product Category", MemberSavings."Product Category"::"Deposit Contribution");
        MemberSavings.SetRange(Status, MemberSavings.Status::Active);
        if not MemberSavings.FindFirst() then
            exit;

        // Check if there's already a self-guarantee line for this loan
        LoanSecurity.Reset();
        LoanSecurity.SetRange("Loan No.", "Loan No.");
        LoanSecurity.SetRange("Account No.", MemberSavings."No.");
        LoanSecurity.SetRange("Guarantor Type", LoanSecurity."Guarantor Type"::Guarantor);
        if LoanSecurity.FindSet() then begin
            repeat
                // Skip the current line being validated
                if LoanSecurity."Account No." <> Rec."Account No." then begin
                    SelfGuaranteeExists := true;
                    SelfGuaranteedAmount += LoanSecurity."Amount Guaranteed";
                end;
            until LoanSecurity.Next() = 0;
        end;
    end;

    local procedure GetMemberAvailableSelfGuaranteeShares(MemberNo: Code[20]): Decimal
    var
        MemberSavings: Record "Savings Accounts";
        ThirdPartyCommitment: Decimal;
        SelfGuaranteeCommitment: Decimal;
        TotalSavings: Decimal;
        MaxSelfGuarantee: Decimal;
        SaccoSetup: Record "Sacco Setup";
    begin
        SaccoSetup.Get();
        MemberSavings.Reset();
        MemberSavings.SetRange("Member No.", MemberNo);
        MemberSavings.SetRange("Product Category", MemberSavings."Product Category"::"Deposit Contribution");
        MemberSavings.SetRange(Status, MemberSavings.Status::Active);
        if not MemberSavings.FindFirst() then
            exit(0);

        MemberSavings.CalcFields("Balance (LCY)");
        TotalSavings := MemberSavings."Balance (LCY)";

        // Get existing commitments
        GetGuarantorshipCommitments(
            MemberSavings."No.",
            MemberNo,
            ThirdPartyCommitment,
            SelfGuaranteeCommitment
        );

        // Determine available self-guarantee capacity
        if ThirdPartyCommitment >= (TotalSavings * 1.00) then begin
            // Already used 100% for third-party, can use additional 50%
            MaxSelfGuarantee := TotalSavings * 0.50;
        end else begin
            // Can self-guarantee up to 95%
            MaxSelfGuarantee := TotalSavings * 0.95;
        end;

        exit(MaxSelfGuarantee - SelfGuaranteeCommitment);
    end;

    local procedure VerifySelfGuaranteeSequence(LoanSecurity: Record "Loan Security")
    var
        AvailableSelf: Decimal;
        Apprisal: Record "Member Salary Appraisal";
    begin
        if Apprisal.Get(LoanSecurity."Loan No.") then;
        // Check if the loan header requires self-guarantee first
        if not IsLoanMarkedAsSelfGuaranteed(LoanSecurity."Loan No.") then
            exit;

        // If this is a third-party entry, ensure loanee has already exhausted their self-guarantee
        // if not LoanSecurity."Self Guarantee" then begin
        if Apprisal."Self Guarantee" then begin

            /* if LoanSecurity."Member Guaranteed" = '' then
                exit; */ // No loanee assigned yet, skip check

            if LoanSecurity."Member Guaranteed" <> '' then
                AvailableSelf := GetMemberAvailableSelfGuaranteeShares(LoanSecurity."Member Guaranteed");

            if AvailableSelf > 0 then
                Error('This loan requires the borrower to exhaust their own shares first. Remaining self-capacity: %1', AvailableSelf);
        end;
    end;


    local procedure SetGuarantorBasicInfo()
    var
        savings: Record "Savings Accounts";
    begin
        if savings.get("Account No.") then begin
            Savings.CalcFields("Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");
            if (Savings."Product Category" = Savings."Product Category"::"Junior Savings") and (Savings."Child Name" <> '') then
                Name := Savings."Child Name"
            else
                Name := Savings.Name;
            "ID No." := Savings."ID No.";
            "Staff/Payroll No." := Savings."Payroll/Staff No.";
            "Guarantor Deposits" := Savings."Balance (LCY)";
            "Current Guarantor Deposits" := Savings."Balance (LCY)";
            "Gua. Employer Code" := Savings."Employer Code";
            "Member No" := Savings."Member No.";
            "Gua. Status" := Format(Savings.Status);
        end;
    end;

    local procedure CalculateGuarantorArrears(MemberNo: Code[20])
    begin
        "Gua. Arrears" := 0;

        LoansR.Reset();
        LoansR.SetRange("Member No.", MemberNo);
        LoansR.SetRange(Posted, true);
        LoansR.SetFilter("Outstanding Principal", '>0');
        if LoansR.FindSet() then
            repeat
                LoansR.CalcFields("Total Arrears");
                "Gua. Arrears" += LoansR."Total Arrears";
            until LoansR.Next() = 0;

        if "Gua. Arrears" > 0 then
            Error('Member %1 has loan arrears of %2 and cannot guarantee a loan.', MemberNo, "Gua. Arrears");
    end;

    procedure ProcessCollateralType()
    begin
        if not Members.Get("Account No.") then
            exit;

        Name := Members.Name;
        "Staff/Payroll No." := Members."Payroll/Staff No.";
        "ID No." := Members."ID No.";
        "Member No" := "Account No.";

    end;

    procedure ProcessLienType(var LoanSecurity: Record "Loan Security")
    var
        SavingsAcc: Record "Savings Accounts";
        MemberActivities: Codeunit "Member Activities";
        GrossDeposits: Decimal;
        ActiveCommitment: Decimal;
        PendingCommitment: Decimal;
        TotalCommitments: Decimal;
        CalculatedAvailable: Decimal;
    begin
        // 1. Strict Validation
        if LoanSecurity."Account No." = '' then
            exit;

        if not SavingsAcc.Get(LoanSecurity."Account No.") then
            Error('Savings Account %1 not found for Lien processing.', LoanSecurity."Account No.");

        if SavingsAcc.Status <> SavingsAcc.Status::Active then
            Error('Savings Account %1 is not Active. Current status: %2', SavingsAcc."No.", SavingsAcc.Status);

        // 2. Fetch Data
        SavingsAcc.CalcFields("Balance (LCY)", "ID No.", "Payroll/Staff No.", "Employer Code");

        GrossDeposits := SavingsAcc."Balance (LCY)"; //MemberActivities.GetAccountBalance(SavingsAcc."No.");
        ActiveCommitment := MemberActivities.GetMemberCommittedLien(LoanSecurity."Account No.", false);
        PendingCommitment := MemberActivities.GetMemberCommittedLien(LoanSecurity."Account No.", true);
        TotalCommitments := ActiveCommitment + PendingCommitment;

        // 3. Pure Calculation (Fixing the bug: Available = Deposits - Commitments)
        CalculatedAvailable := GrossDeposits - TotalCommitments;

        // 4. Data Assignment (Side-effects mapped cleanly)
        LoanSecurity.Name := SavingsAcc.Name;
        if savings.get("Account No.") then
            if (Savings."Product Category" = Savings."Product Category"::"Junior Savings") and (Savings."Child Name" <> '') then
                LoanSecurity.Name := Savings."Child Name";
        LoanSecurity."Staff/Payroll No." := SavingsAcc."Payroll/Staff No.";
        LoanSecurity."Gua. Employer Code" := SavingsAcc."Employer Code";
        LoanSecurity."ID No." := SavingsAcc."ID No.";
        LoanSecurity."Member No" := SavingsAcc."Member No.";

        LoanSecurity."Current Guarantor Deposits" := SavingsAcc."Balance (LCY)";
        LoanSecurity."Guarantor Deposits" := GrossDeposits;

        LoanSecurity."Application Amount Guaranteed" := ActiveCommitment;
        LoanSecurity."Total Guarantor Commitment" := TotalCommitments;

        // 5. Final Cap (Functional boundary)
        LoanSecurity."Available Guarantorship" := MaxLimit(CalculatedAvailable, 0);
    end;



    procedure ValidateStaffBoardGuarantorship()
    var
        GuarantorMember: Record Members;
        LoaneeMember: Record Members;
        IsGuarantorStaffBoard: Boolean;
        IsLoaneeStaffBoard: Boolean;
    begin
        if not Members.Get("Member No") then
            exit;

        IsGuarantorStaffBoard := Members."Member Category" in [
            Members."member category"::"Board Members",
            Members."member category"::"Staff Members"
        ];

        if not IsGuarantorStaffBoard then
            exit;

        // Check in Appraisal table
        if Apprisal.Get("Loan No.") then
            ValidateStaffBoardRules(Apprisal."Member No.", "Member No");

        // Check in Loan Application table
        if LoanApp.Get("Loan No.") then
            ValidateStaffBoardRules(LoanApp."Member No.", "Member No");
    end;

    local procedure ValidateStaffBoardRules(LoaneeMemberNo: Code[20]; GuarantorMemberNo: Code[20])
    var
        LoaneeMember: Record Members;
        IsLoaneeStaffBoard: Boolean;
        IsSelfGuarantee: Boolean;
    begin
        IsSelfGuarantee := (LoaneeMemberNo = GuarantorMemberNo);

        // Case 1: Staff/Board self-guaranteeing
        if IsSelfGuarantee then begin
            if not GenSetUp."Staff/Board Can Self Gua. Loan" then
                Error('Staff/Board members cannot self guarantee loans');
            exit;
        end;

        // Case 2: Staff/Board guaranteeing others
        if not GenSetUp."Staff Can Guarantee Loan" then
            Error('Staff/Board members cannot guarantee other members'' loans');

        // Case 3: Staff/Board guaranteeing another Staff/Board member
        if LoaneeMember.Get(LoaneeMemberNo) then begin
            IsLoaneeStaffBoard := LoaneeMember."Member Category" in [
                LoaneeMember."member category"::"Board Members",
                LoaneeMember."member category"::"Staff Members"
            ];

            if IsLoaneeStaffBoard then
                if not GenSetUp."Staff/Board Can Self Gua. Loan" then
                    Error('Staff/Board members cannot guarantee other staff/board members'' loans');
        end;
    end;

    local procedure GetTopUpReleaseAmount(LoanSecurity: Record "Loan Security"): Decimal
    var
        LoanTopUp: Record "Appraisal Top Up";
        LoanTopUpMain: Record "Loan Top Up";
        ExistingSecurity: Record "Loan Security";
        ReleasedAmount: Decimal;
    begin
        // 1. Find all loans being topped up in THIS specific application
        LoanTopUp.SetRange("Loan No.", LoanSecurity."Loan No.");
        if LoanTopUp.FindSet() then begin
            repeat
                // 2. Check if THIS guarantor (Account No.) had a commitment on the loan being closed
                ExistingSecurity.SetRange("Loan No.", LoanTopUp."Loan Top Up");
                ExistingSecurity.SetRange("Account No.", LoanSecurity."Account No.");
                if ExistingSecurity.FindFirst() then begin
                    // We sum up the "Current Committed" amount that will be released 
                    // once the old loan is settled by this top-up
                    ReleasedAmount += ExistingSecurity."Current Committed";
                end;
            until LoanTopUp.Next() = 0;

        end else begin
            LoanTopUpMain.SetRange("Loan No.", LoanSecurity."Loan No.");
            if LoanTopUpMain.FindSet() then begin
                repeat
                    // 2. Check if THIS guarantor (Account No.) had a commitment on the loan being closed
                    ExistingSecurity.SetRange("Loan No.", LoanTopUpMain."Loan Top Up");
                    ExistingSecurity.SetRange("Account No.", LoanSecurity."Account No.");
                    if ExistingSecurity.FindFirst() then begin
                        // We sum up the "Current Committed" amount that will be released 
                        // once the old loan is settled by this top-up
                        ReleasedAmount += ExistingSecurity."Current Committed";
                    end;
                until LoanTopUpMain.Next() = 0;
            end;
        end;

        exit(ReleasedAmount);
    end;

    local procedure CheckCollateralReuse()
    var
        LoanSecurity: Record "Loan Security";
        ConfirmMgmt: Codeunit "Confirm Management";
        ReuseMsg: Label 'This collateral is already securing an active loan. Are you sure you want to reuse it?';
    begin
        // Logic: Check if this specific collateral ID/Account is used in other active loans
        LoanSecurity.SetRange("Collateral Reg. No.", Rec."Collateral Reg. No.");
        LoanSecurity.SetFilter("Loan No.", '<>%1', Rec."Loan No.");
        LoanSecurity.SetFilter("Outstanding Principal", '>0');

        if not LoanSecurity.IsEmpty() then begin
            // Professional confirmation dialog
            if not Confirm(ReuseMsg, false) then
                Error('Action cancelled by user. Collateral reuse not permitted without confirmation.');
        end;
    end;
}

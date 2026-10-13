table 59990 "Security Sub. Replacement"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Security Sub."."No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No.";
        }
        field(4; "Guarantor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Guarantor,Collateral,Lien';
            OptionMembers = Guarantor,Collateral,Lien;
        }
        field(50002; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Guarantor Type" = const(Guarantor)) "Savings Accounts"."No." where("Product Category" = filter("Deposit Contribution" | "Micro Member Deposit" | "Micro Group Deposit"),
                                                                                                            Status = filter(Active | Dormant))
            else
            if ("Guarantor Type" = const(Collateral)) Members."No."
            else
            if ("Guarantor Type" = const(Lien)) "Savings Accounts"."No." where("Product Category" = filter("Fixed Deposit" | "Junior Savings" | "Holiday Savings"),
                                                                                         Status = filter(Active | Dormant));

            trigger OnValidate()
            begin
                GenSetUp.Get();

                "Self Guarantee" := false;
                SelfGuaranteedA := 0;
                Date := Today;

                Staff_Board := false;

                //Set Member Guaranteed
                if LoansR.Get("Loan No.") then begin
                    "Member Guaranteed" := LoansR."Member No.";
                    "Loanee Name" := LoansR."Member Name";
                    if Members.Get(LoansR."Member No.") then
                        if (Members."Member Category" = Members."member category"::"Board Members") or
                           (Members."Member Category" = Members."member category"::"Staff Members") then
                            Staff_Board := true;
                end;

                if "Guarantor Type" = "Guarantor Type"::Guarantor then begin

                    //Evaluate guarantor basic info
                    if Savings.Get("Account No.") then begin

                        LoansR.Reset();
                        LoansR.SetRange("Member No.", Savings."Member No.");
                        LoansR.SetFilter("Outstanding Principal", '>0');
                        LoansR.SetFilter("Loans Category-SACCO", '<>%1&<>%2', LoansR."Loans Category-SASRA"::Performing, LoansR."Loans Category-SASRA"::Watch);
                        if LoansR.FindFirst() then
                            Message('Member has defaulted loan %1', LoansR."Loan Product Type Name");

                        if Savings.Status <> Savings.Status::Active then
                            Error('Member No. %1 is not an Active Member', Savings."No.");

                        Members.Get(Savings."Member No.");

                        if Employer.Get(Members."Employer Code") then begin
                            if Employer."Cannot Guarantee" then
                                Error('Members under %1 are not allowed to Guarantee', Employer.Name);
                        end;

                        Savings.CalcFields(Savings."Balance (LCY)");
                        if GenSetUp."Guarantors Multiplier" = 0 then
                            GenSetUp."Guarantors Multiplier" := 1;
                        Name := Savings.Name;
                        "Staff/Payroll No." := Savings."Payroll/Staff No.";
                        "Guarantor Deposits" := Savings."Balance (LCY)" * GenSetUp."Guarantors Multiplier";
                        "ID No." := Savings."ID No.";
                        "Member No." := Savings."Member No.";
                        "Application Amount Guaranteed" := MemberActivities.GetMemberCommittedDeposits("Account No.", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetMemberCommittedDeposits("Account No.", true);
                        "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";

                        if "Available Guarantorship" < 0 then
                            "Available Guarantorship" := 0;

                    end;

                end else begin
                    if "Guarantor Type" = "Guarantor Type"::Collateral then begin
                        if Members.Get("Account No.") then begin
                            Name := Members.Name;
                            "Staff/Payroll No." := Members."Payroll/Staff No.";
                            "ID No." := Members."ID No.";
                            "Member No." := "Account No.";
                        end;
                    end else begin
                        if Savings.Get("Account No.") then begin
                            if Savings.Status <> Savings.Status::Active then
                                Error('Member No. %1 is not an Active Member', Savings."No.");

                            Name := Savings.Name;
                            "Staff/Payroll No." := Savings."Payroll/Staff No.";
                            "Guarantor Deposits" := MemberActivities.GetAccountBalance(Savings."No.");
                            "ID No." := Savings."ID No.";
                            "Member No." := Savings."Member No.";
                            "Application Amount Guaranteed" := MemberActivities.GetMemberCommittedLien("Account No.", false);
                            "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetMemberCommittedLien("Account No.", true);
                            "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";

                            if "Available Guarantorship" < 0 then
                                "Available Guarantorship" := 0;
                        end;
                    end;
                end;

                if LoanApp.Get("Loan No.") then begin
                    if not GenSetUp."Staff Can Guarantee Loan" then
                        if LoanApp."Member No." <> "Member No." then begin
                            if not Staff_Board then begin
                                if Members.Get("Member No.") then
                                    if (Members."Member Category" = Members."member category"::"Board Members") or
                                       (Members."Member Category" = Members."member category"::"Staff Members") then
                                        Error('Staff/Board cannot Guarantee a Loan');
                            end;
                        end;

                    LoanSec.Reset();
                    LoanSec.SetRange("Loan No.", LoanApp."Loan No.");
                    LoanSec.SetFilter("Account No.", '<>%1', "Account No.");
                    LoanSec.SetFilter("Amount Guaranteed", '>%1', 0);
                    if not LoanSec.FindFirst() then begin
                        if LoanApp."Member No." = "Member No." then begin
                            if Savings.Get("Account No.") then begin
                                "Available Guarantorship" := 0;
                                Savings.CalcFields("Balance (LCY)");
                                if Savings."Product Category" = Savings."product category"::"Deposit Contribution" then
                                    "Available Guarantorship" := Savings."Balance (LCY)" * GenSetUp."Self Guarantee %" * 0.01;
                            end;
                        end;
                    end;

                    Loans.Reset();
                    Loans.SetRange("Member No.", LoanApp."Member No.");
                    Loans.SetFilter("Outstanding Principal", '>0');
                    if Loans.FindSet() then begin
                        repeat
                            Loans.CalcFields("Outstanding Principal");
                            LoanTopUp.Reset();
                            LoanTopUp.SetRange("Loan No.", "Loan No.");
                            LoanTopUp.SetRange("Member No.", LoanApp."Member No.");
                            LoanTopUp.SetRange("Loan Top Up", Loans."Loan No.");
                            if LoanTopUp.FindFirst() then begin
                                if Loans."Member No." = "Member No." then begin
                                    "Available Guarantorship" += LoanTopUp."Principle Top Up";
                                end else begin
                                    LoanSec.Reset();
                                    LoanSec.SetRange("Loan No.", LoanTopUp."Loan Top Up");
                                    LoanSec.SetFilter("Account No.", '%1', "Account No.");
                                    if LoanSec.FindFirst() then
                                        "Available Guarantorship" += LoanSec."Current Committed";
                                end;
                            end;
                        until Loans.Next() = 0;
                    end;
                end;

                if "Substituted Member" <> '' then begin
                    ValidateOutgoingMapping();
                    ApplyOutgoingReleaseToAvailability();
                end;
            end;
        }
        field(6; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Name; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Collateral Reg. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Guarantor Type" = const(Collateral))
            "Collateral Allocation"."Collateral No." where("Member No." = field("Member No."));

            trigger OnValidate()
            var
                SecReg: Record "Loan Collateral Register";
                CollateralAllocation: Record "Collateral Allocation";
                SaccoSetup: Record "Sacco Setup";
                MemberAllocatedValue: Decimal;
                HasAllocation: Boolean;
            begin
                if SecReg.Get("Collateral Reg. No.") then begin
                    TestField("Guarantor Type", "Guarantor Type"::Collateral);

                    SaccoSetup.Get();
                    if SaccoSetup."Collateral % of Limit To Use" <= 0 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    if SaccoSetup."Collateral % of Limit To Use" > 100 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    // No previous collateral calculation existed here; this mirrors Loan Security's allocation-aware calculation.
                    CollateralAllocation.Reset();
                    CollateralAllocation.SetRange("Collateral No.", "Collateral Reg. No.");
                    CollateralAllocation.SetFilter("Collateral Allocation", '>0');
                    HasAllocation := not CollateralAllocation.IsEmpty();

                    if HasAllocation then begin
                        CollateralAllocation.SetRange("Member No.", "Member No.");
                        if not CollateralAllocation.FindFirst() then
                            MemberAllocatedValue := SecReg."Charged Value"
                        else
                            MemberAllocatedValue := CollateralAllocation."Collateral Allocation";

                        "Guarantor Deposits" := MemberAllocatedValue;
                        "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateralWithAllocation("Collateral Reg. No.", "Member No.", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateralWithAllocation("Collateral Reg. No.", "Member No.", true);
                    end else begin
                        "Guarantor Deposits" := ROUND(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);
                        "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateral("Collateral Reg. No.", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateral("Collateral Reg. No.", true);
                    end;

                    "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";
                    ApplyOutgoingReleaseToAvailability();
                    Name := SecReg."Collateral Description";

                    if "Available Guarantorship" < 0 then
                        "Available Guarantorship" := 0;

                    if SecReg."Insurance Expiry Date" <> 0D then
                        if SecReg."Insurance Expiry Date" <= Today then
                            Error('Collateral Insurance Date has passed');

                    if SecReg."Next Valuation Date" <> 0D then
                        if SecReg."Next Valuation Date" <= Today then
                            Error('Next Valuation Date has passed. Kindly Revaluate');
                end;
            end;
        }
        field(9; "Replacement Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Replacement Amount" <= 0 then
                    Error('Replacement Amount must be greater than zero.');

                if "Substituted Member" <> '' then begin
                    ValidateOutgoingMapping();
                    ApplyOutgoingReleaseToAvailability();
                end;

                if "Replacement Amount" > "Available Guarantorship" then
                    Error(
                        'Replacement security exceeds available guarantorship.\Header No.: %1\Loan No.: %2\Guarantor Type: %3\Incoming Member No.: %4\Incoming Name: %5\Incoming Account No.: %6\Collateral No.: %7\Outgoing Member No.: %8\Replacement Amount: %9\Available Guarantorship: %10',
                        "Header No.", "Loan No.", "Guarantor Type", "Member No.", Name, "Account No.", "Collateral Reg. No.", "Substituted Member", "Replacement Amount", "Available Guarantorship");
            end;
        }
        field(50005; "Guarantor Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "Staff/Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "ID No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Member Guaranteed"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Available Guarantorship"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Loanee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50034; "Application Amount Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Total Guarantor Commitment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Substituted Member"; Code[20])
        {
            Caption = 'Outgoing Guarantor';
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin
                if "Substituted Member" = '' then begin
                    exit;
                end;

                ValidateOutgoingMapping();
                ApplyOutgoingReleaseToAvailability();
            end;
        }
    }

    keys
    {
        key(PK; "Header No.", "Line No.")
        {
            Clustered = true;
        }
        key(LoanKey; "Loan No.", "Guarantor Type", "Account No.", "Collateral Reg. No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();

        if "Loan No." = '' then
            if SecuritySub.Get("Header No.") then
                "Loan No." := SecuritySub."Loan No.";
    end;

    var
        SecuritySub: Record "Security Sub.";
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
        SecuritySubLines: Record "Security Sub. Lines";

    local procedure GetNextLineNo(): Integer
    var
        Replacement: Record "Security Sub. Replacement";
    begin
        Replacement.Reset();
        Replacement.SetRange("Header No.", "Header No.");
        if Replacement.FindLast() then
            exit(Replacement."Line No." + 1);

        exit(1);
    end;

    local procedure ValidateOutgoingMapping()
    begin
        SecuritySubLines.Reset();
        SecuritySubLines.SetRange("Header No.", "Header No.");
        SecuritySubLines.SetRange("Loan No.", "Loan No.");
        SecuritySubLines.SetRange(Substituted, true);
        SecuritySubLines.SetRange("Member No", "Substituted Member");
        if not SecuritySubLines.FindFirst() then
            Error('Outgoing security for member %1 must be selected and marked as substituted in current securities.', "Substituted Member");
    end;

    local procedure ApplyOutgoingReleaseToAvailability()
    var
        ReleaseAmount: Decimal;
    begin
        ReleaseAmount := GetOutgoingReleaseAmount();
        if ReleaseAmount <= 0 then
            exit;

        "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment" + ReleaseAmount;

        if "Available Guarantorship" < 0 then
            "Available Guarantorship" := 0;
    end;

    local procedure GetOutgoingReleaseAmount(): Decimal
    var
        OutgoingLine: Record "Security Sub. Lines";
    begin
        if "Substituted Member" = '' then
            exit(0);

        OutgoingLine.Reset();
        OutgoingLine.SetRange("Header No.", "Header No.");
        OutgoingLine.SetRange("Loan No.", "Loan No.");
        OutgoingLine.SetRange(Substituted, true);
        OutgoingLine.SetRange("Member No", "Substituted Member");

        if OutgoingLine.FindSet() then begin
            OutgoingLine.CalcSums("Current Committed");
            exit(OutgoingLine."Current Committed");
        end;

        exit(0);
    end;

}

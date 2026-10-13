
Table 50162 "Security Sub. Lines"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(4; "Header No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "New Security"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = if ("Guarantor Type" = const(Guarantor)) "Savings Accounts"."No." where("Product Category" = filter("Deposit Contribution" | "Micro Member Deposit" | "Micro Group Deposit"),
                                                                                                  Status = filter(Active | Dormant))
            else
            if ("Guarantor Type" = const(Collateral)) Members."No."
            else
            if ("Guarantor Type" = const(Lien)) "Savings Accounts"."No." where("Product Category" = filter("Fixed Deposit"),
                                                                                                                             Status = filter(Active | Dormant));

            trigger OnValidate()
            begin


                GenSetUp.Get;

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

                if "Guarantor Type" = "guarantor type"::Guarantor then begin

                    //Evaluate guarantor basic info
                    if Savings.Get("Account No.") then begin

                        LoansR.Reset;
                        LoansR.SetRange("Member No.", Savings."Member No.");
                        LoansR.SetFilter("Outstanding Principal", '>0');
                        LoansR.SetFilter("Loans Category-SACCO", '<>%1&<>%2', LoansR."Loans Category-SASRA"::Performing, LoansR."Loans Category-SASRA"::Watch);
                        if LoansR.FindFirst then
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
                        "Member No" := Savings."Member No.";
                        "Application Amount Guaranteed" := MemberActivities.GetMemberCommittedDeposits("Account No.", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetMemberCommittedDeposits("Account No.", true);
                        "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";

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

                            Name := Savings.Name;
                            "Staff/Payroll No." := Savings."Payroll/Staff No.";
                            "Guarantor Deposits" := MemberActivities.GetAccountBalance(Savings."No.");
                            "ID No." := Savings."ID No.";
                            "Member No" := Savings."Member No.";
                            "Application Amount Guaranteed" := MemberActivities.GetMemberCommittedLien("Account No.", false);
                            "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetMemberCommittedLien("Account No.", true);
                            "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";

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

                    LoanSec.Reset;
                    LoanSec.SetRange("Loan No.", LoanApp."Loan No.");
                    LoanSec.SetFilter("Account No.", '<>%1', "Account No.");
                    LoanSec.SetFilter("Amount Guaranteed", '>%1', 0);
                    if not LoanSec.FindFirst then begin
                        if LoanApp."Member No." = "Member No" then begin
                            if Savings.Get("Account No.") then begin
                                "Available Guarantorship" := 0;
                                Savings.CalcFields("Balance (LCY)");
                                if Savings."Product Category" = Savings."product category"::"Deposit Contribution" then
                                    "Available Guarantorship" := Savings."Balance (LCY)" * GenSetUp."Self Guarantee %" * 0.01;

                            end;
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

                if "Guarantor Type" = "guarantor type"::Collateral then begin

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
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loan Security" where("Account No." = field("Account No."),
                                                       Substituted = const(false),
                                                       "Outstanding Principal" = filter(> 0)));
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
            begin
                if "Amount Guaranteed" > "Available Guarantorship" then
                    Message(
                        'Security amount exceeds available guarantorship.\Loan No.: %1\Guarantor Type: %2\Member No.: %3\Name: %4\Account No.: %5\Collateral No.: %6\Amount Entered: %7\Available Guarantorship: %8',
                        "Loan No.", "Guarantor Type", "Member No", Name, "Account No.", "Collateral Reg. No.", "Amount Guaranteed", "Available Guarantorship");

                "Current Committed" := "Amount Guaranteed";


                if "Amount Guaranteed" <> xRec."Amount Guaranteed" then
                    "New Security" := true;
            end;
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
        field(50016; "Outstanding Principal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Credit Ledger Entry"."Amount (LCY)" where("Loan No." = field("Loan No."),
                                                                        "Transaction Type" = filter("Loan Disbursement" | "Principal Repayment")));

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
        }
        field(50023; "Loan Type"; Code[20])
        {
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No.")));
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


                if SecReg.Get("Collateral Reg. No.") then begin
                    TestField("Guarantor Type", "Guarantor Type"::Collateral);

                    SaccoSetup.Get;
                    if SaccoSetup."Collateral % of Limit To Use" <= 0 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    if SaccoSetup."Collateral % of Limit To Use" > 100 then
                        SaccoSetup."Collateral % of Limit To Use" := 100;

                    // Old collateral calculation before member allocation was considered.
                    // "Guarantor Deposits" := ROUND(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);
                    // "Collateral Value" := SecReg."Collateral Value";
                    // "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateral("Collateral Reg. No.", false);
                    // "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateral("Collateral Reg. No.", true);

                    CollateralAllocation.Reset();
                    CollateralAllocation.SetRange("Collateral No.", "Collateral Reg. No.");
                    CollateralAllocation.SetFilter("Collateral Allocation", '>0');
                    HasAllocation := not CollateralAllocation.IsEmpty();

                    if HasAllocation then begin
                        CollateralAllocation.SetRange("Member No.", "Member No");
                        if not CollateralAllocation.FindFirst() then
                            MemberAllocatedValue := SecReg."Charged Value"
                        else
                            MemberAllocatedValue := CollateralAllocation."Collateral Allocation";

                        "Guarantor Deposits" := MemberAllocatedValue;
                        "Collateral Value" := MemberAllocatedValue;
                        "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateralWithAllocation("Collateral Reg. No.", "Member No", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateralWithAllocation("Collateral Reg. No.", "Member No", true);
                    end else begin
                        "Guarantor Deposits" := ROUND(SecReg."Charged Value" * SaccoSetup."Collateral % of Limit To Use" / 100);
                        "Collateral Value" := SecReg."Charged Value";
                        "Application Amount Guaranteed" := MemberActivities.GetCommittedCollateral("Collateral Reg. No.", false);
                        "Total Guarantor Commitment" := "Application Amount Guaranteed" + MemberActivities.GetCommittedCollateral("Collateral Reg. No.", true);
                    end;

                    "Available Guarantorship" := "Guarantor Deposits" - "Total Guarantor Commitment";
                    Name := SecReg."Collateral Description";

                    if "Available Guarantorship" < 0 then
                        "Available Guarantorship" := 0;

                    if SecReg."Insurance Expiry Date" <> 0D then
                        if SecReg."Insurance Expiry Date" <= Today then
                            Error('Collateral Insurance Date has passed');

                    if SecReg."Valuation Type" = SecReg."valuation type"::" " then begin
                        if SecReg."Next Valuation Date" <= Today then
                            Error('Next Valuation Date has passed. Kindly Revaluate');

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
        field(50045; Released; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Security Details"; Text[200])
        {
            CalcFormula = lookup("Loan Collateral Register"."Collateral Details" where("No." = field("Collateral Reg. No.")));
            FieldClass = FlowField;
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
            /*trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec.Reset();
                Rec.SetRange("Header No.", Rec."Header No.");
                Rec.SetRange("Member No", Rec."Substituted Member");
                if Rec.FindFirst() then;
                    //Rec.Substituted := true;
            end;
            */
        }
        field(50051; Picture; Blob)
        {
            DataClassification = ToBeClassified;
        }

        field(50052; Signature; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; Receipt; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Teller Transaction" where("Member No." = field("Member No"));
        }


    }

    keys
    {
        key(Key1; "Loan No.", "Account No.", "Collateral Reg. No.", "Header No.")
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

    trigger OnInsert()
    begin
        "New Security" := true;
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
}

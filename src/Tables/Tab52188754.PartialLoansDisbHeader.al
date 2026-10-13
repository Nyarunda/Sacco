table 50536 "Partial Loans Disb. Header"
{
    Caption = 'Partial Loans Disb. Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Partial Loan Disb. List";
    DrillDownPageId = "Partial Loan Disb. List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Partial Disb.");
                    "No. Series" := '';

                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(4; Reason; Text[100])
        {
            Caption = 'Reason';
            DataClassification = ToBeClassified;
        }
        field(5; "Captured By"; Code[60])
        {
            Caption = 'Captured By';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(6; "Time Captured"; Time)
        {
            Caption = 'Time Captured';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Loan Moratorium Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Loan Moratorium End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
            TableRelation = Loans where("Member No." = field("Member No."), Posted = const(true));
            trigger OnValidate()
            var
                myInt: Integer;
                TotalAmount: Decimal;
                Loans: Record Loans;
            begin
                if Loans.Get("Loan No.") then begin
                    "Loan Product Type" := Loans."Loan Product Type";
                end;

                CheckOpenPartialDisbursementForLoan();
            end;
        }
        field(13; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
            TableRelation = Members;
            trigger OnValidate()
            begin
                "Loan No." := '';
            end;
        }
        field(14; "Disbursement Acc. Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = ToBeClassified;
            ValuesAllowed = "Bank Account";
        }
        field(35; "Disbursement Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Bank Account"."No.";
        }
        field(50; "Mode of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cheque,Mobile Money,EFT,RTGS';
            OptionMembers = " ","Cheque","Mobile Money",EFT,RTGS,"Transfer to Fosa";
        }
        field(51; Status; Option)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(52; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Amount to Disburse"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Partial Loans Disb. Lines"."Amount to Disbuse" where("Header No." = field("No.")));
        }
        field(54; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(55; "Schedule Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(57; "Loan Product Name"; Text[30])
        {
            Caption = 'Loan Product Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Product Setup".Description where("Product ID" = field("Loan Product Type")));
            Editable = false;
        }
        field(58; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Credit Ledger Entry".Reversed where("Document No." = field("No."),
                                                                      "Loan No." = field("Loan No."),
                                                                      "Member No." = field("Member No.")));
        }
        field(59; "Loan Amount Reversal Applied"; Boolean)
        {
            Caption = 'Loan Amount Reversal Applied';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Exempt Charges"; Boolean)
        {
            Caption = 'Exempt Charges';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Exempt Charges" then
                    ResetPartialDisbursementCharges();
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Loan No.", "Posting Date", "Document Date", "No.")
        {
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Partial Disb.");
            "No." := NoSeriesMgt.GetNextNo(SalesSetup."Partial Disb.");
        end;
        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");
        "Posting Date" := Today;
        "Document Date" := Today;
        "Captured By" := UserId;
        "Time Captured" := time;

        CheckOpenPartialDisbursementForLoan();
    end;

    trigger OnModify()
    begin
        CheckOpenPartialDisbursementForLoan();
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";

    local procedure CheckOpenPartialDisbursementForLoan()
    var
        ExistingPartialDisbHeader: Record "Partial Loans Disb. Header";
    begin
        if "Loan No." = '' then
            exit;

        if Posted then
            exit;

        ExistingPartialDisbHeader.Reset();
        ExistingPartialDisbHeader.SetRange("Loan No.", "Loan No.");
        ExistingPartialDisbHeader.SetRange(Posted, false);
        ExistingPartialDisbHeader.SetFilter(Status, '<>%1', ExistingPartialDisbHeader.Status::Rejected);
        if "No." <> '' then
            ExistingPartialDisbHeader.SetFilter("No.", '<>%1', "No.");

        if ExistingPartialDisbHeader.FindFirst() then
            Error(
                'Loan %1 already has unposted partial disbursement %2. Post or cancel it before creating another partial disbursement for the same loan.',
                "Loan No.",
                ExistingPartialDisbHeader."No.");
    end;

    procedure ResetPartialDisbursementCharges()
    var
        LoanCharges: Record "Loan Charges";
        PartialLoansDisbLines: Record "Partial Loans Disb. Lines";
    begin
        LoanCharges.Reset();
        LoanCharges.SetRange("Loan No.", "No.");
        LoanCharges.SetFilter("Charge Code", '<>%1', 'INS');
        if LoanCharges.FindSet(true) then
            repeat
                LoanCharges.Amount := 0;
                LoanCharges."Excise Duty" := 0;
                LoanCharges."Total Charge" := 0;
                LoanCharges.Modify(false);
            until LoanCharges.Next() = 0;

        PartialLoansDisbLines.Reset();
        PartialLoansDisbLines.SetRange("Header No.", "No.");
        if PartialLoansDisbLines.FindSet(true) then
            repeat
                PartialLoansDisbLines.UpdateExpectedNetTakeHome();
                PartialLoansDisbLines.Modify(false);
            until PartialLoansDisbLines.Next() = 0;
    end;
}

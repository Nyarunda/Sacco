
TableExtension 50173 GenJournalLnine extends "Gen. Journal Line"
{
    fields
    {
        modify("Account No.")
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee
            else
            if ("Account Type" = const(Savings)) "Savings Accounts"
            else
            if ("Account Type" = const(Credit)) "Credit Accounts";
        }
        field(50050; "Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = filter(Credit)) Loans where("Member No." = field("Member No."), "Loan Account" = field("Account No."));
        }
        field(50052; "Member No."; Code[20])
        {
            TableRelation = Members;
            DataClassification = ToBeClassified;
        }
        field(50056; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(50053; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Staff No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Credit Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Loan Disbursement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; Channel; Enum "Transaction Channel")
        {
            DataClassification = ToBeClassified;
        }
        field(50059; Receipt; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }



    procedure GetSavingsAccount()
    var
        Savings: Record "Savings Accounts";
        LoanLedgerEntry: Record "Credit Ledger Entry";
        Members: Record Members;
    begin
        Savings.Get("Account No.");
        //Vend.CheckBlockedVendOnJnls(Vend, "Document Type", false);


        Description := CopyStr(Savings.Name, 1, 50);
        Description := CopyStr(Savings."Product Name" + ' - ' + Description, 1, 100);


        "Posting Group" := Savings."Customer Posting Group";

        if Members.Get(Savings."Member No.") then begin
            "Member No." := Members."No.";
            "Group Code" := Members."Test No";
            "Staff No." := Members."Payroll/Staff No.";
            Rec."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
            Rec."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
        end;
    end;

    procedure GetLoanAccount()
    var
        LoanLedgerEntry: Record "Credit Ledger Entry";
        Members: Record Members;
        CAcc: Record "Credit Accounts";
    begin

        if CAcc.Get("Account No.") then begin


            Description := CopyStr(CAcc.Name, 1, 50);

            //UpdateDescription(Members.Name);
            Description := CopyStr(CAcc."Product Name" + ' - ' + Description, 1, 100);

            "Posting Group" := 'LOANS';

            "Member No." := CAcc."Member No.";
            //"Group Code" := CAcc."Test No";
            "Staff No." := CAcc."Payroll/Staff No.";
            Rec."Shortcut Dimension 1 Code" := CAcc."Global Dimension 1 Code";
            Rec."Shortcut Dimension 2 Code" := CAcc."Global Dimension 2 Code";
        end;
    end;

}

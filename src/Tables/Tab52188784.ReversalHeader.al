table 50466 "Reversal Header"
{
    Caption = 'Reversal Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Reversal No."; Code[20])
        {
            Caption = 'Reversal No.';
            trigger OnValidate()
            begin
                if "Reversal No." <> xRec."Reversal No." then begin
                    NoSetup.Get();
                    NoSeries.TestManual(NoSetup."Reversal No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(5; "Entry No"; Integer)
        {
            TableRelation = if ("Account Type" = const(Account)) "Savings Ledger Entry" where("Account No." = field("Account No"), Reversed = const(false))
            else
            if ("Account Type" = const(Bank)) "Bank Account Ledger Entry" where("Bank Account No." = field("Account No"), Reversed = const(false));

            trigger OnValidate()
            begin
                validate("Document No.");
            end;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnValidate()
            var
                BLdgers: Record "Bank Account Ledger Entry";
                Sledger: Record "Savings Ledger Entry";
            begin
                if "Account Type" = "Account Type"::Account then begin
                    Sledger.Reset();
                    Sledger.SetRange("Entry No.", "Entry No");
                    if Sledger.FindFirst() then begin

                        "Document No." := Sledger."Document No.";
                        Name := Sledger."Customer Name";
                        Description := Sledger.Description;
                        Amount := Sledger."Amount (LCY)";
                        "Date Posted" := Sledger."Posting Date";
                        "Time Posted" := Sledger."Creation Time";
                        "Posted By" := Sledger."User ID";
                    end else
                        if "Account Type" = "Account Type"::Bank then begin
                            BLdgers.Reset();
                            BLdgers.SetRange("Entry No.", "Entry No");
                            if BLdgers.FindFirst() then begin

                                "Document No." := Sledger."Document No.";
                                Name := Sledger."Customer Name";
                                Description := Sledger.Description;
                                Amount := Sledger."Amount (LCY)";
                                "Date Posted" := Sledger."Posting Date";
                                "Time Posted" := Sledger."Creation Time";
                                "Posted By" := Sledger."User ID";
                            end
                        end;
                end;
            end;
        }
        field(7; "Account No"; Code[20])
        {
            Caption = 'Account No';
            TableRelation = if ("Account Type" = const(Account)) "Savings Accounts" where("Member No." = field("Member No."))
            else
            if ("Account Type" = const(Bank)) "Bank Account";
        }
        field(8; Name; Text[60])
        {
            Caption = 'Name';
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(13; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(14; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
        }
        field(15; "Posted By"; Code[60])
        {
            Caption = 'Posted By';
        }
        field(16; "Reponsibility Center"; Code[10])
        {
            Caption = 'Reponsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(17; Branch; Code[10])
        {
            Caption = 'Branch';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(18; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(20; "Date Reversed"; Date)
        {
            Caption = 'Date Reversed';
        }
        field(21; "Time Reversed"; Time)
        {
            Caption = 'Time Reversed';
        }
        field(22; "Reversed By"; Code[60])
        {
            Caption = 'Reversed By';
        }
        field(23; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(24; Reason; Text[100])
        {
            Caption = 'Reason';
        }
        field(25; "Account Type"; Option)
        {
            OptionMembers = " ",Member,Account,Bank;
        }
        field(26; "Member No."; Code[20])
        {
            TableRelation = Members;
        }
        field(27; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Cancelled,Approved;
        }
    }
    keys
    {
        key(key1; "Reversal No.")
        {
            Clustered = true;
        }

    }



    trigger OnInsert()
    begin
        if "Reversal No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Reversal No.");
            "Reversal No." := NoSeries.GetNextNo(NoSetup."Reversal No.", WorkDate(), true);
        end;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
}
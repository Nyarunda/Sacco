table 50588 "Receipt Buffer Lines"
{
    Caption = 'Receipt Buffer Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Batch No"; Code[20])
        {
            Caption = 'Batch No.';
            DataClassification = CustomerContent;
            TableRelation = "Receipt Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Member No"; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
            TableRelation = Members."No." where(Type = const(Member));

            trigger OnValidate()
            var
                Memb: Record Members;
            begin
                if "Member No" = '' then begin
                    Name := '';
                    "ID No." := '';
                    "Member Found" := false;
                    exit;
                end;

                TestField(Type, Type::Member);

                if not Memb.Get("Member No") then
                    Error('Member No. %1 does not exist.', "Member No");

                if Memb.Type <> Memb.Type::Member then
                    Error('Receipt buffer import is allowed for members only. %1 - %2 is %3.', Memb."No.", Memb.Name, Memb.Type);

                Name := Memb.Name;
                "ID No." := Memb."ID No.";
                "Member Found" := true;
            end;
        }
        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if Amount <= 0 then
                    Error('Amount must be greater than zero.');
            end;
        }
        field(5; "Transaction No."; Code[20])
        {
            Caption = 'Transaction No.';
            DataClassification = CustomerContent;
        }
        field(6; "Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "ID No."; Text[20])
        {
            Caption = 'ID No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Member Found"; Boolean)
        {
            Caption = 'Member Found';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(10; "Posted in G/L Entry"; Boolean)
        {
            Caption = 'Posted in G/L Entry';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("G/L Entry" where("Document No." = field("Batch No"),
                                                  "External Document No." = field("Transaction No."),
                                                  "Member No." = field("Member No")
                                                  ));
        }
        field(11; "Posted in G/L Entry Reversed"; Boolean)
        {
            Caption = 'Posted in G/L Entry Reversed';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Entry".Reversed where("Document No." = field("Batch No"),
                                                            "External Document No." = field("Transaction No."),
                                                            "Member No." = field("Member No")));
        }
        field(12; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Member,G/L Account';
            OptionMembers = Member,"G/L Account";

            trigger OnValidate()
            begin
                if Type <> xRec.Type then begin
                    "Member No" := '';
                    "G/L Account No." := '';
                    Name := '';
                    "ID No." := '';
                    "Member Found" := false;
                end;
            end;
        }
        field(13; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));

            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
            begin
                if "G/L Account No." = '' then begin
                    if Type = Type::"G/L Account" then begin
                        Name := '';
                        "Member Found" := false;
                    end;
                    exit;
                end;

                TestField(Type, Type::"G/L Account");
                GLAccount.Get("G/L Account No.");
                GLAccount.TestField("Account Type", GLAccount."Account Type"::Posting);
                GLAccount.TestField(Blocked, false);
                GLAccount.TestField("Direct Posting", true);

                Name := GLAccount.Name;
                "ID No." := '';
                "Member Found" := false;
            end;
        }
    }

    keys
    {
        key(PK; "Batch No", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Member No")
        {
        }
        key(Key3; "Member Found")
        {
        }
        key(Key4; "Batch No", "Member No", "Transaction No.")
        {
        }
        key(Key5; Posted, "Batch No", "Member No", "Transaction No.")
        {
        }
        key(Key6; Type, Posted, "Batch No", "G/L Account No.", "Transaction No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Batch No", "Line No.", Type, "Member No", "G/L Account No.", Name, Amount)
        {
        }
    }
}

table 50600 "Distributions Header"
{
    Caption = 'Distributions Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = members;
            trigger OnValidate()
            var
                Legacy: Codeunit Legacy;
                MemberActivities: Codeunit "Member Activities";
            begin
                "Deposit Balance" := MemberActivities.GetAccountBalance(Legacy.GetDepositAccounts("Member No."));
            end;
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = Loans where("Member No." = field("Member No."));
        }
        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(10; "Date Captured"; Date)
        {
            Caption = 'Date Captured';
            Editable = false;
        }
        field(11; "Captured By"; Text[60])
        {
            Caption = 'Captured By';
            Editable = false;
        }
        field(12; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(13; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(14; "Posted"; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(15; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(16; "Deposit Balance"; Decimal)
        {
            Caption = 'Deposit Balance';
            Editable = false;
        }
        field(41; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
            Editable = false;
        }
        field(42; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                /* if DimVal.Find('-') then
                    Dim1 := DimVal.Name */
            end;
        }
        field(43; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");

                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 2 Code");
                /* if DimVal.Find('-') then
                    Dim2 := DimVal.Name */
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions
            end;
        }

        field(50000; "Amount To Distribute"; Decimal)
        {
            Caption = 'Amount To Distribute';
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        NSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        DimVal: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
    begin
        NSetup.Get();

        NSetup.TestField("Disbribution Nos.");
        "No." := NoSeries.GetNextNo(NSetup."Disbribution Nos.", WorkDate(), true);


        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Dimension Set ID");
        "Date Captured" := Today;
        "Captured By" := UserId;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

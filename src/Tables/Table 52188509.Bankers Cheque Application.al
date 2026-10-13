
Table 50172 "Bankers Cheque Application"
{
    DrillDownPageID = "Bankers Cheq. Application List";
    LookupPageID = "Bankers Cheq. Application List";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    Noseries.TestManual(SalesSetup."Bankers Cheque Application Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Begining Cheque No."; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cheque Register Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(10; "No of Leaves"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" where("Bank Type" = filter(Normal));
        }
        field(12; "Leaf Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Bankers Cheque Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Co-op Bankers Cheque,Customer Service Cheques';
            OptionMembers = "Co-op Bankers Cheque","Customer Service Cheques";
        }
        field(14; "Captured By"; Code[50])
        {
            TableRelation = "User Setup";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Bankers Cheque Application Nos");
            "No." := Noseries.GetNextNo(SalesSetup."Bankers Cheque Application Nos", WorkDate(), true);
        end;



        "Application Date" := Today;
        "Captured By" := UserId;

        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");

            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        end;
    end;

    trigger OnModify()
    begin

        if Status = Status::Approved then begin
            //IF "Cheque Register Generated"=TRUE THEN
            //ERROR('Cheque register has already been generated.');
        end;
    end;

    var
        Noseries: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
}


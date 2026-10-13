
Table 50161 "Security Sub."
{
    DrillDownPageID = "Security Substitution List";
    LookupPageID = "Security Substitution List";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin
                Name := '';

                if Members.Get("Member No.") then
                    Name := Members.Name;
            end;
        }
        field(3; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(10; "Posted By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Captured By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Responsibility Centre"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(19; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No." where("Outstanding Principal" = filter(> 0),
                                                    "Member No." = field("Member No."));

            trigger OnValidate()
            begin

                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Total Outstanding Balance");
                end;

                GenerateGuarantors();
            end;
        }
        field(20; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
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
            SalesSetup.TestField("Security Substitution Nos");
            "No." := NoSeries.GetNextNo(SalesSetup."Security Substitution Nos", WorkDate(), true);
        end;


        UserSetup.Get(UserId);
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        "Captured By" := UserId;
        Date := Today;

        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        if not UserSetup."Security Subtitution" then
            Error(Text001);
    end;

    var
        Text001: Label 'You do not permission to capture and process loan security subtitution. Please contact ICT';
        Loans: Record Loans;
        Members: Record Members;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        UserSetup: Record "User Setup";

    local procedure GenerateGuarantors()
    var
        SubGuarantor: Record "Security Sub. Lines";
        LoanSecurity: Record "Loan Security";
        Replacement: Record "Security Sub. Replacement";
    begin

        SubGuarantor.Reset;
        SubGuarantor.SetRange("Header No.", "No.");
        if SubGuarantor.FindFirst then
            SubGuarantor.DeleteAll;

        Replacement.Reset();
        Replacement.SetRange("Header No.", "No.");
        if Replacement.FindFirst() then
            Replacement.DeleteAll();

        LoanSecurity.Reset;
        LoanSecurity.SetRange(LoanSecurity."Loan No.", "Loan No.");
        //LoanSecurity.SETRANGE(LoanSecurity.Substituted,FALSE);
        if LoanSecurity.Find('-') then begin
            repeat

                SubGuarantor.Init;

                SubGuarantor.TransferFields(LoanSecurity);
                SubGuarantor."Header No." := "No.";
                SubGuarantor.Insert;

            until LoanSecurity.Next = 0;

        end;
    end;
}


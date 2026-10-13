Table 50013 "Bulk Email Header"
{
    Caption = 'Bulk Email Header';

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = false;
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[50])
        {
        }
        field(5; "Email Subject"; Text[250])
        {
        }
        field(6; "Email Body"; Text[2000])
        {
        }
        field(7; "Source File Path"; Text[250])
        {
            Caption = 'PDF File Path or URL';
        }
        field(8; "Endpoint URL"; Text[250])
        {
        }
        field(9; "Email Status"; Option)
        {
            OptionMembers = Pending,Sent,Cancelled;
        }
        field(10; "Status Date"; Date)
        {
        }
        field(11; "Status Time"; Time)
        {
        }
        field(12; "Status By"; Code[50])
        {
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; Entries; Integer)
        {
            CalcFormula = count("Bulk Email Lines" where(No = field(No)));
            FieldClass = FlowField;
        }
        field(15; Attachments; Integer)
        {
            CalcFormula = count("Bulk Email Attachment" where(No = field(No), Enabled = const(true)));
            FieldClass = FlowField;
        }
        field(16; "Email Type"; Option)
        {
            OptionCaption = 'Everyone,Branch,Product,Branch & Product,Employer,Gender,Religion,Status';
            OptionMembers = Everyone,Branch,Product,"Branch & Product",Employer,Gender,Religion,Status;
        }
        field(17; "Filter Type"; enum "Bulk Sms Filter Type")
        {
            Caption = 'Filter Type';
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(19; Product; Code[20])
        {
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(20; "Product Balance Filter"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Active Members Only"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Member Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,"Staff Members","Board Members",Delegates,"Non-Member"," ";
        }
        field(23; "Employer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(24; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "  ",Male,Female;
        }
        field(25; Religion; Option)
        {
            OptionMembers = " ",Christian,Muslim;
        }
        field(26; "Member Status"; Enum "Member Status Enum")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            if NoSetup."BULK EMAIL Nos" <> '' then begin
                NoSetup.TestField(NoSetup."BULK EMAIL Nos");
                "No. Series" := NoSetup."BULK EMAIL Nos";
                No := NoSeriesMgt.GetNextNo(NoSetup."BULK EMAIL Nos");
            end else begin
                NoSetup.TestField(NoSetup."BULK SMS Nos");
                "No. Series" := NoSetup."BULK SMS Nos";
                No := NoSeriesMgt.GetNextNo(NoSetup."BULK SMS Nos");
            end;
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
        "Email Status" := "Email Status"::Pending;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure SendEmails()
    var
        BulkEmailManagement: Codeunit "Bulk Email Management";
    begin
        BulkEmailManagement.SendFromHeader(Rec);
    end;
}

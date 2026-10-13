
Table 50203 "Agent List"
{

    fields
    {
        field(1; "Agent Code"; Code[30])
        {
            Editable = false;
        }
        field(2; "Date Entered"; Date)
        {
        }
        field(3; "Time Entered"; Time)
        {
        }
        field(4; "Entered By"; Code[30])
        {
        }
        field(5; "Document Serial No"; Text[50])
        {
        }
        field(6; "Document Date"; Date)
        {
        }
        field(7; "Customer ID No"; Code[50])
        {
        }
        field(8; Name; Text[200])
        {
        }
        field(9; "Mobile No"; Text[50])
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(12; Comments; Text[200])
        {
        }
        field(13; "Rejection Reason"; Text[30])
        {
        }
        field(14; "Date Approved"; Date)
        {
        }
        field(15; "Time Approved"; Time)
        {
        }
        field(16; "Approved By"; Code[30])
        {
        }
        field(17; "Date Rejected"; Date)
        {
        }
        field(18; "Time Rejected"; Time)
        {
        }
        field(19; "Rejected By"; Code[30])
        {
        }
        field(20; "Sent To Server"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "1st Approval By"; Code[30])
        {
        }
        field(23; "Date 1st Approval"; Date)
        {
        }
        field(24; "Time First Approval"; Time)
        {
        }
        field(25; "Withdrawal Limit Code"; Code[20])
        {
            //TableRelation = Table104125.Field1;

            trigger OnValidate()
            begin

                // WithdrawLimit.RESET;
                // WithdrawLimit.SETRANGE(WithdrawLimit.Code,"Withdrawal Limit Code");
                // IF WithdrawLimit.FIND('-') THEN BEGIN
                // WithdrawLimit.TESTFIELD(WithdrawLimit."Limit Amount");
                // "Withdrawal Limit Amount":=WithdrawLimit."Limit Amount";
                // END;
            end;
        }
        field(26; "Withdrawal Limit Amount"; Decimal)
        {
        }
        field(27; "Account No."; Code[30])
        {
            //TableRelation = Customer."No." //where ("Account Type"=const("10"));

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Account No.");
                if Vend.Find('-') then begin
                    "Customer ID No" := Vend."ID No.";
                    Name := Vend.Name;
                    "Mobile No" := Vend."Transactional Mobile No";
                    Members.Get(Vend."Member No.");
                    "Date of Birth" := Members."Date of Birth";

                    Modify;
                end;
            end;
        }
        field(28; "Name of the Proposed Agent"; Text[200])
        {
        }
        field(29; "Date of Birth"; Date)
        {
        }
        field(30; "Type of Business"; Text[200])
        {
        }
        field(31; "Place of Business"; Text[50])
        {
        }
        field(32; "Business/Work Experience"; Text[100])
        {
        }
        field(33; "Name of Banker"; Text[50])
        {
        }
        field(34; "PIN(KRA)"; Code[30])
        {
        }
        field(35; Branch; Boolean)
        {
        }
        field(36; NewApps; Integer)
        {
        }
        field(37; "Commissions Account"; Code[30])
        {
            TableRelation = "Savings Accounts"."No.";

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Account No.");
                /*
                IF Vend.FIND ('-') THEN BEGIN
                "Customer ID No":=Vend."ID No.";
                Name:=Vend.Name;
                "Mobile No":=Vend."Phone No.";
                "Date of Birth":=Vend."Date of Birth";
                MODIFY;
                END;
                */

            end;
        }
        field(38; "Internal Agent"; Boolean)
        {
        }
        field(39; thePass; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Location; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;

            trigger OnValidate()
            begin
                Name := '';

                if Members.Get("Member No.") then begin
                    Name := Members.Name;
                    Members.TestField("Mobile Phone No.");
                    "Mobile No" := Members."Mobile Phone No.";
                    "Customer ID No" := Members."ID No.";
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Agent Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::Open then begin
            Error('You cannot delete this Agent application.');
        end;
    end;

    trigger OnInsert()
    begin
        if "Agent Code" = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Agency Applications");
            "Agent Code" := NoSeries.GetNextNo(NoSetup."Agency Applications", WorkDate(), true);
        end;


        "Entered By" := UserId;
        "Date Entered" := Today;
        "Time Entered" := Time;
    end;

    trigger OnModify()
    begin
        if Status <> Status::Open then begin
            Message('You cannot Approve the agent application.');
        end;
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Vend: Record "Savings Accounts";
        Members: Record Members;


    procedure GetNewPass()
    begin
    end;
}


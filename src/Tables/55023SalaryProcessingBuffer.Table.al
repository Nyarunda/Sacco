Table 55023 "Salary Processing Buffer"
{

    fields
    {
        field(1; "No."; Integer)
        {
            NotBlank = false;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";
            ValidateTableRelation = false;


        }
        field(3; "Staff No."; Code[20])
        {

        }
        field(4; Name; Text[50])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Account Not Found"; Boolean)
        {
        }
        field(7; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(8; Processed; Boolean)
        {
        }
        field(9; "Document No."; Code[20])
        {
        }
        field(10; Date; Date)
        {
        }
        field(11; "No. Series"; Code[20])
        {
        }
        field(12; "Original Account No."; Code[30])
        {
        }
        field(13; "Multiple Salary"; Boolean)
        {
        }
        field(14; Reversed; Boolean)
        {
        }
        field(15; "Branch Reff."; Code[20])
        {
        }
        field(16; "Account Name"; Text[50])
        {
        }
        field(17; "ID No."; Code[30])
        {
        }
        field(18; Closed; Boolean)
        {
        }

        field(62000; "BOSA Schedule"; Boolean)
        {
        }
        field(62001; USER; Code[50])
        {
        }
        field(62002; "Balance sl"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line".Amount where("Account No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(62003; "Client Code"; Code[20])
        {
        }
        field(62004; "Blocked Accounts"; Boolean)
        {
        }
        field(62005; "Salary Header No."; Code[50])
        {
        }
        field(62006; "Employer Code"; Code[50])
        {
            //TableRelation = Employer;

            trigger OnValidate()
            begin
                /*
               IF "Employer Code"<> SalProcessingHeader."Employer Code" THEN  BEGIN
               "Employer/ Staff Mismatch":=TRUE;
               MODIFY;
               END;
               */

            end;
        }
        field(62007; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(62008; "Employer/ Staff Mismatch"; Boolean)
        {
        }
        field(62009; "Member No."; Code[20])
        {
        }
        field(62010; Status; Option)
        {
            OptionCaption = 'New,Active,Frozen,Closed,Dormant,Deceased';
            OptionMembers = New,Active,Frozen,Closed,Dormant,Deceased;

            trigger OnValidate()
            begin
                //IF (Status<>Status::New) OR (Status<>Status::Closed) THEN
                //Blocked:=Blocked::All;
            end;
        }
        field(62011; Blocked; Option)
        {
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
        }
        field(62012; "Posting Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Salary Processing Header"."Posting date" where(No = field("Salary Header No.")));

        }
    }

    keys
    {
        key(Key1; "No.", "Account No.", Date, "Salary Header No.")
        {
            Clustered = true;
        }
        key(Key2; "Account No.", Date, Processed)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*SalBuffer.RESET;
        IF SalBuffer.FIND('+') THEN
        "No.":=SalBuffer."No."+1;
        */
        USER := UserId;

    end;

    var
        //Acc: Record UnknownRecord39004418;
        //NoSetup: Record UnknownRecord39004267;
        SalBuffer: Record "Salary Processing Buffer";
        Cust: Record Members;
        GLAccount: Record "G/L Account";
        BANKACC: Record "Bank Account";
    //SalProcessingHeader: Record UnknownRecord39004373;
}


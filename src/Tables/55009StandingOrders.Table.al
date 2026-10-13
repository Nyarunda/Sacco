Table 55009 "Standing Orders"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                end;
            end;
        }
        field(2; "Source Account No."; Code[20])
        {
            //TableRelation = "SACCO Account"."No.";

            trigger OnValidate()
            begin
                if Account.Get("Source Account No.") then begin
                    "Staff/Payroll No." := Account."Payroll/Staff No";
                    "Account Name" := Account.Name;
                    "Member No" := Account."Member No.";

                end;
            end;
        }
        field(3; "Staff/Payroll No."; Code[20])
        {
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(5; "Standing Order Type"; Option)
        {
            OptionCaption = 'Internal,External,Pensioner';
            OptionMembers = Internal,External,Pensioner;

            trigger OnValidate()
            begin
                if "Standing Order Type" = "standing order type"::Pensioner then
                    Priority := 1
                else
                    if "Standing Order Type" = "standing order type"::Internal then
                        Priority := 2
                    else
                        if "Standing Order Type" = "standing order type"::External then
                            Priority := 3;
            end;
        }
        field(6; "Destination Account No."; Code[50])
        {
            TableRelation = if ("Standing Order Type" = const(Internal)) "SACCO Account"."No."
            else
            if ("Standing Order Type" = const(External)) "Bank Account"."No."
            else
            if ("Standing Order Type" = const(Pensioner)) Customer."No.";

            trigger OnValidate()
            begin
                if "Destination Account No." = "Source Account No." then begin
                    Error('Source account and destination account must not be the same');
                end;

                if "Standing Order Type" = "standing order type"::Internal then begin
                    if Account.Get("Destination Account No.") then begin
                        "Destination Account Name" := Account.Name;

                    end;
                end;
                if "Standing Order Type" = "standing order type"::External then begin
                    if BankAcc.Get("Destination Account No.") then begin
                        "Destination Account Name" := BankAcc.Name;
                    end;
                end;
                if "Standing Order Type" = "standing order type"::Pensioner then begin
                    if Cust.Get("Destination Account No.") then begin
                        "Destination Account Name" := Cust.Name;
                        Modify;
                    end;
                end;
            end;
        }
        field(7; "Destination Account Name"; Text[50])
        {
        }
        field(8; "BOSA Account No."; Code[20])
        {
            //TableRelation = "SACCO Account"."No.";
        }
        field(9; "Effective/Start Date"; Date)
        {

            trigger OnValidate()
            begin
                /*
                IF "Effective/Start Date"<TODAY THEN
                ERROR('Date must be in Today or in future');
                "Next Run Date":="Effective/Start Date";
                   */

            end;
        }
        field(10; "End Date"; Date)
        {
        }
        field(11; Duration; DateFormula)
        {

            trigger OnValidate()
            begin
                TestField("Effective/Start Date");
                TestField(Duration);
                "End Date" := CalcDate(Duration, "Effective/Start Date");
            end;
        }
        field(12; Frequency; DateFormula)
        {
        }
        field(13; "Allow Partial Deduction"; Boolean)
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,Stopped';
            OptionMembers = Open,Pending,Approved,Rejected,Stopped;
        }
        field(15; Description; Text[50])
        {
            //TableRelation = "Standing Orders Description 1".Description;
        }
        field(16; Amount; Decimal)
        {
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            //TableRelation = "No. Series";
        }
        field(18; "Bank Code"; Code[20])
        {
            //TableRelation = Banks."Bank Code";

            trigger OnValidate()
            begin

                //IF BanksList.GET("Bank Code") THEN BEGIN
                BanksList.Reset;
                BanksList.SetRange(BanksList."Bank Code", "Bank Code");
                if BanksList.Find('-') then begin
                    "Bank Name" := BanksList."Bank Name";
                    "Bank Branch" := BanksList.Branch;
                    //MODIFY;
                end;
            end;
        }
        field(19; "Transacting Branch"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }

        field(21; Unsuccessfull; Boolean)
        {
        }
        field(22; Balance; Decimal)
        {
        }
        field(23; Effected; Boolean)
        {
        }
        field(24; "Next Run Date"; Date)
        {
        }
        field(25; "Old STO No."; Code[20])
        {
        }
        field(26; "Uneffected STO"; Boolean)
        {
        }
        field(27; "Auto Process"; Boolean)
        {
        }
        field(28; "Date Reset"; Date)
        {
        }
        field(29; "Reset Again"; Boolean)
        {
        }
        field(30; "None Salary"; Boolean)
        {
        }
        field(31; "ID. NO."; Code[20])
        {
        }
        field(32; Invalid; Boolean)
        {
        }
        field(33; "Income Type"; Option)
        {
            OptionCaption = ' ,Salary,Pension,Milk,Tea,Coffee';
            OptionMembers = " ",Salary,Pension,Milk,Tea,Coffee;
        }
        field(34; "Responsibility Center"; Code[20])
        {
            //TableRelation = "Responsibility Center BR";
        }
        field(35; Unrecovered; Boolean)
        {
        }
        field(36; "Bank Name"; Text[100])
        {
        }
        field(37; "Bank Branch"; Text[30])
        {
            //TableRelation = Banks."Branch Code" where ("Bank Code"=field("Bank Code"));

            trigger OnValidate()
            begin

                Bnk.Reset;
                Bnk.SetRange(Bnk."Bank Code", "Bank Code");
                Bnk.SetRange(Bnk."Branch Code", "Bank Branch");
                if Bnk.Find('-') then begin
                    "Bank Name" := Bnk."Bank Name" + '-' + Bnk.Branch;
                    //"Cheque Bank Branch":=Bnk.Branch;
                    //MESSAGE('%1',Bnk."Bank Name");
                    Modify;

                end;
            end;
        }
        field(38; "Destination Account"; Code[50])
        {
        }
        field(39; Type; Option)
        {
            OptionCaption = ' ,Fixed,Sweep';
            OptionMembers = " ","Fixed",Sweep;

            trigger OnValidate()
            begin
                /*StndingOrders.RESET;
                StndingOrders.SETRANGE(StndingOrders."Source Account No.","Source Account No.");
                StndingOrders.SETRANGE(StndingOrders.Status,StndingOrders.Status::Approved);
                StndingOrders.SETRANGE(StndingOrders.Type,Type);
                IF StndingOrders.FIND('-') THEN BEGIN
                ERROR('This member has another standing order of Type %1',StndingOrders.Type);
                END;
                 */
                if Type = Type::Sweep then
                    Amount := 0;

            end;
        }
        field(40; "Member No"; Code[10])
        {
            Editable = false;
        }
        field(41; "Branch Code"; Code[10])
        {
        }
        field(42; Pensonaers; Boolean)
        {
        }
        field(43; Priority; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Standing Order Type")
        {
        }
        key(Key3; Priority)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
        end;


        //IF UsersID.GET(USERID) THEN
        //"Transacting Branch":=UsersID.Branch;
    end;

    var
        Account: Record "SACCO Account";
        UsersID: Record User;
        BanksList: Record Banks;
        "Bank Name": Text[30];
        vend: Record "SACCO Account";
        StndingOrders: Record "Standing Orders";
        BankAcc: Record "Bank Account";
        Bnk: Record Banks;
        Cust: Record Members;
}


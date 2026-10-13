
Table 50121 "Dividends Progression"
{

    fields
    {
        field(50001; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50002; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Processing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Dividend Calc. Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Flat Rate,Prorated';
            OptionMembers = " ","Flat Rate",Prorated;
        }
        field(50005; "Product Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Product Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Qualifying Shares"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Shares; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Gross Dividends"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Witholding Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Net Dividends"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Payment Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Dividend Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "Name"; TExt[200])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "New Net"; Decimal)
        {

        }
        field(32; "Dividend Year"; Integer)
        {

        }

        field(50018; "Exists"; Boolean)
        {
            CalcFormula = Exist("Dividends Progression" where("Account No" = field("Account No"),
                                                                         "New Net" = filter(0)));
            Description = 'Sum("Loan Guarantors and Security"."Amount Guaranteed" WHERE (Loan No=FIELD(Loan No.),Substituted=CONST(No)))';
            FieldClass = FlowField;
        }


    }


    keys
    {
        key(Key1; "Account No", "End Date")
        {
            Clustered = true;
        }
        key(Key2; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}


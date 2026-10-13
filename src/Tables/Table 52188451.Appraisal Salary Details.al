
Table 50114 "Appraisal Salary Details"
{
    LookupPageID = "Cust. Invoice Discounts";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
        }
        field(50003; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Earnings,Deductions,Basic,"Other Allowances","Cleared Effects","Voluntary Deductions","Gross Pay","Net Pay","Previous Bonus","Current Bonus",Junior,Mpesa,"House Allowance","Commuter Allowance","Bosa Deductions";

            trigger OnValidate()
            begin
                if Description = '' then
                    Description := Format(Type);
            end;
        }
        field(50005; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Amount Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Based On Rate';
            OptionMembers = General,"Based On Rate";

            trigger OnValidate()
            begin
                Amount := 0;
            end;
        }
        field(50008; "Rate Per unit"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Amount Calculation Method");
            end;
        }
        field(50009; "No Of Units"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Amount Calculation Method");
                TestField("Rate Per unit");
                Amount := "Rate Per unit" * "No Of Units";
            end;
        }
        field(50010; "Multiplier Qualification"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


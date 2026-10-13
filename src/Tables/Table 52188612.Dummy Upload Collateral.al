
Table 50275 "Dummy Upload Collateral"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Name; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Deposit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Security; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Security Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Loan Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Deposit Guaranteed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Multiplier; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Loan Type"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if Loans.Get("Loan No") then begin
            "Approved Amount" := Loans."Approved Amount";
            ProductSetup.Get(Loans."Loan Product Type");
            "Loan Type" := ProductSetup.Description;
            Multiplier := ProductSetup."Deposit Multiplier";
            if "Loan Type" = 'Asset Finance' then
                Multiplier := 3;
            "Deposit Guaranteed" := Loans."Approved Amount" / ProductSetup."Deposit Multiplier";
            "Security Guaranteed" := "Approved Amount" - "Deposit Guaranteed";
            Date := Loans."Disbursement Date";
        end;
    end;

    var
        Loans: Record Loans;
        DepSecurity: Decimal;
        Members: Record Members;
        ProductSetup: Record "Product Setup";
}


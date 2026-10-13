table 50531 "Employer Group"
{
    Caption = 'Employer Group';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employer Code"; Code[20])
        {
            Caption = 'Employer Code';
            TableRelation = Customer where("Account Type" = filter(Employer));
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.Reset();
                Cust.SetRange("No.", "Employer Code");
                if Cust.FindFirst() then
                    "Employer Name" := Cust.Name;
            end;
        }
        field(2; "Employer Name"; Text[80])
        {
            Caption = 'Employer Name';
            Editable = false;
        }
        field(3; "Advice No."; Code[20])
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Advice No.", "Employer Code")
        {
            Clustered = true;
        }
    }
}

table 51200 "Update PRD Details"
{
    Caption = 'Update PRD Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Address; Text[200])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(3; "Address 2"; Text[200])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(4; "Phone No."; Code[200])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
        }
        field(5; Email; Text[200])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(7; Contact; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }



    trigger oninsert()
    var
        Customer: Record Customer;
    begin
        if Customer.get("No.") then begin
            Customer.Address := Address;
            Customer."Address 2" := "Address 2";
            Customer."Phone No." := "Phone No.";
            Customer."E-Mail" := Email;
            Customer.Contact := Contact;
            Customer.Modify();
            Updated := true;
        end;
    end;
}

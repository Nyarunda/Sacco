
Table 50278 "Member SMS"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(2; Source; Enum "SMS Source Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Count"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
    }

    keys
    {
        key(Key1; "Member No", "Count")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if UserSetup.Get(UserId) then begin
            if UserSetup."Disable SMS" <> true then
                Error('You Are Not Allowed To Perform This Action, Please Contact System Admin');
        end;
    end;

    var
        UserSetup: Record "User Setup";
}


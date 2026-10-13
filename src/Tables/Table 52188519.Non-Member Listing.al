
Table 50182 "Non-Member Listing"
{
    DrillDownPageID = "Non-Member Listing";
    LookupPageID = "Non-Member Listing";

    fields
    {
        field(1; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                if "ID No." <> '' then begin
                    Members.Reset;
                    Members.SetRange("ID No.", "ID No.");
                    if Members.FindFirst then
                        Error('This ID is registered to a Member. Kindly capture this entry as a Member and not Non-Member');
                end;
            end;
        }
        field(2; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Mobile Phone No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "ID No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Members: Record Members;
}


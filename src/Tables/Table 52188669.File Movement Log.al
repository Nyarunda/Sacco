Table 50332 "File Movement Log"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Members));
        }
        field(3; "Member Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Source Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Security Group".Code where(Type = const("File Movement"));

            trigger OnValidate()
            begin
                "Source Name" := '';

                //if UserGroup.Get("Source Location") then
                //    "Source Name" := UserGroup.Name;
            end;
        }
        field(5; "Source Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Source User"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "User Group Member"."User Name" where("User Group Code" = field("Source Location"));
            TableRelation = "User Setup";
        }
        field(7; "Current Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "User Group" where(Type = const("File Movement"));

            trigger OnValidate()
            begin
                "Current Name" := '';

                //if UserGroup.Get("Current Location") then
                //   "Current Name" := UserGroup.Name;
            end;
        }
        field(8; "Current Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Current User"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "User Group Member"."User Name" where("User Group Code" = field("Current Location"));
            TableRelation = "User Setup";
        }
        field(10; "Movement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "File Movement Reference"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","File Request","File Issue";
        }


        field(13; "Expected Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Date Returned"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Deceased; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserSetup: Record "User Setup";
    //UserGroup: Record "Security Group";
}


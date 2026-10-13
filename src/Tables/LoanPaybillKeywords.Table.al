Table 50340 "Loan Paybill Keywords"
{

    fields
    {
        field(1; Keyword; Text[50])
        {
            NotBlank = true;
        }
        field(2; "Product Code"; Code[20])
        {
            TableRelation = "Product Setup"."Product ID";
            trigger OnValidate()
            var
                myInt: Integer;
                Psetp: Record "Product Setup";
            begin
                "Product Class" := "Product Class"::" ";
                if psetp.Get("Product Code") then
                    "Product Class" := Psetp."Product Class";
            end;
        }
        field(3; "Destination Type"; Option)
        {
            OptionMembers = "None";
        }
        field(4; "Member Identifier Position"; Option)
        {
            OptionMembers = "Prefix","Suffix";
        }

        field(5; "Product Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Credit,Savings';
            OptionMembers = " ",Credit,Savings;
        }

    }

    keys
    {
        key(Key1; Keyword)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


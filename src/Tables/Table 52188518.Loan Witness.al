
Table 50181 "Loan Witness"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Non-Member';
            OptionMembers = Member,"Non-Member";
            Editable = false;
        }
        field(3; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members where("Member Status" = const(Active));

            trigger OnValidate()
            begin
                Name := '';
                "ID No." := '';
                "Mobile Phone No" := '';

                if Type = Type::Member then begin

                    Cust.Get("Member No.");
                    Name := Cust.Name;
                    "ID No." := Cust."ID No.";
                    "Mobile Phone No" := Cust."Mobile Phone No.";

                end;


                if Type = Type::"Non-Member" then begin

                    NonMemberListing.Get("Member No.");
                    Name := NonMemberListing.Name;
                    "ID No." := NonMemberListing."ID No.";
                    "Mobile Phone No" := NonMemberListing."Mobile Phone No.";
                end;

            end;
        }
        field(4; Name; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Mobile Phone No" = '' then
                    "Mobile Phone No" := '+2547';
            end;
        }
        field(5; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(6; "Mobile Phone No"; Code[13])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Mobile Phone No" := DelChr("Mobile Phone No", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_');

                if StrLen("Mobile Phone No") <> 13 then
                    Error('Phone No. should be equal to 13 characters');
            end;
        }
        field(7; Spouse; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Witness,Chairperson,Secretary,Treasurer,Magistrate';
            OptionMembers = Witness,Chairperson,Secretary,Treasurer,Magistrate;
            ValuesAllowed = Witness;
        }
        field(9; "SMS Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Member),
                                Micro = const(false)) Customer."No.";

            trigger OnValidate()
            begin
                "Member No." := '';

                if SavingsAccounts.Get("Account No.") then
                    "Member No." := SavingsAccounts."Member No.";

                Validate("Member No.");
            end;
        }
        field(11; Micro; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                IF Loans.GET("Loan No.") THEN
                    IF ProductSetup.GET(Loans."Loan Product Type") THEN
                        IF ProductSetup."Loan Source" = ProductSetup."Loan Source"::MICRO THEN BEGIN
                            IF Cust.GET(Loans."Member No.") THEN
                                "Group Code":=Cust."Group Code";
                        END;
                
                */

            end;
        }
        field(12; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", Category, "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Members;
        LoanG: Record "Loan Security";
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;
        ProductSetup: Record "Product Setup";
        NonMemberListing: Record "Non-Member Listing";
}


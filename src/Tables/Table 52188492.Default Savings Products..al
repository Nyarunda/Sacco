
Table 50155 "Default Savings Products."
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "Member Registration";
        }
        field(2; Product; Code[20])
        {
            NotBlank = true;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));

            trigger OnValidate()
            var
                MemberClass: Record "Member Class";
            begin
                ProductSetup.Get(Product);
                "Product Category" := ProductSetup."Product Category";
                "Product Name" := ProductSetup.Description;
                "Monthly Contribution" := ProductSetup."Minimum Contribution";

                Registration.Reset();
                Registration.SetRange("No.", Rec.Code);
                if Registration.FindFirst() then begin
                    if Registration."Member Class" <> '' then begin

                        MemberClass.Reset();
                        //MemberClass.SetRange("Product ID", ProductSetup."Product ID");
                        MemberClass.SetRange("Member Class", Registration."Member Class");
                        if MemberClass.FindFirst() then begin
                            case "Product Category" of
                                "Product Category"::"Registration Fee":
                                    "Monthly Contribution" := MemberClass."Minimum Registration Fee";
                                "Product Category"::"Deposit Contribution":
                                    "Monthly Contribution" := MemberClass."Minimum Share Deposits";
                                "Product Category"::"Share Capital":
                                    "Monthly Contribution" := MemberClass."Minimum Share Capital"
                            end;

                        end;

                    end;
                end;

            end;
        }
        field(50001; "Product Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission";
        }


        field(50080; "Repay Mode"; Enum "Repay Mode Enum")
        {
            //ValuesAllowed = " ", Salary, Milk, Tea,"Staff Salary","Business","Check Off","Dividends","Internal Standing Order","External Standing Order","Pension","Bonus","Mini-Bonus",Allowance,Cash;
            ValuesAllowed = " ", Salary, "Check Off", "Internal Standing Order", "External Standing Order", "Pension", Allowance, Cash;

        }

    }


    keys
    {
        key(Key1; "Code", Product)
        {
            Clustered = true;
        }
        key(Key2; Product, "Code")
        {
        }
    }


    fieldgroups
    {
    }

    var
        ProductSetup: Record "Product Setup";
        Default: Record "Default Savings Products.";
        Registration: Record "Member Registration";


    trigger OnDelete()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Is Admin" then Error('Error not [Is Admin]');
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        Registration.Reset();
        Registration.SetRange("No.", Rec.Code);
        Registration.SetFilter(Status, '<>%1', Registration.Status::Open);
        if Registration.FindFirst() then
            Error('Registration for member %1 is not open. Current status: %2.', Rec.Code, Registration.Status);
    end;

}


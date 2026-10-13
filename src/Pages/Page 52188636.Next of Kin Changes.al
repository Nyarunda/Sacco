
Page 50299 "Next of Kin Changes"
{
    PageType = ListPart;
    SourceTable = "Next of Kin.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Principal ID No."; Rec."Principal ID No.")
                {
                    ApplicationArea = basic;
                    Visible = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin"; Rec."Next Of Kin")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field(Allocation; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}



Page 50318 "Next of Kin"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Next of Kin.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
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
                field(Spouse; Rec.Spouse)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Next Of Kin"; Rec."Next Of Kin")
                {
                    ApplicationArea = basic;
                    Visible = false;
                }
                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = basic;
                    Visible = false;

                }
                field(Type; Rec.Type)
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


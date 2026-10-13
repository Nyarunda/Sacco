
Page 50324 "Loan Witness"
{
    PageType = List;
    SourceTable = "Loan Witness";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    LookupPageId = "Member Listing";
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Spouse; Rec.Spouse)
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(MobilePhoneNo; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}


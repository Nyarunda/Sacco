Page 50927 "HR Committees"
{
    PageType = List;
    SourceTable = "HR Committees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Roles; Rec.Roles)
                {
                    ApplicationArea = Basic;
                }
                field(MonetaryBenefit; Rec."Monetary Benefit?")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';
                action(CommiteeMembers)
                {
                    ApplicationArea = Basic;
                    Caption = 'Commitee Members';
                    Image = Addresses;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Commitee Members";
                    RunPageLink = No = field(Code);
                }
            }
        }
    }
}



Page 50247 "Interest Buffer"
{
    PageType = List;
    SourceTable = "Savings Interest Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ProductType; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(InterestDate; Rec."Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field(InterestAmount; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field(UserID; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(AccountMatured; Rec."Account Matured")
                {
                    ApplicationArea = Basic;
                }
                field(NoSeries; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(LateInterest; Rec."Late Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(MarkForDeletion; Rec."Mark For Deletion")
                {
                    ApplicationArea = Basic;
                }
                field(ReferenceNo; Rec."Reference No.")
                {
                    ApplicationArea = Basic;
                }
                field(QualifyingAmount; Rec."Qualifying Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Accrued; Rec.Accrued)
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


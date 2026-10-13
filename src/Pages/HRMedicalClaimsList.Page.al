Page 50990 "HR Medical Claims List"
{
    CardPageID = "HR Medical Claims Card";
    PageType = List;
    SourceTable = "HR Medical Claims";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(ClaimNo; Rec."Claim No")
                {
                    ApplicationArea = Basic;
                }
                field(ClaimType; Rec."Claim Type")
                {
                    ApplicationArea = Basic;
                }
                field(ClaimDate; Rec."Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field(PatientName; Rec."Patient Name")
                {
                    ApplicationArea = Basic;
                }
                field(DateofService; Rec."Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field(AmountCharged; Rec."Amount Charged")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
    //Dependants: Record  UnknownRecord39003911;
}


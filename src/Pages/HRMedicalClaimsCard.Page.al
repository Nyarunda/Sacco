Page 51067 "HR Medical Claims Card"
{
    PageType = Card;
    SourceTable = "HR Medical Claims";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(ClaimNo; Rec."Claim No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(DocumentRef; Rec."Document Ref")
                {
                    ApplicationArea = Basic;
                }
                field(DateofService; Rec."Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field(AttendedBy; Rec."Attended By")
                {
                    ApplicationArea = Basic;
                }
                field(AmountCharged; Rec."Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
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


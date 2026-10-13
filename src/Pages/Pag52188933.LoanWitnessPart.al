page 50635 "Loan Witness Part"
{
    ApplicationArea = All;
    Caption = 'Witness Part';
    PageType = ListPart;
    SourceTable = "Witness";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
               
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                   
                }
                field(Name; Rec."Witness Name")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."Witness ID No.")
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


page 50796 "Portal Witnesses Subpage"
{
    PageType = ListPart;
    SourceTable = "Portal Loan Witness";
    ApplicationArea = All;
    Caption = 'Loan Witnesses';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Witness No."; Rec."Witness No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the witness member number.';
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the witness name.';
                }
                field("Witness Phone"; Rec."Witness Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the witness phone number.';
                }
                field("Witness Approved"; Rec."Witness Approved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the witness was added.';
                }
                field("Date Added"; Rec."Date Added")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the witness was added.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewWitness)
            {
                Caption = 'View Witness Details';
                ApplicationArea = All;
                Image = Customer;
                ToolTip = 'View witness member details.';
                RunObject = page "Member Card";
                RunPageLink = "No." = field("Witness No.");
            }
        }
    }
}
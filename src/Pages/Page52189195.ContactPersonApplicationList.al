page 50897 "Contact Person App. List"
{
    PageType = List;
    SourceTable = "Contact Person Application";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Contact Person Applications';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."Application No.") { ApplicationArea = All; }
                field("Member No."; Rec."Member No.") { ApplicationArea = All; }
                field("Full Name"; Rec."Member Name") { ApplicationArea = All; }
                field("Relationship"; Rec."Contact Person Relation") { ApplicationArea = All; }
                field("Phone No."; Rec."Contact Person Phone") { ApplicationArea = All; }
                //field("Email"; Rec.) { ApplicationArea = All; }
                field("Approval Status"; Rec."Status") { ApplicationArea = All; }
                field("Posting Date"; Rec."Application Date") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Open Card")
            {
                ApplicationArea = All;
                RunObject = page "Member Card";
                //RunPageLink = "No." = field(Rec."No.");
            }
        }
    }
}

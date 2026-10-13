page 50767 "CheckOff Codes"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Check Off Codes";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("RCPT Code"; Rec."RCPT Code")
                {
                }
                field("Reporting Name"; Rec."Reporting Name")
                {
                }
                field("Posting Code"; Rec."Posting Code")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}


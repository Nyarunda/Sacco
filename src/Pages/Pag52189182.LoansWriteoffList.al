page 50884 "Loans Writeoff List"
{
    Caption = 'Loans Write-Off List';
    PageType = List;
    CardPageId = "Loans Write Off Card";
    SourceTable = "Write offs";
    SourceTableView = where(Status = filter(<> "Posted"), Department = filter("Assistant Credit Officer"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Write Off No"; Rec."Write Off No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("MemberNo"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Old Member No")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("FIle Comments"; Rec."FIle Comments")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}

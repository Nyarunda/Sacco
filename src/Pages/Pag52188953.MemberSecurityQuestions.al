page 50645 "Member Security Questions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Member Security Questions";
    Caption = 'Member Security Questions';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member number';
                }
                field("Question ID"; Rec."Question ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the security question';
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays the security question text';
                }
                field(Answer; Rec.Answer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member''s answer to the security question';
                }
                field("Is Active"; Rec."Is Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this security question is active for the member';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies when the record was created';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies who created the record';
                }
                field("Last Modified"; Rec."Last Modified")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies when the record was last modified';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies who last modified the record';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewQuestions)
            {
                ApplicationArea = All;
                Caption = 'View Available Questions';
                Image = ViewDetails;
                RunObject = Page "Portal Mbanking Questions";
                ToolTip = 'Opens the list of available security questions';
            }
        }
    }
}

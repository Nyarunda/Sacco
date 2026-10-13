namespace Wanandege.Automation;

using System.Automation;

page 50034 "Workflow User Group List"
{
    Caption = 'Workflow User Group List';
    CardPageId = "Workflow User Group";
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Workflow User Group";
    ApplicationArea = Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the workflow user group code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the description of the workflow user group.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Open Group Members")
            {
                Caption = 'View Members';
                ApplicationArea = Suite;
                RunObject = Page "Workflow User Group";
                RunPageLink = Code = field(Code);
            }
        }
    }
}

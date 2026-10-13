page 50494 "Posted Checkoff."
{
    Caption = 'Posted Checkoff.';
    PageType = Card;
    SourceTable = "Monthly Checkoff Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount Already Posted"; Rec."Amount Already Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Already Posted field.';
                }
                field("Amount Pending"; Rec."Amount Pending")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Pending field.';
                }
                field("Batch Entries"; Rec."Batch Entries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Batch Entries field.';
                }
                field("CHK Buffer Amount"; Rec."CHK Buffer Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CHK Buffer Amount field.';
                }
                field("CHK Line Amount"; Rec."CHK Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CHK Line Amount field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Code field.';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entered By field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("No. Of Batches"; Rec."No. Of Batches")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Batches field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posted Records"; Rec."Posted Records")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Records field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Amount field.';
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt No. field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Count field.';
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Interest field.';
                }
                field("Total Principal"; Rec."Total Principal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Principal field.';
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No field.';
                }
            }
        }
    }
}

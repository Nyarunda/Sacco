page 50559 Posted
{
    Caption = 'Posted';
    PageType = Card;
    SourceTable = "IBT Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount to Transfer field.';
                }
                field("Amount to Transfer (LCY)"; Rec."Amount to Transfer (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount to Transfer (LCY) field.';
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cancelled By field.';
                }
                field("Cheque / Doc. No"; Rec."Cheque / Doc. No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque / Doc. No field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Currency Code Destination"; Rec."Currency Code Destination")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code Destination field.';
                }
                field("Currency Code Source"; Rec."Currency Code Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code Source field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified By field.';
                }
                field("Last Modified Date/Time"; Rec."Last Modified Date/Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified Date/Time field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Paying Account"; Rec."Paying Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account field.';
                }
                field("Paying Account Balance"; Rec."Paying Account Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Balance field.';
                }
                field("Paying Account Balance (LCY)"; Rec."Paying Account Balance (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Balance (LCY) field.';
                }
                field("Paying Account Bank No."; Rec."Paying Account Bank No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Bank No. field.';
                }
                field("Paying Account Currency Code"; Rec."Paying Account Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Currency Code field.';
                }
                field("Paying Account Max. Credit"; Rec."Paying Account Max. Credit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Max. Credit field.';
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Paying Account Name field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Posted On Computer Name"; Rec."Posted On Computer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted On Computer Name field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
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
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field("Total Lines Amount (LCY)"; Rec."Total Lines Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Lines Amount (LCY) field.';
                }
                field("Transfer Release Date"; Rec."Transfer Release Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer Release Date field.';
                }
            }
        }
    }
}

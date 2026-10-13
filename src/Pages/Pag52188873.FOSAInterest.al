page 50575 "FOSA Interest List"
{
    Caption = 'FOSA Interest List';
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    SourceTable = "FOSA Interest Header";
    SourceTableView = where(Posted = const(false));
    CardPageID = "FOSA Interest Header Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("EndDate"; Rec."EndDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Savings Product Description"; Rec."Savings Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Product Description field.';
                }
                field("All Savings Products"; Rec."All Savings Products")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savings Product Description field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        Usersetup: Record "User Setup";
    begin

        UserSetup.Get(UserId);
        if not UserSetup."FOSA Interest" then
            Error('You do not have any permissions for FOSA Interest to access. Contact the administrator!');
    end;
}

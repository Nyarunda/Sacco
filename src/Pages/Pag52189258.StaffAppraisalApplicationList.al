namespace UnitedWomen.UnitedWomen;

using System.Security.User;

page 50991 "Staff Appraisal List"
{
    Caption = 'Staff Appraisal Application List';
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    CardPageId = "Staff Appraisal Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where("Appraisal Completed" = const(false), "Loan Stage" = filter("Loan Appraisal"), "Appraisal Type" = filter(Staff), Status = filter(Open));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the member name field.';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Amount field.';
                }
                field("Total Loan to Pay"; Rec."Total Loan to Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Total Loan Amount to be paid.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    Caption = 'Appraised By';
                    ToolTip = 'Specifies the user who captured the information.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CheckStaffAccountPermission();
        //Rec.SetRange("Appraiser ID", UserId);
    end;

    local procedure CheckStaffAccountPermission()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            Error('You Are Not SetUp to View Other Staff''s Accounts');

        if not UserSetup."View Staff Accounts" then
            Error('You Are Not SetUp to View Other Staff''s Accounts');
    end;
}

namespace UnitedWomen.UnitedWomen;
using System.Security.User;

page 50993 "Staff Loans Approved List"
{
    Caption = 'Staff Loans Approved List';
    ApplicationArea = Basic;
    CardPageID = "Staff Appraisal Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    SourceTableView = where(Status = const(Approved), "Loan Stage" = filter("Loan Appraisal"), "Appraisal Completed" = const(false), "Appraisal Type" = filter(Staff));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Appraisal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Appraisal No.';
                }
                field(ApplicationDate; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MemberName; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CheckStaffAccountPermission();
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

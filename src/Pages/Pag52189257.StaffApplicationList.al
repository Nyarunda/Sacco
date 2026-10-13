namespace UnitedWomen.UnitedWomen;

using System.Security.User;

page 50959 StaffAppraisalApplication
{

    Caption = 'Staff Application List';
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    CardPageId = "Staff Application card";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where("Appraisal Completed" = const(false), "Loan Stage" = filter("Loan Application"), "Appraisal Type" = filter(Staff));

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
                    ToolTip = 'Specifies the value of the Member No. field.';
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
                    ToolTip = 'Specifies the Total Loan Amount to be paid';
                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User who has captured information';
                    Caption = 'Appraised By';
                }

            }
        }
    }


    trigger OnOpenPage()
    begin
        CheckStaffAccountPermission();
        //Rec.SetRange("Captured By", UserId);
        //Rec.ApplyStaffLoanProductFilter();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // This does not insert anything by itself because the page is Editable = false.
        // It protects the page if you later allow insert/create from this list.
        Rec."Loan Stage" := Rec."Loan Stage"::"Loan Application";
        Rec."Appraisal Type" := Rec."Appraisal Type"::Staff;
        Rec.ApplyStaffLoanProductFilter();
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

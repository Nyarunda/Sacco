page 50948 "Staff Loan Rejected List_"
{
    Caption = 'Staff Loans Rejected List';
    PageType = List;
    SourceTable = Loans;
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Loan Posted Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.") { ApplicationArea = All; }
                field("Member No."; Rec."Member No.") { ApplicationArea = All; }
                field("Member Name"; Rec."Member Name") { ApplicationArea = All; }
                field("Member Category"; Rec."Member Category") { ApplicationArea = All; }
                field("Loan Product Type"; Rec."Loan Product Type") { ApplicationArea = All; }
                field("Loan Product Type Name"; Rec."Loan Product Type Name") { ApplicationArea = All; }
                field("Requested Amount"; Rec."Requested Amount") { ApplicationArea = All; }
                field("Approved Amount"; Rec."Approved Amount") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Loan Rejection Reason"; Rec."Loan Rejection Reason") { ApplicationArea = All; }
                field("Loan Officer"; Rec."Loan Officer") { ApplicationArea = All; }
                field("Salary Appraisal No."; Rec."Salary Appraisal No.") { ApplicationArea = All; }
            }
        }
    }



    trigger OnOpenPage()
    begin
        CheckStaffAccountPermission();
        ApplyStaffLoanFilter();
    end;

    local procedure ApplyStaffLoanFilter()
    var
        ProductSetup: Record "Product Setup";
        StaffLoanProductFilter: Text;
    begin
        /* ProductSetup.Reset();
        ProductSetup.SetRange("Product Class", ProductSetup."Product Class"::Credit);
        ProductSetup.SetRange(Status, ProductSetup.Status::Active);
        ProductSetup.SetRange("Loan Clients", ProductSetup."Loan Clients"::"Staff Members");

        if ProductSetup.FindSet() then
            repeat
                if StaffLoanProductFilter = '' then
                    StaffLoanProductFilter := ProductSetup."Product ID"
                else
                    StaffLoanProductFilter += '|' + ProductSetup."Product ID";
            until ProductSetup.Next() = 0;

        Rec.SetFilter("Loan Product Type", StaffLoanProductFilter); */
        Rec.SetRange("Appraisal Type", Rec."Appraisal Type"::Staff);
        Rec.SetRange(Status, Rec.Status::Rejected);
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

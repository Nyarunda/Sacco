page 50039 "Staff Loan Posted List_"
{
    Caption = 'Posted Staff Loans';
    PageType = List;
    SourceTable = Loans;
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Loan Posted Card";
    Editable = false;

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
                field("Approved Amount"; Rec."Approved Amount") { ApplicationArea = All; }
                field("Outstanding Principal"; Rec."Outstanding Principal") { ApplicationArea = All; }
                field("Outstanding Interest"; Rec."Outstanding Interest") { ApplicationArea = All; }
                field("Total Outstanding Balance"; Rec."Total Outstanding Balance") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field(Posted; Rec.Posted) { ApplicationArea = All; }
                field("Disbursement Date"; Rec."Disbursement Date") { ApplicationArea = All; }
                field("Loan Officer"; Rec."Loan Officer") { ApplicationArea = All; }
                field("Salary Appraisal No."; Rec."Salary Appraisal No.") { ApplicationArea = All; }
            }
        }
    }


    trigger OnOpenPage()
    begin
        ApplyStaffLoanFilter();
    end;

    local procedure ApplyStaffLoanFilter()
    var
        ProductSetup: Record "Product Setup";
        StaffLoanProductFilter: Text;
    begin
        ProductSetup.Reset();
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

        Rec.SetFilter("Loan Product Type", StaffLoanProductFilter);
        Rec.SetRange(posted, true);
    end;
}

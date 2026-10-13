namespace UnitedWomen.UnitedWomen;
page 50921 "Staff Loan Application List"
{

    Caption = 'Staff Loan Application List';
    PageType = List;
    SourceTable = Loans;
    CardPageID = "Staff Loan Application Card";
    DeleteAllowed = false;
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTableView = where(Posted = const(false), "Loan Calculator" = const(false), "Appraisal Type" = filter(Staff));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Loan No.") { ApplicationArea = Basic; }
                field(ApplicationDate; Rec."Application Date") { ApplicationArea = Basic; }
                field(MemberNo; Rec."Member No.") { ApplicationArea = Basic; }
                field(MemberName; Rec."Member Name") { ApplicationArea = Basic; }
                field("Member Category"; Rec."Member Category") { ApplicationArea = Basic; }
                field("Staff No"; Rec."Staff No") { ApplicationArea = Basic; Caption = 'Staff No.'; }
                field(LoanProductType; Rec."Loan Product Type") { ApplicationArea = Basic; }
                field("Loan Product Type Name"; Rec."Loan Product Type Name") { ApplicationArea = Basic; }
                field(RequestedAmount; Rec."Requested Amount") { ApplicationArea = Basic; }
                field(RecommendedAmount; Rec."Recommended Amount") { ApplicationArea = Basic; }
                field(ApprovedAmount; Rec."Approved Amount") { ApplicationArea = Basic; }
                field(AmountToDisburse; Rec."Amount To Disburse") { ApplicationArea = Basic; }
                field("Net To Be Disbursed"; Rec."Net To Be Disbursed") { ApplicationArea = Basic; }
                field(Installments; Rec.Installments) { ApplicationArea = Basic; }
                field(Status; Rec.Status) { ApplicationArea = Basic; }
                field("Disbursement Stage"; Rec."Disbursement Stage") { ApplicationArea = Basic; }
                field("Disbursement Date"; Rec."Disbursement Date") { ApplicationArea = Basic; }
                field("Salary Appraisal No."; Rec."Salary Appraisal No.") { ApplicationArea = Basic; }
                field("Loan Officer"; Rec."Loan Officer") { ApplicationArea = Basic; }
                field("Relationship Officer"; Rec."Relationship Officer") { ApplicationArea = Basic; }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec."Appraisal Type" := Rec."Appraisal Type"::Staff;
        //ApplyStaffLoanFilter();
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
    end;
}

page 50939 "Staff Loan Approved List"
{
    Caption = 'Staff Loans Approved List';
    PageType = List;
    SourceTable = Loans;
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageID = "Staff Loan Application Card";

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
                field("Amount To Disburse"; Rec."Amount To Disburse") { ApplicationArea = All; }
                field("Net To Be Disbursed"; Rec."Net To Be Disbursed") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field(Posted; Rec.Posted) { ApplicationArea = All; }
                field("Loan Officer"; Rec."Loan Officer") { ApplicationArea = All; }
                field("Relationship Officer"; Rec."Relationship Officer") { ApplicationArea = All; }
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
        /*  ProductSetup.Reset();
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

         if StaffLoanProductFilter = '' then
             Error('No active credit loan product is marked as Staff Members in Product Setup.');
  */
        //Rec.SetFilter("Loan Product Type", StaffLoanProductFilter);
        Rec.SetRange("Appraisal Type", Rec."Appraisal Type"::Staff);
        Rec.SetRange(Status, Rec.Status::Approved);
        Rec.SetRange(Posted, false);
    end;
}

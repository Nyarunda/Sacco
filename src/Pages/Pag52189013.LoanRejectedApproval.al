namespace CentralDB.CentralDB;

page 50715 "Loan Rejected Approval"
{
    ApplicationArea = All;
    Caption = 'Loan Rejected Approval';
    CardPageID = "Loan Appraisal Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    SourceTableView = where(Status = filter(Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Appraisal No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedAmount; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec.Name)
                {
                    ApplicationArea = Basic;
                }

                field(CapturedBy; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(loanRejectionReason; Rec."Loan Rejection Reason")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejection Reason';
                }
            }
        }
    }

    actions
    {
    }
}

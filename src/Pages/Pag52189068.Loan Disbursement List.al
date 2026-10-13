namespace Wanandage.Wanandage;

page 50770 "Loan Disbursement List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Loans;
    SourceTableView = where(Posted = const(false),
                            "Loan Calculator" = const(false), Status = filter(Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
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
                field(ApprovedAmount; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
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
            }
        }
    }

    actions
    {
    }

}
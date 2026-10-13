namespace CentralDB.CentralDB;

page 50704 "Loan Application List - Pendin"
{
    ApplicationArea = All;
    Caption = 'Loan Application List - Pending';
    CardPageID = "Loan Appraisal Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    SourceTableView = where(Status = filter(Pending));
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
                }
                field(ApplicationDate; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(LoanProductType; Rec."Loan Product Type")
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
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //SetRange("Captured By", UserId);
    end;
}


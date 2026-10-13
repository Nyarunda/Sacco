
Page 50208 "Loan Changes List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Changes Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Changes";
    sourceTableView = where(Processed = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(MemberName; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPrincipal; Rec."Outstanding Principal")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInterest; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingPenalty; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field(OutstandingInsurance; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                }
                field(TotalOutstanding; Rec."Total Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field(TypeofChange; Rec."Type of Change")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(ReschedulingDate; Rec."Rescheduling Date")
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
    var
        myInt: Integer;
    begin
        Rec.SetRange("Entered By", UserId);
    end;
}


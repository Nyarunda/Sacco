page 50634 "Loan Topup Part"
{
    ApplicationArea = All;
    Caption = 'Loan Topup Part';
    PageType = ListPart;
    SourceTable = "Loan Top Up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LoanTopUp; Rec."Loan Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(LoanType; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field(PrincipleTopUp; Rec."Principle Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(InterestTopUp; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(PenaltyTopUp; Rec."Penalty Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(TotalTopUp; Rec."Total Top Up")
                {
                    ApplicationArea = Basic;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                }
                field("Commision Excise"; Rec."Commision Excise")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        Loan: Record Loans;
    begin
        if Loan.Get(Rec."Loan No.") then begin
            if (Loan.Posted) or (Loan.Status = Loan.Status::Approved) then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

    end;
}


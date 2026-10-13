
Page 50195 "Loan Top Up"
{
    PageType = List;
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
                field("Uncharged Interest"; Rec."Uncharged Interest")
                {
                    ApplicationArea = Basic;
                }
                field(InterestTopUp; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Uncharged Insurance"; Rec."Uncharged Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Top Up"; Rec."Appraisal Top Up")
                {
                    ApplicationArea = basic;
                    Caption = 'Insurance Top Up';
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
        Loan: Record "Loans";
    begin
        if Loan.Get(Rec."Loan No.") then begin
            if (Loan.Posted) or (Loan.Status = Loan.Status::Approved) then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;
    end;
}


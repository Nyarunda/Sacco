page 50433 "Appraisal Loan Top Up"
{

    PageType = List;
    SourceTable = "Appraisal Top Up";

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
                field(LoanName; Rec."Loan Name")
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
                field("Appraisal Top Up"; Rec."Appraisal Top Up")
                {
                    ApplicationArea = basic;
                    Caption = 'Insurance Top Up';

                }
                field(PenaltyTopUp; Rec."Penalty Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Uncharged Insurance"; Rec."Uncharged Insurance")
                {
                    ApplicationArea = Basic;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Refinancing Commission';
                }
                field("Commision Excise"; Rec."Commision Excise")
                {
                    ApplicationArea = Basic;
                }
                field(TotalTopUp; Rec."Total Top Up")
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
        SetPageEditability();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetPageEditability();
    end;

    local procedure SetPageEditability()
    var
        LoanAppraisal: Record "Member Salary Appraisal";
        AppraisalNo: Code[20];
    begin
        AppraisalNo := Rec."Loan No.";

        if (AppraisalNo <> '') and LoanAppraisal.Get(AppraisalNo) then
            CurrPage.Editable := LoanAppraisal.Status <> LoanAppraisal.Status::Approved
        else
            CurrPage.Editable := true;
    end;
}



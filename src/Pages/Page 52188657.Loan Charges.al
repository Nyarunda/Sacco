
Page 50320 "Loan Charges"
{
    PageType = ListPart;
    SourceTable = "Loan Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChargeCode; Rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Charge; Rec."Charge %")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(ExciseDuty; Rec."Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCharge; Rec."Total Charge")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
        Loan: Record Loans;
    begin
        AppraisalNo := Rec."Loan No.";
        if AppraisalNo = '' then
            AppraisalNo := Rec.GetRangeMin("Loan No.");

        if (AppraisalNo <> '') and LoanAppraisal.Get(AppraisalNo) then
            CurrPage.Editable := LoanAppraisal.Status <> LoanAppraisal.Status::Approved
        else
            CurrPage.Editable := true;

        if Loan.Get(Rec."Loan No.") then begin
            if (Loan.Posted) or (Loan.Status = Loan.Status::Approved) then
                CurrPage.Editable := false
            else
                CurrPage.Editable := true;
        end;

    end;


}


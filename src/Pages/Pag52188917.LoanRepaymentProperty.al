/// <summary>
/// Page Loan Repayment Property (ID 50619).
/// </summary>
page 50619 "Loan Repayment Property"
{
    ApplicationArea = All;
    Caption = 'Loan Repayment Property';
    PageType = ListPart;
    SourceTable = "Loan Repayment Property";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                    Visible = false;
                }
                // field("Property Code"; Rec."Property Code")
                // {
                //     ToolTip = 'Specifies the value of the Property Code field.';
                // }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Repayment Amount';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Loans: Record Loans;
    begin
        if Loans.Get(Rec."Loan No") then begin
            if Loans.Posted then CurrPage.Editable := false;
        end;
    end;
}



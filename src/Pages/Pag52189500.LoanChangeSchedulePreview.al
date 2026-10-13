page 50863 "Loan Change Schedule Preview"
{
    ApplicationArea = Basic;
    Caption = 'Loan Change Schedule Preview';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Repayment Schedule II";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Repayment Date"; Rec."Repayment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Principal"; Rec."Monthly Principal")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Interest"; Rec."Monthly Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                }
                field(Insurance;Rec."Monthly Appraisal")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Amount";Rec."Deposit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}

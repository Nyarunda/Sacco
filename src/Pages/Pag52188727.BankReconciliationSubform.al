page 52004 "Bank Reconciliation Subform"
{
    PageType = ListPart;
    SourceTable = "Bank Reconciliation Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reference number from the bank statement';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(Difference; Rec.Difference)
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = Rec.Difference <> 0;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                }
                field("Bank Entry No."; Rec."Bank Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;  // Hidden but used for matching logic
                }
                field(Matched; Rec.Matched)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearSelection)
            {
                ApplicationArea = All;
                Image = ClearFilter;
                Caption = 'Clear Selection';

                trigger OnAction()
                begin
                    Rec.ModifyAll(Cleared, false);
                end;
            }
            action(ShowDifferences)
            {
                ApplicationArea = All;
                Image = FilterLines;
                Caption = 'Show Differences';

                trigger OnAction()
                begin
                    Rec.SetFilter(Difference, '<>0');
                end;
            }
            action(ValidateBalance)
            {
                ApplicationArea = All;
                Image = Calculate;
                Caption = 'Validate Balance';

                trigger OnAction()
                var
                    BankRecValidation: Codeunit "Bank Rec. Validation";
                begin
                    BankRecValidation.ValidateEndingBalance(Rec);
                end;
            }
        }
    }

    var
        StyleTxt: Text;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := SetStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Editable := true;
        OnAfterLineSelection(Rec);
    end;

    local procedure SetStyle(): Text
    begin
        if Rec.Matched then
            exit('Favorable');
        if Rec.Difference <> 0 then
            exit('Unfavorable');
        exit('');
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterLineSelection(BankRecLine: Record "Bank Reconciliation Line")
    begin
    end;

    procedure GetSelectedRecords(var TempBankRecLine: Record "Bank Reconciliation Line" temporary)
    var
        BankRecLine: Record "Bank Reconciliation Line";
    begin
        CurrPage.SetSelectionFilter(BankRecLine);
        if BankRecLine.FindSet() then
            repeat
                TempBankRecLine := BankRecLine;
                TempBankRecLine.Insert();
            until BankRecLine.Next() = 0;
    end;
}
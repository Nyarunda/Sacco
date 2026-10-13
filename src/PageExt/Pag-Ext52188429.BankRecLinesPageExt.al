pageextension 50064 BankRecLinesPageExt extends "Bank Acc. Reconciliation Lines"
{

    layout
    {
        modify("Statement Amount")
        {
            StyleExpr = CustomStyleExpression;
        }
        modify(Description)
        {
            StyleExpr = CustomStyleExpression;
        }
        modify("Transaction Date")
        {
            StyleExpr = CustomStyleExpression;
        }

        addafter("Document No.")
        {
            field("Same Document Nos"; Rec."Same Document Nos")
            {
                ApplicationArea = All;
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    begin
        SetCustomStyleExpression
    end;

    trigger OnAfterGetRecord()
    begin
        SetCustomStyleExpression
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetCustomStyleExpression
    end;

    local procedure SetCustomStyleExpression()
    begin
        CustomStyleExpression := Rec.SetStyleText();
    end;

    var
        CustomStyleExpression: Text[20];
}

pageextension 50087 "Apply Bank Acc Page Ext" extends "Apply Bank Acc. Ledger entries"
{
    layout
    {
        modify("Posting Date")
        {
            StyleExpr = CustomStyleExpression;
        }
        modify(Description)
        {
            StyleExpr = CustomStyleExpression;
        }
        modify("Remaining Amount")
        {
            StyleExpr = CustomStyleExpression;
        }
        addafter("Remaining Amount")
        {

            field("Statement Difference"; Rec."Statement Difference")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
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

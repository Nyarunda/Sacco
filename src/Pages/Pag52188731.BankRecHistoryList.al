page 52009 "Bank Rec. History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Rec. History Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Statement No."; Rec."Statement No.")
                {
                    ApplicationArea = All;
                }
                field("Statement Date"; Rec."Statement Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    ApplicationArea = All;
                }
                field(Reconciled; Rec.Reconciled)
                {
                    ApplicationArea = All;
                    StyleExpr = ReconciledStyle;
                }
            }
        }
    }

    views
    {
        view(Unreconciled)
        {
            Caption = 'Unreconciled Entries';
            Filters = where(Reconciled = const(false));
        }
        view(ReconciledE)
        {
            Caption = 'Reconciled Entries';
            Filters = where(Reconciled = const(true));
        }
    }

    var
        ReconciledStyle: Text;

    trigger OnAfterGetRecord()
    begin
        ReconciledStyle := SetStyle();
    end;

    local procedure SetStyle(): Text
    begin
        if Rec.Reconciled then
            exit('Favorable')
        else
            exit('Unfavorable');
    end;
}
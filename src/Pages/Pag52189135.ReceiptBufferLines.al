namespace UnitedWomen.UnitedWomen;

page 50837 "Receipt Buffer Lines"
{
    ApplicationArea = All;
    Caption = 'Receipt Buffer Lines';
    PageType = List;
    SourceTable = "Receipt Buffer Lines";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = LinesEditable;

                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = LinesEditable;
                }

                field("Member No."; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = LinesEditable;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = LinesEditable;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }

                field("Member Found"; Rec."Member Found")
                {
                    ApplicationArea = Basic;
                }
                field("Posted in G/L Entry"; Rec."Posted in G/L Entry")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies whether a matching G/L Entry exists for this batch no., transaction no., and member no.';
                }
                field("Posted in G/L Entry Reversed"; Rec."Posted in G/L Entry Reversed")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the Reversed value from the matching G/L Entry for this batch no., transaction no., and member no.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateLineControls();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateLineControls();
    end;

    trigger OnOpenPage()
    begin
        UpdateLineControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EnsureLineIsEditable();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EnsureLineIsEditable();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EnsureLineIsEditable();
    end;

    var
        ReceiptHeader: Record "Receipt Header";
        LinesEditable: Boolean;

    local procedure UpdateLineControls()
    begin
        LinesEditable := not Rec.Posted;
        if ReceiptHeader.Get(Rec."Batch No") then
            LinesEditable := LinesEditable and (not ReceiptHeader.Posted);

        CurrPage.Editable := LinesEditable;
    end;

    local procedure EnsureLineIsEditable()
    begin
        if Rec.Posted then
            Error('Receipt buffer line %1 is posted and cannot be edited.', Rec."Line No.");

        if ReceiptHeader.Get(Rec."Batch No") then
            if ReceiptHeader.Posted then
                Error('Receipt %1 is posted. Receipt buffer lines cannot be edited.', Rec."Batch No");
    end;
}

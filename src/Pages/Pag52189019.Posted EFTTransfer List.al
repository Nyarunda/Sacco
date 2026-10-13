namespace CentralDB.CentralDB;

page 50721 "Posted EFT Transfer List"
{
    ApplicationArea = All;
    Caption = 'Posted EFT Transfer List';
    PageType = List;
    SourceTable = "EFT Transfer";
    SourceTableView = where(Posted = const(true));
    DeleteAllowed = false;
    Editable = false;
    UsageCategory = Lists;
    CardPageId = "EFT Transfer Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentType; Rec."Payment Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field(PayingBankAccount; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(TotalVATAmount; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalWitholdingTaxAmount; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // "Payment Type" := "payment type"::Normal;
    end;

    trigger OnOpenPage()
    var
        pay: record "EFT Header";
    begin
        if pay.Get('') then begin
            pay.Delete();
            Commit();
        end;

        Rec.SetRange(Cashier, UserId);

    end;
}


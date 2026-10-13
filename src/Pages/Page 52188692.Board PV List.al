
Page 50355 "Board PV List"
{
    ApplicationArea = Basic;
    CardPageID = "Board PV Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Payment Header";
    SourceTableView = where(Posted = const(false), "Payment Type" = const(Board), Status = const(Open));
    UsageCategory = Lists;

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
        Rec."Payment Type" := Rec."payment type"::Board;
        Rec."Paying Account Type" := Rec."Paying Account Type"::"G/L Account";
    end;


    trigger OnOpenPage()
    var
        pay: record "Payment Header";
        Buser: Record "Banking User Setup";
        Teller: Boolean;
    begin
        if pay.Get('') then begin
            pay.Delete();
            Commit();
        end;

        Teller := false;
        if Buser.Get(UserId) then begin
            if Buser.Type = Buser.Type::Cashier then
                Teller := true;
        end;

        if not Teller then
            Rec.SetRange(Cashier, UserId);
    end;



}


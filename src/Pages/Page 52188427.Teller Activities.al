
Page 50019 "Teller Activities"
{
    PageType = CardPart;
    SourceTable = "Sacco Cues";

    layout
    {
        area(content)
        {
            cuegroup(Teller)
            {
                Caption = 'Teller';
                field(CashierTransOpen; Rec."Cashier Trans. - Open")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Style = Subordinate;
                    StyleExpr = true;
                }
                field(CashierTransPending; Rec."Cashier Trans. - Pending")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
                    StyleExpr = true;
                }
                field(CashierTransApproved; Rec."Cashier Trans. - Approved")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(CashierTransPosted; Rec."Cashier Trans. - Posted")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
            cuegroup(TreasuryTeller)
            {
                Caption = 'Treasury-Teller';
                field(TreasuryTellerOpen; Rec."Treasury/Teller - Open")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerPending; Rec."Treasury/Teller - Pending")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerApproved; Rec."Treasury/Teller - Approved")
                {
                    ApplicationArea = Basic;
                }
                field(TreasuryTellerPosted; Rec."Treasury/Teller - Posted")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}


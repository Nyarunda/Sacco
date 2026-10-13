Page 50398 "Coop ATM Charges"
{
    PageType = List;
    SourceTable = "Coop ATM Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field(BankCommission; Rec."Bank Commission")
                {
                    ApplicationArea = Basic;
                }
                field(SaccoCommission; Rec."Sacco Commission")
                {
                    ApplicationArea = Basic;
                }
                field(Terminal; Rec.Terminal)
                {
                    ApplicationArea = Basic;
                }
                field(Channel; Rec.Channel)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}


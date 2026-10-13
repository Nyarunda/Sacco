Table 50381 "IBT Lines"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; Date; DateTime)
        {
        }
        field(3; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT/RTGS';
            OptionMembers = " ",Cash,Cheque,EFT;
        }
        field(4; "Recieving Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bank Account"."No." where(Blocked = const(false));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Recieving Account");
                if BankAcc.Find('-') then begin
                    BankAcc.CalcFields(BankAcc.Balance, BankAcc."Balance (LCY)");
                    "Recieving Account Name" := BankAcc.Name;
                    "Recievin Account Currency Code" := BankAcc."Currency Code";
                    "Recieving Account Balance" := BankAcc.Balance;
                    "Receivin Account Balance (LCY)" := BankAcc."Balance (LCY)";
                    "Recieving Account Bank No." := BankAcc."Bank Account No.";
                end else begin
                    "Recieving Account Name" := '';
                    "Recievin Account Currency Code" := '';
                    "Recieving Account Balance" := 0;
                    "Receivin Account Balance (LCY)" := 0;
                end;


                Validate("Recievin Account Currency Code");
            end;
        }
        field(5; "Recieving Account Name"; Text[250])
        {
            Editable = false;
        }
        field(6; "Recievin Account Currency Code"; Code[10])
        {
            Caption = 'Recieving Account Currency Code';
            Editable = false;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                if "Recievin Account Currency Code" <> '' then begin
                    Currency_Exch_Rate.Reset;
                    Currency_Exch_Rate.SetRange(Currency_Exch_Rate."Currency Code", "Recievin Account Currency Code");
                    if Currency_Exch_Rate.Find('+') then begin
                        "Amount to Receive (LCY)" := 1 / Currency_Exch_Rate."Relational Exch. Rate Amount";
                        "Amount to Receive (LCY)" := ROUND("Amount to Receive" / "Amount to Receive (LCY)");
                    end else begin
                        Error(Text002, "Recievin Account Currency Code");
                    end;
                end else begin
                    "Amount to Receive (LCY)" := 1;
                    "Amount to Receive (LCY)" := ROUND("Amount to Receive" / "Amount to Receive (LCY)");
                end;
            end;
        }
        field(7; "Recieving Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(8; "Receivin Account Balance (LCY)"; Decimal)
        {
            Caption = 'Recieving Account Balance (LCY)';
            Editable = false;
        }
        field(9; "Recieving Account Bank No."; Code[20])
        {
        }
        field(10; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(11; "Amount to Receive"; Decimal)
        {

            trigger OnValidate()
            begin
                Validate("Recievin Account Currency Code");
            end;
        }
        field(12; "Amount to Receive (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(13; "Exchange Rate"; Decimal)
        {
        }
        field(14; "External Doc No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
            SumIndexFields = "Amount to Receive (LCY)";
        }
    }

    fieldgroups
    {
    }

    var
        BankAcc: Record "Bank Account";
        Currency_Exch_Rate: Record "Currency Exchange Rate";
        IBTHeader: Record "IBT Header";
        Text002: label 'Exchange Rate for Currency Code "%1" not defined in Currency Exchange Rates Setup';
}


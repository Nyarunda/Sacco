
Table 50189 "Imprest Surrender Lines"
{

    fields
    {
        field(1; "Surrender Doc No."; Code[20])
        {
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF Pay.GET(No) THEN
                // "Imprest Holder":=Pay."Account No.";
            end;
        }
        field(2; "Account No:"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));

            trigger OnValidate()
            begin
                /*
                IF GLAcc.GET("Account No:") THEN
                 "Account Name":=GLAcc.Name;
                 GLAcc.TESTFIELD("Direct Posting",TRUE);
                IF Pay.GET("Surrender Doc No.") THEN BEGIN
                 IF Pay."Account No."<>'' THEN
                "Imprest Holder":=Pay."Account No."
                  ELSE
                  ERROR('Please Enter the Customer/Account Number');
                END;
                 */

            end;
        }
        field(3; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            Editable = false;
        }
        field(5; "Due Date"; Date)
        {
            Editable = false;
        }
        field(6; "Imprest Holder"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7; "Actual Spent"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Actual Spent" > Amount then
                    Error('The Actual Spent Cannot be more than the Issued Amount');
                if "Currency Factor" <> 0 then
                    "Amount LCY" := "Actual Spent" / "Currency Factor"
                else
                    "Amount LCY" := "Actual Spent";

                "Cash Receipt Amount" := Amount - "Actual Spent";
            end;
        }
        field(8; "Apply to"; Code[20])
        {
            Editable = false;
        }
        field(9; "Apply to ID"; Code[20])
        {
            Editable = false;
        }
        field(10; "Surrender Date"; Date)
        {
            Editable = false;
        }
        field(11; Surrendered; Boolean)
        {
            Editable = false;
        }
        field(12; "Cash Receipt No"; Code[20])
        {
            TableRelation = "Teller Transaction" where("Account No." = field("Imprest Holder"));

            trigger OnValidate()
            var
                CustLedger: Record "Detailed Cust. Ledg. Entry";
            begin
                CustLedger.Reset;
                CustLedger.SetRange(CustLedger."Document No.", "Cash Receipt No");
                // CustLedger.SetRange(rever false);
                if CustLedger.Find('-') then begin
                    CustLedger.CalcSums(Amount);
                    "Cash Receipt Amount" := Abs(CustLedger.Amount)
                end
                else
                    "Cash Receipt Amount" := 0;
            end;
        }
        field(13; "Date Issued"; Date)
        {
            Editable = false;
        }
        field(14; "Type of Surrender"; Option)
        {
            OptionMembers = " ",Cash,Receipt;
        }
        field(15; "Dept. Vch. No."; Code[20])
        {
        }
        field(16; "Cash Surrender Amt"; Decimal)
        {
        }
        field(17; "Bank/Petty Cash"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(18; "Doc No."; Code[20])
        {
            Editable = false;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = Dimension;
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Editable = false;
            TableRelation = Dimension;
        }
        field(27; "VAT Prod. Posting Group"; Code[20])
        {
            Editable = false;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(28; "Imprest Type"; Code[20])
        {
            TableRelation = "Payment & Receipt Types".Code where(Type = const(Imprest));
        }
        field(85; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(86; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(87; "Amount LCY"; Decimal)
        {
        }
        field(88; "Cash Surrender Amt LCY"; Decimal)
        {
        }
        field(89; "Imprest Req Amt LCY"; Decimal)
        {
        }
        field(90; "Cash Receipt Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Cash Receipt Amount" := Amount - "Actual Spent";
            end;
        }
        field(91; "Line No."; Integer)
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Surrender Doc No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PaymentReceiptTypes: Record "Payment & Receipt Types";
}


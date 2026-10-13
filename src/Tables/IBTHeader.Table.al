Table 50380 "IBT Header"
{
    LookupPageId = "IBT List";
    DrillDownPageId = "IBT List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GenLedgerSetup.Get;
                    NoSeries.TestManual(GenLedgerSetup."InterBank Transfer No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; DateTime)
        {
            Editable = true;
        }
        field(3; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT/RTGS';
            OptionMembers = " ",Cash,Cheque,"Bank Slip","EFT/RTGS";
        }
        field(4; "Paying Account"; Code[20])
        {
            TableRelation = "Bank Account"."No." where(Blocked = const(false));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Paying Account");
                if BankAcc.Find('-') then begin
                    BankAcc.CalcFields(BankAcc.Balance, BankAcc."Balance (LCY)");
                    "Paying Account Name" := BankAcc.Name;
                    "Paying Account Currency Code" := BankAcc."Currency Code";
                    "Paying Account Balance" := BankAcc.Balance;
                    "Paying Account Balance (LCY)" := BankAcc."Balance (LCY)";
                    "Paying Account Bank No." := BankAcc."Bank Account No.";
                    // "Paying Account Max. Credit":=BankAcc."Maximum Credit Limit";
                    //aziz
                end else begin
                    "Paying Account Name" := '';
                    "Paying Account Currency Code" := '';
                    "Paying Account Balance" := 0;
                    "Paying Account Balance (LCY)" := 0;
                    "Paying Account Max. Credit" := 0;
                end;

                Validate("Paying Account Currency Code")
            end;
        }
        field(5; "Paying Account Name"; Text[250])
        {
            Editable = false;
        }
        field(6; "Paying Account Currency Code"; Code[20])
        {
            Editable = false;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                if "Paying Account Currency Code" <> '' then begin
                    Currency_Exch_Rate.Reset;
                    Currency_Exch_Rate.SetRange(Currency_Exch_Rate."Currency Code", "Paying Account Currency Code");
                    if Currency_Exch_Rate.Find('+') then begin
                        "Exchange Rate" := 1 / Currency_Exch_Rate."Relational Exch. Rate Amount";
                        "Amount to Transfer (LCY)" := ROUND("Amount to Transfer" / "Exchange Rate");
                    end else begin
                        Error(Text002, "Paying Account Currency Code");
                    end;
                end else begin
                    "Exchange Rate" := 1;
                    "Amount to Transfer (LCY)" := ROUND("Amount to Transfer" / "Exchange Rate");
                end;
            end;
        }
        field(7; "Paying Account Balance"; Decimal)
        {
            Editable = false;
        }
        field(8; "Paying Account Balance (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(9; "Paying Account Bank No."; Code[20])
        {
        }
        field(10; Status; Enum "Approval Status Enum")
        {
            Editable = false;
        }
        field(11; "Last Modified By"; Text[250])
        {
            Editable = false;
        }
        field(12; "Last Modified Date/Time"; DateTime)
        {
            Editable = false;
        }
        field(13; "Amount to Transfer"; Decimal)
        {

            trigger OnValidate()
            begin
                Validate("Paying Account Currency Code")
            end;
        }
        field(14; "Amount to Transfer (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(15; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(16; "Exchange Rate"; Decimal)
        {
            Editable = false;
        }
        field(17; "Cheque / Doc. No"; Code[30])
        {
        }
        field(18; "Transfer Release Date"; Date)
        {
            Editable = true;
        }
        field(19; "Total Lines Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("IBT Lines"."Amount to Receive (LCY)" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Remarks; Text[250])
        {
        }
        field(21; Posted; Boolean)
        {
            Editable = false;
        }
        field(22; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(23; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(24; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(25; "Posted On Computer Name"; Text[250])
        {
            Editable = false;
        }
        field(26; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(27; "Cancelled By"; Text[150])
        {
        }
        field(28; "Paying Account Max. Credit"; Decimal)
        {
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");

                if "Dimension Set ID" = 0 then begin
                    Usersetup.Get(UserId);
                    "Dimension Set ID" := Usersetup."Dimension Set ID";
                end;
            end;
        }
        field(34; "Currency Code Destination"; Code[20])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(35; "Currency Code Source"; Code[20])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(36; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."InterBank Transfer No.");
            "No." := NoSeries.GetNextNo(GenLedgerSetup."InterBank Transfer No.", WorkDate(), true);

            Usersetup.Get(UserId);
            "Dimension Set ID" := Usersetup."Dimension Set ID";
        end
    end;

    var
        Usersetup: Record "User Setup";
        BankAcc: Record "Bank Account";
        Currency_Exch_Rate: Record "Currency Exchange Rate";
        GenLedgerSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        Text002: label 'Exchange Rate for Currency Code "%1" not defined in Currency Exchange Rates Setup';
        DimMgt: Codeunit DimensionManagement;
        DimVal: Record "Dimension Value";


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'IBM', "No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}


table 50606 "Vendor Ledger Entry Migration"
{
    Caption = 'Vendor Ledger Entry Migration';
    DrillDownPageID = 29;
    LookupPageID = 29;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';

            trigger OnLookup()
            var
                IncomingDocument: Record 130;
            begin
                IncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
            end;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg Migration".Amount WHERE("Ledger Entry Amount" = CONST(true),
                                                                          "Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg Migration".Amount WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg Migration"."Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Entry Type" = FILTER("Initial Entry"),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amt. ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg Migration"."Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amt. ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            /*  CalcFormula = Sum("Detailed Vendor Ledg Migration"."Amount (LCY)" WHERE("Ledger Entry Amount" = CONST(true),
                                                                                   "Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                   "Posting Date" = FIELD("Date Filter")));
             Caption = 'Amount ($)';
             Editable = false;
             FieldClass = FlowField; */
        }
        field(18; "Purchase (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase ($)';
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount ($)';
        }
        field(21; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
        }
        field(22; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(25; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            begin
                // Legacy user lookup codeunit removed in current runtime.
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(33; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(34; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(36; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(37; "Due Date"; Date)
        {
            Caption = 'Due Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(38; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(39; "Original Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Pmt. Disc. Possible';
            Editable = false;
        }
        field(40; "Pmt. Disc. Rcd.(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Rcd.($)';
        }
        field(43; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(44; "Closed by Entry No."; Integer)
        {
            Caption = 'Closed by Entry No.';
            TableRelation = "Vendor Ledger Entry";
        }
        field(45; "Closed at Date"; Date)
        {
            Caption = 'Closed at Date';
        }
        field(46; "Closed by Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
        }
        field(47; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(52; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(53; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount ($)';
        }
        field(58; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg Migration"."Debit Amount" WHERE("Ledger Entry Amount" = CONST(true),
                                                                                  "Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg Migration"."Credit Amount" WHERE("Ledger Entry Amount" = CONST(true),
                                                                                   "Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                   "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg Migration"."Debit Amount (LCY)" WHERE("Ledger Entry Amount" = CONST(true),
                                                                                        "Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                        "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg Migration"."Credit Amount (LCY)" WHERE("Ledger Entry Amount" = CONST(true),
                                                                                         "Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                         "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(63; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(65; "Closed by Currency Code"; Code[10])
        {
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
        }
        field(66; "Closed by Currency Amount"; Decimal)
        {
            AccessByPermission = TableData 4 = R;
            AutoFormatExpression = "Closed by Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
        }
        field(73; "Adjusted Currency Factor"; Decimal)
        {
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(74; "Original Currency Factor"; Decimal)
        {
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(75; "Original Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg Migration".Amount WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                          "Entry Type" = FILTER("Initial Entry"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(77; "Remaining Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS(Amount, "Original Amount");

                IF "Remaining Pmt. Disc. Possible" * Amount < 0 THEN
                    FIELDERROR("Remaining Pmt. Disc. Possible", STRSUBSTNO(MustHaveSameSignErr, FIELDCAPTION(Amount)));

                IF ABS("Remaining Pmt. Disc. Possible") > ABS("Original Amount") THEN
                    FIELDERROR("Remaining Pmt. Disc. Possible", STRSUBSTNO(MustNotBeLargerErr, FIELDCAPTION("Original Amount")));
            end;
        }
        field(78; "Pmt. Disc. Tolerance Date"; Date)
        {
            Caption = 'Pmt. Disc. Tolerance Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(79; "Max. Payment Tolerance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS(Amount, "Remaining Amount");

                IF "Max. Payment Tolerance" * Amount < 0 THEN
                    FIELDERROR("Max. Payment Tolerance", STRSUBSTNO(MustHaveSameSignErr, FIELDCAPTION(Amount)));

                IF ABS("Max. Payment Tolerance") > ABS("Remaining Amount") THEN
                    FIELDERROR("Max. Payment Tolerance", STRSUBSTNO(MustNotBeLargerErr, FIELDCAPTION("Remaining Amount")));
            end;
        }
        field(81; "Accepted Payment Tolerance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Accepted Payment Tolerance';
        }
        field(82; "Accepted Pmt. Disc. Tolerance"; Boolean)
        {
            Caption = 'Accepted Pmt. Disc. Tolerance';
        }
        field(83; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Tolerance ($)';
        }
        field(84; "Amount to Apply"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount to Apply';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS("Remaining Amount");

                IF "Amount to Apply" * "Remaining Amount" < 0 THEN
                    FIELDERROR("Amount to Apply", STRSUBSTNO(MustHaveSameSignErr, FIELDCAPTION("Remaining Amount")));

                IF ABS("Amount to Apply") > ABS("Remaining Amount") THEN
                    FIELDERROR("Amount to Apply", STRSUBSTNO(MustNotBeLargerErr, FIELDCAPTION("Remaining Amount")));
            end;
        }
        field(85; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(86; "Applying Entry"; Boolean)
        {
            Caption = 'Applying Entry';
        }
        field(87; Reversed; Boolean)
        {
            Caption = 'Reversed';
        }
        field(88; "Reversed by Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
            TableRelation = "Vendor Ledger Entry";
        }
        field(89; "Reversed Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed Entry No.';
            TableRelation = "Vendor Ledger Entry";
        }
        field(90; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
            Numeric = true;

            trigger OnValidate()
            begin
                IF ("Creditor No." <> '') AND ("Recipient Bank Account" <> '') THEN
                    FIELDERROR("Recipient Bank Account",
                      STRSUBSTNO(FieldIsNotEmptyErr, FIELDCAPTION("Creditor No."), FIELDCAPTION("Recipient Bank Account")));
            end;
        }
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
            Numeric = true;

            trigger OnValidate()
            begin
                IF "Payment Reference" <> '' THEN
                    TESTFIELD("Creditor No.");
            end;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(173; "Applies-to Ext. Doc. No."; Code[35])
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        field(288; "Recipient Bank Account"; Code[10])
        {
            Caption = 'Recipient Bank Account';
            TableRelation = "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Vendor No."));

            trigger OnValidate()
            begin
                IF ("Recipient Bank Account" <> '') AND ("Creditor No." <> '') THEN
                    FIELDERROR("Creditor No.",
                      STRSUBSTNO(FieldIsNotEmptyErr, FIELDCAPTION("Recipient Bank Account"), FIELDCAPTION("Creditor No.")));
            end;
        }
        field(289; "Message to Recipient"; Text[140])
        {
            Caption = 'Message to Recipient';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            Caption = 'Exported to Payment File';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(10020; "IRS 1099 Code"; Code[10])
        {
            Caption = 'IRS 1099 Code';
        }
        field(10021; "IRS 1099 Amount"; Decimal)
        {
            Caption = 'IRS 1099 Amount';
        }
        field(50000; "Applies ID"; Code[20])
        {
        }
        field(50001; DocNo; Code[20])
        {
        }

        field(50036; Posted; Boolean)
        {
            Caption = 'Posted';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Vendor No.", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        }
        key(Key3; "Document No.", "Document Type", "Vendor No.")
        {
        }
        key(Key4; "External Document No.", "Document Type", "Vendor No.")
        {
        }
        key(Key5; "Vendor No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(Key6; Open, "Due Date")
        {
        }
        key(Key7; "Document Type", "Vendor No.", "Posting Date", "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        }
        key(Key8; "Closed by Entry No.")
        {
        }
        key(Key9; "Transaction No.")
        {
        }
        key(Key10; "Vendor No.", "Applies-to ID", Open, Positive, "Due Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Vendor No.", "Posting Date", "Document Type", "Document No.")
        {
        }
        fieldgroup(Brick; "Document No.", Description, "Remaining Amt. (LCY)", "Due Date")
        {
        }
    }

    var
        FieldIsNotEmptyErr: Label '%1 cannot be used while %2 has a value.', Comment = '%1=Field;%2=Field';
        MustHaveSameSignErr: Label 'must have the same sign as %1';
        MustNotBeLargerErr: Label 'must not be larger than %1';

    procedure ShowDoc(): Boolean
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        CASE "Document Type" OF
            "Document Type"::Invoice:
                IF PurchInvHeader.GET("Document No.") THEN BEGIN
                    EXIT(TRUE);
                END;
            "Document Type"::"Credit Memo":
                IF PurchCrMemoHdr.GET("Document No.") THEN BEGIN
                    EXIT(TRUE);
                END
        END;
    end;

    procedure DrillDownOnEntries(var DtldVendLedgEntry: Record "Detailed Vendor Ledg Migration")
    var
        VendLedgEntry: Record "Vendor Ledger Entry Migration";
    begin
        VendLedgEntry.RESET;
        DtldVendLedgEntry.COPYFILTER("Vendor No.", VendLedgEntry."Vendor No.");
        DtldVendLedgEntry.COPYFILTER("Currency Code", VendLedgEntry."Currency Code");
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
        VendLedgEntry.SETRANGE(Open, TRUE);
    end;

    procedure DrillDownOnOverdueEntries(var DtldVendLedgEntry: Record "Detailed Vendor Ledg Migration")
    var
        VendLedgEntry: Record "Vendor Ledger Entry Migration";
    begin
        VendLedgEntry.RESET;
        DtldVendLedgEntry.COPYFILTER("Vendor No.", VendLedgEntry."Vendor No.");
        DtldVendLedgEntry.COPYFILTER("Currency Code", VendLedgEntry."Currency Code");
        VendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
        VendLedgEntry.SETFILTER("Date Filter", '..%1', WORKDATE);
        VendLedgEntry.SETFILTER("Due Date", '<%1', WORKDATE);
        VendLedgEntry.SETFILTER("Remaining Amount", '<>%1', 0);
    end;

    procedure GetOriginalCurrencyFactor(): Decimal
    begin
        IF "Original Currency Factor" = 0 THEN
            EXIT(1);
        EXIT("Original Currency Factor");
    end;

    procedure ShowDimensions()
    var
        DimMgt: Codeunit "DimensionManagement";
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "Entry No."));
    end;

    procedure SetStyle(): Text
    begin
        IF Open THEN BEGIN
            IF WORKDATE > "Due Date" THEN
                EXIT('Unfavorable')
        END ELSE
            IF "Closed at Date" > "Due Date" THEN
                EXIT('Attention');
        EXIT('');
    end;

    procedure CopyFromGenJnlLine(GenJnlLine: Record "Gen. Journal Line")
    begin
        "Vendor No." := GenJnlLine."Account No.";
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        "Document Type" := GenJnlLine."Document Type".AsInteger();
        "Document No." := GenJnlLine."Document No.";
        "External Document No." := GenJnlLine."External Document No.";
        Description := GenJnlLine.Description;
        "Currency Code" := GenJnlLine."Currency Code";
        "Purchase (LCY)" := GenJnlLine."Sales/Purch. (LCY)";
        "Inv. Discount (LCY)" := GenJnlLine."Inv. Discount (LCY)";
        "Buy-from Vendor No." := GenJnlLine."Sell-to/Buy-from No.";
        "Vendor Posting Group" := GenJnlLine."Posting Group";
        "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := GenJnlLine."Dimension Set ID";
        "Purchaser Code" := GenJnlLine."Salespers./Purch. Code";
        "Source Code" := GenJnlLine."Source Code";
        "On Hold" := GenJnlLine."On Hold";
        "Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type".AsInteger();
        "Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
        "Due Date" := GenJnlLine."Due Date";
        "Pmt. Discount Date" := GenJnlLine."Pmt. Discount Date";
        "Applies-to ID" := GenJnlLine."Applies-to ID";
        "Journal Batch Name" := GenJnlLine."Journal Batch Name";
        "Reason Code" := GenJnlLine."Reason Code";
        "User ID" := USERID;
        "Bal. Account Type" := GenJnlLine."Bal. Account Type".AsInteger();
        "Bal. Account No." := GenJnlLine."Bal. Account No.";
        "No. Series" := GenJnlLine."Posting No. Series";
        "IC Partner Code" := GenJnlLine."IC Partner Code";
        Prepayment := GenJnlLine.Prepayment;
        "Recipient Bank Account" := GenJnlLine."Recipient Bank Account";
        "Message to Recipient" := GenJnlLine."Message to Recipient";
        "Applies-to Ext. Doc. No." := GenJnlLine."Applies-to Ext. Doc. No.";
        "Creditor No." := GenJnlLine."Creditor No.";
        "Payment Reference" := GenJnlLine."Payment Reference";
        "Payment Method Code" := GenJnlLine."Payment Method Code";
        "Exported to Payment File" := GenJnlLine."Exported to Payment File";

        OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec, GenJnlLine);
    end;

    procedure CopyFromCVLedgEntryBuffer(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        "Entry No." := CVLedgerEntryBuffer."Entry No.";
        "Vendor No." := CVLedgerEntryBuffer."CV No.";
        "Posting Date" := CVLedgerEntryBuffer."Posting Date";
        "Document Type" := CVLedgerEntryBuffer."Document Type".AsInteger();
        "Document No." := CVLedgerEntryBuffer."Document No.";
        Description := CVLedgerEntryBuffer.Description;
        "Currency Code" := CVLedgerEntryBuffer."Currency Code";
        Amount := CVLedgerEntryBuffer.Amount;
        "Remaining Amount" := CVLedgerEntryBuffer."Remaining Amount";
        "Original Amount" := CVLedgerEntryBuffer."Original Amount";
        "Original Amt. (LCY)" := CVLedgerEntryBuffer."Original Amt. (LCY)";
        "Remaining Amt. (LCY)" := CVLedgerEntryBuffer."Remaining Amt. (LCY)";
        "Amount (LCY)" := CVLedgerEntryBuffer."Amount (LCY)";
        "Purchase (LCY)" := CVLedgerEntryBuffer."Sales/Purchase (LCY)";
        "Inv. Discount (LCY)" := CVLedgerEntryBuffer."Inv. Discount (LCY)";
        "Buy-from Vendor No." := CVLedgerEntryBuffer."Bill-to/Pay-to CV No.";
        "Vendor Posting Group" := CVLedgerEntryBuffer."CV Posting Group";
        "Global Dimension 1 Code" := CVLedgerEntryBuffer."Global Dimension 1 Code";
        "Global Dimension 2 Code" := CVLedgerEntryBuffer."Global Dimension 2 Code";
        "Dimension Set ID" := CVLedgerEntryBuffer."Dimension Set ID";
        "Purchaser Code" := CVLedgerEntryBuffer."Salesperson Code";
        "User ID" := CVLedgerEntryBuffer."User ID";
        "Source Code" := CVLedgerEntryBuffer."Source Code";
        "On Hold" := CVLedgerEntryBuffer."On Hold";
        "Applies-to Doc. Type" := CVLedgerEntryBuffer."Applies-to Doc. Type".AsInteger();
        "Applies-to Doc. No." := CVLedgerEntryBuffer."Applies-to Doc. No.";
        Open := CVLedgerEntryBuffer.Open;
        "Due Date" := CVLedgerEntryBuffer."Due Date";
        "Pmt. Discount Date" := CVLedgerEntryBuffer."Pmt. Discount Date";
        "Original Pmt. Disc. Possible" := CVLedgerEntryBuffer."Original Pmt. Disc. Possible";
        "Remaining Pmt. Disc. Possible" := CVLedgerEntryBuffer."Remaining Pmt. Disc. Possible";
        "Pmt. Disc. Rcd.(LCY)" := CVLedgerEntryBuffer."Pmt. Disc. Given (LCY)";
        Positive := CVLedgerEntryBuffer.Positive;
        "Closed by Entry No." := CVLedgerEntryBuffer."Closed by Entry No.";
        "Closed at Date" := CVLedgerEntryBuffer."Closed at Date";
        "Closed by Amount" := CVLedgerEntryBuffer."Closed by Amount";
        "Applies-to ID" := CVLedgerEntryBuffer."Applies-to ID";
        "Journal Batch Name" := CVLedgerEntryBuffer."Journal Batch Name";
        "Reason Code" := CVLedgerEntryBuffer."Reason Code";
        "Bal. Account Type" := CVLedgerEntryBuffer."Bal. Account Type".AsInteger();
        "Bal. Account No." := CVLedgerEntryBuffer."Bal. Account No.";
        "Transaction No." := CVLedgerEntryBuffer."Transaction No.";
        "Closed by Amount (LCY)" := CVLedgerEntryBuffer."Closed by Amount (LCY)";
        "Debit Amount" := CVLedgerEntryBuffer."Debit Amount";
        "Credit Amount" := CVLedgerEntryBuffer."Credit Amount";
        "Debit Amount (LCY)" := CVLedgerEntryBuffer."Debit Amount (LCY)";
        "Credit Amount (LCY)" := CVLedgerEntryBuffer."Credit Amount (LCY)";
        "Document Date" := CVLedgerEntryBuffer."Document Date";
        "External Document No." := CVLedgerEntryBuffer."External Document No.";
        "No. Series" := CVLedgerEntryBuffer."No. Series";
        "Closed by Currency Code" := CVLedgerEntryBuffer."Closed by Currency Code";
        "Closed by Currency Amount" := CVLedgerEntryBuffer."Closed by Currency Amount";
        "Adjusted Currency Factor" := CVLedgerEntryBuffer."Adjusted Currency Factor";
        "Original Currency Factor" := CVLedgerEntryBuffer."Original Currency Factor";
        "Pmt. Disc. Tolerance Date" := CVLedgerEntryBuffer."Pmt. Disc. Tolerance Date";
        "Max. Payment Tolerance" := CVLedgerEntryBuffer."Max. Payment Tolerance";
        "Accepted Payment Tolerance" := CVLedgerEntryBuffer."Accepted Payment Tolerance";
        "Accepted Pmt. Disc. Tolerance" := CVLedgerEntryBuffer."Accepted Pmt. Disc. Tolerance";
        "Pmt. Tolerance (LCY)" := CVLedgerEntryBuffer."Pmt. Tolerance (LCY)";
        "Amount to Apply" := CVLedgerEntryBuffer."Amount to Apply";
        Prepayment := CVLedgerEntryBuffer.Prepayment;
    end;

    procedure RecalculateAmounts(FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; PostingDate: Date)
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        IF ToCurrencyCode = FromCurrencyCode THEN
            EXIT;

        "Remaining Amount" :=
          CurrExchRate.ExchangeAmount("Remaining Amount", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Remaining Pmt. Disc. Possible" :=
          CurrExchRate.ExchangeAmount("Remaining Pmt. Disc. Possible", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Accepted Payment Tolerance" :=
          CurrExchRate.ExchangeAmount("Accepted Payment Tolerance", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Amount to Apply" :=
          CurrExchRate.ExchangeAmount("Amount to Apply", FromCurrencyCode, ToCurrencyCode, PostingDate);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry Migration"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;
}


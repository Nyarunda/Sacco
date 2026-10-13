
Table 50188 "Imprest Surrender Header"
{
    DrillDownPageID = "Imprest Surrender List";
    LookupPageID = "Imprest Surrender List";

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Imprest Surrender No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Surrender Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment & Receipt Types".Code where(Type = filter(Payment));

            trigger OnValidate()
            begin

                "Account No." := '';
                "Account Name" := '';
                Remarks := '';

                PaymentReceiptTypes.Reset;
                PaymentReceiptTypes.SetRange(PaymentReceiptTypes.Code, Type);
                PaymentReceiptTypes.SetRange(PaymentReceiptTypes.Type, PaymentReceiptTypes.Type::Payment);
                if PaymentReceiptTypes.Find('-') then begin
                    Grouping := PaymentReceiptTypes."Default Grouping";
                    "Account Type" := PaymentReceiptTypes."Account Type";
                    "Account No." := PaymentReceiptTypes."Account No.";
                end;



                //VALIDATE("Account No.");
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 1","Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(5; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Received From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "On Behalf Of"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Cashier; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Account Type" = const(Imprest));


            trigger OnValidate()
            begin
                /*
                "Account Name":='';
                PaymentReceiptTypes.RESET;
                PaymentReceiptTypes.SETRANGE(PaymentReceiptTypes.Code,Type);
                PaymentReceiptTypes.SETRANGE(PaymentReceiptTypes.Type,PaymentReceiptTypes.Type::Payment);
                
                IF "Account Type" IN ["Account Type"::"G/L Account","Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"]
                THEN
                
                CASE "Account Type" OF
                  "Account Type"::"G/L Account":
                    BEGIN
                      GLAcc.GET("Account No.");
                      "Account Name":=GLAcc.Name;
                      "VAT Code":=PaymentReceiptTypes."VAT Code";
                      "Withholding Tax Code":=PaymentReceiptTypes."Withholding Tax Code";
                      "Global Dimension 1 Code":='';
                    END;
                  "Account Type"::Customer:
                    BEGIN
                      Cust.GET("Account No.");
                      "Account Name":=Cust.Name;
                //      "VAT Code":=Cust."Default Withholding Tax Code";
                //      "Withholding Tax Code":=Cust."Default Withholding Tax Code";
                      "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    END;
                  "Account Type"::Vendor:
                    BEGIN
                      Vend.GET("Account No.");
                      "Account Name":=Vend.Name;
                //      "VAT Code":=Vend."Default VAT Code";
                //      "Withholding Tax Code":=Vend."Default Withholding Tax Code";
                      "Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                    END;
                  "Account Type"::"Bank Account":
                    BEGIN
                      BankAcc.GET("Account No.");
                      "Account Name":=BankAcc.Name;
                      "VAT Code":=PaymentReceiptTypes."VAT Code";
                      "Withholding Tax Code":=PaymentReceiptTypes."Withholding Tax Code";
                      "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                
                    END;
                    {
                  "Account Type"::"Fixed Asset":
                    BEGIN
                      FA.GET("Account No.");
                      "Account Name":=FA.Description;
                      "VAT Code":=FA."Default VAT Code";
                      "Withholding Tax Code":=FA."Default Withholding Tax Code";
                       "Global Dimension 1 Code":=FA."Global Dimension 1 Code";
                    END;
                    }
                END;
                */

            end;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Transaction Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(33; "Bank Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected,Cancelled;
        }
        field(37; Grouping; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Petty Cash";
        }
        field(39; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Other;
        }
        field(42; "Apply to ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Imprest Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Imprest Issue No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Imprest Header"."No." where(Posted = const(true),
                                                          "Account No." = field("Account No."));

            trigger OnValidate()
            var
                LineNo: Integer;
            begin
                //IF "Responsibility Center" = '' THEN
                //  ERROR('Specify the responsibility center');





                ImprestHeader.Get(Rec."Imprest Issue No.");

                /*Copy the details to the user interface*/
                Payee := ImprestHeader.Payee;
                ImprestHeader.CalcFields(ImprestHeader."Total Net Amount");
                Amount := ImprestHeader."Total Net Amount";
                "Amount Surrendered LCY" := ImprestHeader."Total Net Amount LCY";
                //Currencies
                "Currency Factor" := ImprestHeader."Currency Factor";
                "Currency Code" := ImprestHeader."Currency Code";

                "Date Posted" := ImprestHeader."Date Posted";
                "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                Validate("Global Dimension 1 Code");
                "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
                "Imprest Issue Date" := ImprestHeader.Date;



                //Get Line No
                if ImprestSurrenderLines.FindLast then
                    LineNo := ImprestSurrenderLines."Line No." + 1
                else
                    LineNo := LineNo + 1;

                /*Copy the detail lines from the imprest details table in the database*/

                ImprestLines.Reset;
                ImprestLines.SetRange(ImprestLines.No, "Imprest Issue No.");
                if ImprestLines.Find('-') then /*Copy the lines to the line table in the database*/
                  begin
                    repeat
                        ImprestSurrenderLines.Init;
                        ImprestSurrenderLines."Surrender Doc No." := Rec.No;
                        ImprestSurrenderLines."Account No:" := ImprestLines."Account No:";
                        ImprestSurrenderLines."Imprest Type" := ImprestLines."Advance Type";
                        ImprestSurrenderLines.Validate(ImprestSurrenderLines."Account No:");
                        ImprestSurrenderLines."Account Name" := ImprestLines.Purpose;//ImprestLines."Account Name";
                        ImprestSurrenderLines.Amount := ImprestLines.Amount;
                        ImprestSurrenderLines."Due Date" := ImprestLines."Due Date";
                        ImprestSurrenderLines."Imprest Holder" := ImprestLines."Imprest Holder";
                        ImprestSurrenderLines."Actual Spent" := ImprestLines."Actual Spent";
                        ImprestSurrenderLines."Apply to" := ImprestLines."Apply to";
                        ImprestSurrenderLines."Apply to ID" := ImprestLines."Apply to ID";
                        ImprestSurrenderLines."Surrender Date" := ImprestLines."Surrender Date";
                        ImprestSurrenderLines.Surrendered := ImprestLines.Surrendered;
                        ImprestSurrenderLines."Cash Receipt No" := ImprestLines."M.R. No";
                        ImprestSurrenderLines."Date Issued" := ImprestLines."Date Issued";
                        ImprestSurrenderLines."Type of Surrender" := ImprestLines."Type of Surrender";
                        ImprestSurrenderLines."Dept. Vch. No." := ImprestLines."Dept. Vch. No.";
                        ImprestSurrenderLines."Currency Factor" := ImprestLines."Currency Factor";
                        ImprestSurrenderLines."Currency Code" := ImprestLines."Currency Code";
                        ImprestSurrenderLines."Imprest Req Amt LCY" := ImprestLines."Amount LCY";
                        ImprestSurrenderLines."Shortcut Dimension 1 Code" := ImprestLines."Global Dimension 1 Code";
                        ImprestSurrenderLines."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                        ImprestSurrenderLines."Dimension Set ID" := ImprestLines."Dimension Set ID";
                        LineNo += 1;
                        ImprestSurrenderLines."Line No." := LineNo;
                        ImprestSurrenderLines.Insert;
                    until ImprestLines.Next = 0;
                end;

            end;
        }
        field(47; "Vote Book"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(48; "Total Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Total Expenditure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Total Commitments"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Balance Less this Entry"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Petty Cash"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(59; "Function Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Budget Center Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(62; "Issue Voucher Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Cash Voucher","Payment Voucher";
        }
        field(85; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(86; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Currency;
        }
        field(87; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
            end;
        }
        field(88; "Amount Surrendered LCY"; Decimal)
        {
            CalcFormula = sum("Imprest Surrender Lines"."Imprest Req Amt LCY" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
        }
        field(89; "Actual Spent"; Decimal)
        {
            CalcFormula = sum("Imprest Surrender Lines"."Actual Spent" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status = Status::Cancelled then
            Error('Cannot Delete Document is already Posted');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Imprest Surrender No");
            No := NoSeries.GetNextNo(SalesSetup."Imprest Surrender No", WorkDate(), true);
        end;

        "Account Type" := "account type"::Customer;
        "Surrender Date" := Today;
        Cashier := UserId;
        Validate(Cashier);
    end;

    trigger OnModify()
    begin
        if Status = Status::Cancelled then
            Error('Cannot Modify Document is already Posted');
    end;

    var
        NoSeries: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        PaymentReceiptTypes: Record "Payment & Receipt Types";
        ImprestHeader: Record "Imprest Header";
        ImprestLines: Record "Imprest Lines";
        ImprestSurrenderLines: Record "Imprest Surrender Lines";
}


table 50516 "Imprest Requisition"
{
    Caption = 'Imprest Requisition';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin

            end;
        }
        field(9; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "On Behalf Of"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Cashier; Code[60])
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
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(35; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected,Cancelled;
        }
        field(38; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Imprest;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(57; "Function Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Budget Center Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Total Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Current Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Pay Mode" = "pay mode"::Cash then begin

                    "Cheque No." := '';
                end;
            END;
        }
        field(67; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit",Mpesa,"Custom 4","Custom 5";
        }
        field(68; "Payment Release Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                //Changed to ensure Release date is not less than the Date entered
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(69; "No. Printed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "VAT Base Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Currency Reciprical"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Current Source A/C Bal."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Register Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "To Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Currency;
        }
        field(79; "Total Net Amount LCY"; Decimal)
        {
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Payment Voucher","Petty Cash";
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(86; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(87; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = if ("Account Type" = const(Customer)) Customer;

            trigger OnValidate()
            begin
                Cust.Reset;
                if Cust.Get("Account No.") then begin
                    //Cust.TESTFIELD("Gen. Bus. Posting Group");
                    Cust.TestField(Blocked, Cust.Blocked::" ");
                    Payee := Cust.Name;
                    "On Behalf Of" := Cust.Name;

                    Cust.CalcFields(Cust."Balance (LCY)");
                    if Cust."Credit Limit (LCY)" > 0 then
                        if Cust."Balance (LCY)" > Cust."Credit Limit (LCY)" then
                            Error('The allowable unaccounted balance of %1 has been exceeded', Cust."Credit Limit (LCY)");


                end;
            end;
        }
        field(88; "Surrender Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Full,Partial;
        }
        field(89; Purpose; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Employee Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Employee Statistics Group";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50000; Requisition; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No.";
        }
        field(50001; "Bal. Account No."; Code[20])
        {
            Caption = 'Payment Account';
            DataClassification = ToBeClassified;
            TableRelation = if ("Bal. Account Type" = const("Bank Account")) "Bank Account"."No."
            else
            if ("Bal. Account Type" = const(Savings)) "Savings Accounts"."No." where("Member No." = field("Member No."), "Product Category" = Filter("Ordinary Savings"));

            trigger OnValidate()
            begin
                /*
                  //Savings Accounts
                  "Bal. Account Type"::Savings:
                    BEGIN
                      SavAcc.GET("Bal. Account No.");
                      SavAcc.CheckBlockedCustOnJnls(SavAcc,"Document Type",FALSE);
                      {IF savacc."IC Partner Code" <> '' THEN BEGIN
                        IF GenJnlTemplate.GET("Journal Template Name") THEN;
                        IF (savacc."IC Partner Code" <> '') AND ICPartner.GET(Cust."IC Partner Code") THEN BEGIN
                          ICPartner.CheckICPartnerIndirect(FORMAT("Bal. Account Type"),"Bal. Account No.");
                          "IC Partner Code" := savacc."IC Partner Code";
                        END;
                      END;
                      }
                      IF "Account No." = '' THEN
                        Description := SavAcc.Name;
                
                      //"Payment Method Code" := savacc."Payment Method Code";
                      //VALIDATE("Recipient Bank Account",savacc."Preferred Bank Account");
                      "Posting Group" := SavAcc."Customer Posting Group";
                      "Salespers./Purch. Code" := SavAcc."Recruited By";
                     // "Payment Terms Code" := savacc."Payment Terms Code";
                      VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
                      VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
                      IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
                        "Currency Code" := SavAcc."Currency Code";
                      IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
                        "Currency Code" := SavAcc."Currency Code";
                      ClearBalancePostingGroups;
                      //IF (savacc."Bill-to Customer No." <> '') AND (savacc."Bill-to Customer No." <> "Bal. Account No.") THEN
                        //IF NOT CONFIRM(Text014,FALSE,savacc.TABLECAPTION,savacc."No.",savacc.FIELDCAPTION("Bill-to Customer No."),
                            // savacc."Bill-to Customer No.")
                       // THEN
                        //  ERROR('');
                      VALIDATE("Payment Terms Code");
                      CheckPaymentTolerance;
                    END;
                
                   "Bal. Account Type"::Credit:
                    BEGIN
                    CrAcc.GET("Bal. Account No.");
                      CrAcc.CheckBlockedCustOnJnls(CrAcc,"Document Type",FALSE);
                      {IF savacc."IC Partner Code" <> '' THEN BEGIN
                        IF GenJnlTemplate.GET("Journal Template Name") THEN;
                        IF (crAcc."IC Partner Code" <> '') AND ICPartner.GET(Cust."IC Partner Code") THEN BEGIN
                          ICPartner.CheckICPartnerIndirect(FORMAT("Bal. Account Type"),"Bal. Account No.");
                          "IC Partner Code" := crAcc."IC Partner Code";
                        END;
                      END;
                      }
                      IF "Account No." = '' THEN
                        Description := CrAcc.Name;
                
                      //"Payment Method Code" := savacc."Payment Method Code";
                      //VALIDATE("Recipient Bank Account",savacc."Preferred Bank Account");
                      "Posting Group" := CrAcc."Customer Posting Group";
                      "Salespers./Purch. Code" := CrAcc."Recruited By";
                     // "Payment Terms Code" := crAcc."Payment Terms Code";
                      VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
                      VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
                      IF ("Account No." = '') OR ("Account Type" = "Account Type"::"G/L Account") THEN
                        "Currency Code":= CrAcc."Currency Code";
                      IF ("Account Type" = "Account Type"::"Bank Account") AND ("Currency Code" = '') THEN
                        "Currency Code" := CrAcc."Currency Code";
                      ClearBalancePostingGroups;
                      //IF (savacc."Bill-to Customer No." <> '') AND (savacc."Bill-to Customer No." <> "Bal. Account No.") THEN
                        //IF NOT CONFIRM(Text014,FALSE,savacc.TABLECAPTION,savacc."No.",savacc.FIELDCAPTION("Bill-to Customer No."),
                            // savacc."Bill-to Customer No.")
                       // THEN
                        //  ERROR('');
                      VALIDATE("Payment Terms Code");
                      CheckPaymentTolerance;
                    END;
                */

            end;
        }
        field(50002; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Payment Account Type';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Bal. Account No." := '';
                if UserSetup.Get(UserId) then begin

                    if "Bal. Account Type" = "bal. account type"::Savings then begin
                        UserSetup.TestField("Member No.");


                        Savings.Reset;
                        Savings.SetRange("Member No.", UserSetup."Member No.");
                        Savings.SetRange("Product Category", Savings."product category"::"Ordinary Savings");
                        if Savings.FindFirst then begin
                            "Bal. Account No." := Savings."No.";
                            Payee := Savings.Name;
                            "On Behalf Of" := Savings.Name;
                            "Member No." := UserSetup."Member No.";
                        end
                        else
                            Error('Staff does not have a Staff Savings Account');


                    end;

                    Validate("Bal. Account No.");
                end
                else
                    Error('User must be setup under UserSetup Other Advance Staff Account and their respective Account Entered');
            end;
        }
        field(50003; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Requisition Used"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Imprest Header" where("Requsition No." = field("No."), Posted = const(true)));
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
        fieldgroup(DropDown; "No.", Purpose, "Total Net Amount", Date)
        {


        }
    }

    trigger OnDelete()
    begin
        Error('You Cannot Delete this record');
    end;


    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;

            SalesSetup.TestField(SalesSetup."Requisition Imprest No");
            "No." := NoSeries.GetNextNo(SalesSetup."Requisition Imprest No", WorkDate(), true);

        end;




        Date := Today;
        Cashier := UserId;
        Validate(Cashier);


        if UserSetup.Get(UserId) then begin

            UserSetup.testfield("Global Dimension 1 Code");
            UserSetup.testfield("Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            UserSetup.TestField(UserSetup."Imprest Account");
            "Account Type" := "account type"::Customer;
            "Account No." := UserSetup."Imprest Account";
            Validate("Account No.");

            "Member No." := UserSetup."Member No.";

            UserSetup.TestField("Member No.");
            "Bal. Account Type" := "bal. account type"::"Bank Account";

            /* 
            Savings.Reset;
            Savings.SetRange("Member No.", UserSetup."Member No.");
            Savings.SetRange("Product Category", Savings."product category"::"Ordinary Savings");
            if Savings.FindFirst then
                "Bal. Account No." := Savings."No."
            else
                Error('Staff does not have a Staff Savings Account');
             */
            Validate("Account No.");
        end
        else
            Error('User must be setup under UserSetup Other Advance Staff Account and their respective Account Entered');
    end;

    trigger OnModify()
    begin
        if Status = Status::Open then
            UpdateHeaderToLine;
    end;

    var
        NoSeries: Codeunit "No. Series";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        ImpLines: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        UserSetup: Record "User Setup";
        Savings: Record "Savings Accounts";


    procedure UpdateHeaderToLine()
    var
        ImprestLines: Record "Imprest Lines";
    begin
        ImprestLines.Reset;
        ImprestLines.SetRange(ImprestLines.No, "No.");
        if ImprestLines.Find('-') then begin
            repeat
                ImprestLines."Imprest Holder" := "Account No.";
                ImprestLines."Global Dimension 1 Code" := "Global Dimension 1 Code";
                ImprestLines."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                ImprestLines."Dimension Set ID" := "Dimension Set ID";
                ImprestLines."Currency Code" := "Currency Code";
                ImprestLines."Currency Factor" := "Currency Factor";
                ImprestLines.Validate("Currency Factor");
                ImprestLines.Modify;
            until ImprestLines.Next = 0;
        end;
    end;


    procedure ImpLinesExist(): Boolean
    begin
        ImpLines.Reset;
        ImpLines.SetRange(No, "No.");
        exit(ImpLines.FindFirst);
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;
}



Table 50168 "Banking User Setup"
{

    fields
    {
        field(1; "User Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "User Setup";

            trigger OnValidate()
            begin

                UserSetup.Get("User Name");
                UserSetup.TestField("Global Dimension 1 Code");
                UserSetup.TestField("Global Dimension 2 Code");

                "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            end;
        }
        field(2; "Cashier Journal Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(3; "Cashier Journal Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Cashier Journal Template"));

            trigger OnValidate()
            begin

                BUser.Reset;
                BUser.SetRange(BUser."Cashier Journal Template", "Cashier Journal Template");
                BUser.SetRange(BUser."Cashier Journal Batch", "Cashier Journal Batch");
                if BUser.FindFirst then begin
                    repeat
                        if (BUser."User Name" <> "User Name") and ("Cashier Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until BUser.Next = 0;
                end;
            end;
        }
        field(6; "Default  Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" where("Bank Type" = filter(Cashier | Treasury));

            trigger OnValidate()
            begin
                if "Default  Bank" <> '' then begin
                    BUser.Reset;
                    BUser.SetRange(BUser."Default  Bank", "Default  Bank");
                    if BUser.FindFirst then begin
                        repeat
                            if BUser."User Name" <> "User Name" then begin
                                Error('Please note that another user has been assigned the same bank.');
                            end;
                        until BUser.Next = 0;
                    end;

                end;
            end;
        }
        field(7; "Default RTGS Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                /* if "Default RTGS Bank" <> '' then begin
                    BUser.Reset;
                     BUser.SetRange(BUser."Default  Bank", "Default  Bank");
                     if BUser.FindFirst then begin
                         repeat
                             if BUser."User Name" <> "User Name" then begin
                                 Error('Please note that another user has been assigned the same bank.');
                             end;
                         until BUser.Next = 0;
                     end;

                 end; */
            end;
        }
        field(11; "Max. Deposit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Max. Withdrawal Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Max. Cashier Withholding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Min. Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;

            TableRelation = Members;



            trigger OnValidate()
            begin
                BUser.Reset;
                BUser.SetRange(BUser."Member No.", "Member No.");
                if BUser.FindFirst then begin
                    repeat
                        if (BUser."User Name" <> "User Name") and ("Member No." <> '') then begin
                            Error('Please note that another user has been assigned the same member No.');
                        end;
                    until BUser.Next = 0;
                end;
            end;
        }
        field(16; "Bankers Cheque Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(17; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cashier,Treasury';
            OptionMembers = " ",Cashier,Treasury;

            trigger OnValidate()
            begin
                "Default  Bank" := '';
            end;
        }
        field(18; "MPESA Disbursement A/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(19; "Cheque Disbursement A/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(29; "Excess Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Account Type" = const("Cashier Excess"));

            trigger OnValidate()
            begin
                BUser.Reset;
                BUser.SetRange(BUser."Excess Account", "Excess Account");
                if BUser.FindFirst then begin
                    repeat
                        if (BUser."User Name" <> Rec."User Name") and ("Excess Account" <> '') then begin
                            Error('Please note that another user has been assigned the same Account');
                        end;
                    until BUser.Next = 0;
                end;
            end;
        }
        field(30; "Shortage Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Account Type" = const("Cashier Shortage"));

            trigger OnValidate()
            begin
                BUser.Reset;
                BUser.SetRange(BUser."Shortage Account", "Shortage Account");
                if BUser.FindFirst then begin
                    repeat
                        if (BUser."User Name" <> Rec."User Name") and ("Shortage Account" <> '') then begin
                            Error('Please note that another user has been assigned the same Account');
                        end;
                    until BUser.Next = 0;
                end;
            end;
        }
        field(31; "Cheque Clearance Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" where("Bank Type" = filter(Normal));
        }
        field(36; "Supervisor Mobile No"; Code[13])
        {
            CharAllowed = '0123456789';
            DataClassification = ToBeClassified;
        }
        field(37; "Supervisor E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(43; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(44; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(45; "Default  Cheque Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(46; "MPesa Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(47; "MPesa Customer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Mpesa));
        }
        field(48; "Shop Customer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Shop));
        }
        field(49; "MPESA Transaction Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Max. MPESA Withholding"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Chief Accountant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Chief Cashier"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Cust. Service Cheque Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(54; "MBS Cheque GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(55; "Equity Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(56; "Equity Customer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Mpesa));
        }
        field(57; "Super Agent Customer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Mpesa));
        }
        field(58; "Super Agent Transaction Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Super Treasury User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Treasury Treshhold"; Decimal)
        {
        }
        field(61; "Treasury Alert %"; Decimal)
        {
        }
        field(62; "Teller Alert %"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserSetup: Record "User Setup";
        BUser: Record "Banking User Setup";
}


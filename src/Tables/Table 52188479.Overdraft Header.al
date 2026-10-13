
Table 50142 "Overdraft Header"
{
   

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeries.TestManual(NoSetup."Overdraft Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin

                if Account.Get("Account No.") then begin
                    "Account Name" := Account.Name;
                    "Product Type" := Account."Product Type";
                    "Member No." := Account."Member No.";

                    if MemberActivities.IsDefaulter("Member No.") then
                        Error('Member is Defaulter');

                    if ProductTypes.Get("Product Type") then begin
                        ProductTypes.TestField("Allow Overdraft");
                        //ProductTypes.TESTFIELD(ProductTypes."Over Draft Interest Account");
                        "Overdraft Interest %" := ProductTypes."Over Draft Interest %";
                    end;
                end;
            end;
        }
        field(3; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Effective/Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Expiry Date" := CalcDate(Duration, "Effective/Start Date");
                Validate("Expiry Date");
            end;
        }
        field(6; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                AllowMultipleOD := false;

                if ("Effective/Start Date" <> 0D) and ("Expiry Date" <> 0D) then begin
                    if Account.Get("Account No.") then begin
                        if ProductTypes.Get("Product Type") then begin
                            AllowMultipleOD := ProductTypes."Allow Multiple Over Draft";
                        end;
                    end;


                    OverDraftAuth.Reset;
                    OverDraftAuth.SetCurrentkey(OverDraftAuth."Account No.", OverDraftAuth.Status, OverDraftAuth.Expired);
                    OverDraftAuth.SetRange(OverDraftAuth."Account No.", "Account No.");
                    OverDraftAuth.SetRange(OverDraftAuth.Status, OverDraftAuth.Status::Pending);
                    OverDraftAuth.SetRange(OverDraftAuth.Expired, false);
                    if OverDraftAuth.Find('-') then begin
                        repeat
                            if ("Effective/Start Date" >= OverDraftAuth."Effective/Start Date") and ("Effective/Start Date" <= OverDraftAuth."Expiry Date") then begin
                                if AllowMultipleOD = true then begin
                                    if Confirm('There is an already approved Over Draft within the specified period. - %1. Do you wish to issue another one?' +
                                       '', false, OverDraftAuth."No.") = false then
                                        Error('Process Terminated.');
                                end else
                                    Error('There is an already approved Over Draft within the specified period. - %1. Cancel an existing one if you' +
                                           ' want to issue another one.', OverDraftAuth."No.");

                            end;


                            if ("Expiry Date" >= OverDraftAuth."Effective/Start Date") and ("Expiry Date" <= OverDraftAuth."Expiry Date") then begin
                                if AllowMultipleOD = true then begin
                                    if Confirm('There is an already approved Over Draft within the specified period. - %1. Do you wish to issue another one?' +
                                       '', false, OverDraftAuth."No.") = false then
                                        Error('Process Terminated.');
                                end else
                                    Error('There is an already approved Over Draft within the specified period. - %1. Cancel an existing one if you' +
                                           ' want to issue another one.', OverDraftAuth."No.");

                            end;

                        until OverDraftAuth.Next = 0;
                    end;
                end;
            end;
        }
        field(7; Duration; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                TestField("Effective/Start Date");
                TestField(Duration);

                if "Effective/Start Date" < Today then
                    Error('Effective date cannot be in the past.');

                "Expiry Date" := CalcDate(Duration, "Effective/Start Date");
                Validate("Expiry Date");
            end;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(9; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Approved Amount" > "Requested Amount" then
                    Error('Approved Amount cannot be greater than the requeested amount.');
            end;
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Transaction Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges".Code where(Type = const(Overdraft));
        }
        field(15; Liquidated; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Date Liquidated"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Liquidated By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(21; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Canceled By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Overdraft Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(25; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Issue to"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Account,Cashier';
            OptionMembers = Account,Cashier;
        }
        field(28; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "Approved Amount" := "Requested Amount";
                Validate("Approved Amount");
            end;
        }
        field(29; Expired; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Available Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Recommended By"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
        }
        field(51200; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = true;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            var
                OldDimSetID: Integer;
                IsHandled: Boolean;
                DimMgt: Codeunit DimensionManagement;
            begin

                OldDimSetID := "Dimension Set ID";
                "Dimension Set ID" :=
                  DimMgt.EditDimensionSet(
                    Rec, "Dimension Set ID", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");

                //IsChanged := OldDimSetID <> "Dimension Set ID";
            end;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
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
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Overdraft Nos");
            NoSeries.GetNextNo(NoSetup."Overdraft Nos", WorkDate(), true);
        end;


        "Created By" := UpperCase(UserId);



        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            //UserSetup.TESTFIELD(UserSetup."Responsibility Center");
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            //"Responsibility Center":=UserSetup."Responsibility Center";
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        end;

        if not UserSetup."Overdraft Management" then
            Error('You do not have any permissions for Overdraft Processing. Contact the administrator!');
    end;

    var
        NoSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
        Account: Record "Savings Accounts";
        UsersID: Record User;
        "Bank Name": Text[30];
        ChequeNo: Code[20];
        i: Integer;
        Bank: Record "Bank Account";
        ProductTypes: Record "Product Setup";
        OverDraftAuth: Record "Overdraft Header";
        AllowMultipleOD: Boolean;
        UserSetup: Record "User Setup";
        Amnt: Decimal;
        MinAccBal: Decimal;
        MemberActivities: Codeunit "Member Activities";
}


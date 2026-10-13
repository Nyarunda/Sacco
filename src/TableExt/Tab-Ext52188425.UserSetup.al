tableextension 50017 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50050; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50051; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }


        field(50052; "CashRec Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(50053; "CashRec Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("CashRec Journal Template"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("CashRec Journal Template", "CashRec Journal Template");
                UserTemp.SetRange("CashRec Journal Batch", "CashRec Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") and ("CashRec Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50054; "Payment Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(50055; "Payment Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("Payment Journal Template", "Payment Journal Template");
                UserTemp.SetRange("Payment Journal Batch", "Payment Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") and ("Payment Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50056; "General Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(50057; "General Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("General Journal Template"));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("General Journal Template", "General Journal Template");
                UserTemp.SetRange("General Journal Batch", "General Journal Batch");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") and ("General Journal Batch" <> '') then begin
                            Error('Please note that another user has been assigned the same batch.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50058; "Max. Open Documents"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Default Payment Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Bank Account"."No." where ("Bank Type"=filter(Normal));
        }
        field(50060; "Default Petty Cash Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Bank Account"."No." where ("Bank Type"=filter("Petty Cash"|Cashier|Cash));
        }
        field(50061; Payroll; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Default Receipt Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(50063; "Use POS Printer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members where("Type" = const(Member));
        }
        field(50065; "Imprest Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where("Account Type" = const(Imprest));

            trigger OnValidate()
            begin
                UserTemp.Reset;
                UserTemp.SetRange("Imprest Account", "Imprest Account");
                if UserTemp.FindFirst then begin
                    repeat
                        if (UserTemp."User ID" <> Rec."User ID") then begin
                            Error('Please note that another user has been assigned this imprest account.');
                        end;
                    until UserTemp.Next = 0;
                end;
            end;
        }
        field(50066; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

        }
        field(50067; "Branch Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Board Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50069; "Staff Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50070; MBanking; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "View Staff Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Allow Bank to Bank Trans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Disable SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "View Board Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Credit Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Savings Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "General Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Administration Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Finance Setups"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "De-Link ATM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Update Debt Collector"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Overpay Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(50085; "Is HR"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Is Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "File Movement Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "File Movement Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Custom User Group";//where(Type = const("File Movement"));
        }
        field(50088; "Reset File Movement"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(50089; "Reverse Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Post Mid-Month Salary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Edit Chart of Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50092; "Edit Bank Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "Is Credit Department"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Config. Packages"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50633; "HOD CSD"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50634; "HOD Credit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";


            trigger OnLookup()
            var
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;
        }
        field(50096; "Create Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "View Special Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50098; Reports; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50099; "Member Exit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "BBF Claim"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Create Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Appraise Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Loan Changes"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Security Subtitution"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Collateral Reg"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; Checkoff; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; Advice; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "SASRA Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Loan Recovery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; CRB; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; Teller; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; Treasury; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Account Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Salary processing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "STO processing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "Fixed Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "FOSA Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50118; "Overdraft Management"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Cheque mangemennt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50120; "Bill Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50121; Customer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50122; Vendor; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50123; "View Banks"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50124; Reconciliation; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "View Payment Journal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50126; "View Chart of Acount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50127; "Fixed Asset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50128; "View Purchase Requsition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "View RFQ"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90000; "Create Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50131; "Create Normal PV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50133; "Create Staff PV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50135; "Create Board PV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50136; "Create Petty Cash"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50137; "Create Bank Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50138; "Create Imprest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50139; "View HR"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "User Settings"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "View Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "View Employee "; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50141; "System Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50142; "Dividend Processing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50143; "Account Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50144; "View Board P9"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "Member Changes"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Create Customer Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50599; "Change Allow Posting From"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50600; "Approval Reset Time"; time)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Usersetup: Record "User Setup";
            begin
                Usersetup.Get(UserId);
                if not Usersetup."Change Allow Posting From" then
                    Error('You do not have permission "Change Allow Posting From"');
            end;
        }
        field(50601; "Member Statement"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50602; "G/L Direct Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50604; "By Pass Direct Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50605; "Delete Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50606; "Delete Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50607; "Delete Chart of Accounts"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50608; Backdate; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50609; "Update Transaction Charges"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50610; "Generate Penalty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50611; "Allow overdrawal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50612; "Re-Open Collateral"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50613; "Capture AGM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50614; "Sacco Categorization"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50615; "Edit Ledger Entries"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50616; "Edit GL Entries"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50617; "Upload File"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50618; "Overwrite Upload File"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50619; "Reverse Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50620; "Reverse Report Right"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50621; "Skip Overdrawal Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50622; "Finance Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50626; "Disbursement Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50623; "Post Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50624; store; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50625; "FOSA Interest Endyear"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50627; "Is CEO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50628; "Can Close Cases"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50629; "Post Writeoff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50630; "Collateral Exempt Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50631; "Receive Notifications"; boolean)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether this user should receive process notifications for their responsibility center.';
        }
        field(50632; "View Next of Kin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50636; "Forfeit Exit Approver"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(50635; "View Find Entries"; Boolean)
        {
            Caption = 'View Find Entries';
            DataClassification = ToBeClassified;
        }
        field(50637; "Default Journal Nos. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                if not UserSetup."Is Admin" then
                    Error('You do not have permission to change the default journal number series.');

                UserSetup.Reset();
                UserSetup.SetRange("Default Journal Nos. Series", "Default Journal Nos. Series");
                if UserSetup.FindFirst then
                    Error('Please note that another user has been assigned the same default journal number series.');

            end;
        }

    }
    var
        UserTemp: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin

        OldDimSetID := "Dimension Set ID";
        if "Dimension Set ID" = 0 then
            "Dimension Set ID" :=
              InitDimensionSet(
                Rec, "Dimension Set ID", "User ID", "Global Dimension 1 Code", "Global Dimension 2 Code")
        else
            "Dimension Set ID" :=
         DimMgt.EditDimensionSet(
           Rec, "Dimension Set ID", "User ID", "Global Dimension 1 Code", "Global Dimension 2 Code");

        IsChanged := OldDimSetID <> "Dimension Set ID";

    end;

    procedure InitDimensionSet(RecVariant: Variant; DimSetID: Integer; NewCaption: Text[250]; var GlobalDimVal1: Code[20]; var GlobalDimVal2: Code[20]): Integer
    var
        DimSetEntry: Record "Dimension Set Entry" temporary;
        EditDimSetEntries: Page "Edit Dimension Set Entries";
        Dim: Record Dimension;
        NewDimSetID: Integer;
    begin
        Dim.Reset();
        if Dim.Find('-') then
            repeat
                DimSetEntry.Init();
                DimSetEntry.Validate("Dimension Code", Dim.Code);
                if DimSetEntry.Insert(true) then;
            until Dim.Next() = 0;

        NewDimSetID := DimSetID;
        DimSetEntry.FilterGroup(2);
        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        DimSetEntry.FilterGroup(0);
        EditDimSetEntries.SetTableView(DimSetEntry);
        EditDimSetEntries.SetFormCaption(NewCaption);
        EditDimSetEntries.RunModal();
        NewDimSetID := EditDimSetEntries.GetDimensionID();
        DimMgt.UpdateGlobalDimFromDimSetID(NewDimSetID, GlobalDimVal1, GlobalDimVal2);
        exit(NewDimSetID);
    end;

    procedure LoadDimensions()
    var

        Dim: Record Dimension;
    begin

        Dim.Reset();
        if Dim.FindSet() then begin
            /* DimEntries.Reset();
             if DimEntries.Find('-') then DimEntries.Delete();
             repeat
                 DimEntries.Init();
                 DimEntries."Dimension Code" := Dim.Code;
                 DimEntries.Insert();
             until Dim.Next() = 0; */
        end;


    end;

}

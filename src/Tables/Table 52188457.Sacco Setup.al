
Table 50120 "Sacco Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Penalty Grace Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Loan Insurance Date"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Loan Anniversary","End of Month","Begining of Month","Mid Month","Specific Date","User Defined At Run Time";
        }
        field(12; "Specific Loan Insurance Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Min Topup Months"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Self Guarantee Multiplier %"; Decimal)
        {
            Caption = 'Self Guarantee Multiplier %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
            InitValue = 95;

            trigger OnValidate()
            begin
                if "Self Guarantee Multiplier %" > 100 then
                    Error('Self Guarantee Multiplier cannot exceed 100%');
            end;
        }

        field(50041; "Non-Self Multiplier %"; Decimal)
        {
            Caption = 'Non-Self Guarantee Multiplier % (Own Savings)';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 200;
            InitValue = 100;
        }

        field(50042; "Third Party Multiplier %"; Decimal)
        {
            Caption = 'Third Party Guarantee Multiplier %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 200;
            InitValue = 150;
        }

        field(50043; "Max Total Exposure %"; Decimal)
        {
            Caption = 'Maximum Total Exposure %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 300;
            InitValue = 150;

            trigger OnValidate()
            begin
                if "Max Total Exposure %" < "Self Guarantee Multiplier %" then
                    Error('Maximum Total Exposure % must be at least %1%', "Self Guarantee Multiplier %");
            end;
        }

        field(50044; "Third Party with Self Loan %"; Decimal)
        {
            Caption = 'Third Party Guarantee % (When Has Self Loan)';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
            InitValue = 50;
        }

        field(50050; "Membership Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Member Picture Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Picture,Signature,"Picture & Signature";
        }
        field(50052; "Guarantors Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Staff Can Guarantee Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Self Guarantee %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Excise Duty (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Excise Duty GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50057; "Loan Interest Automation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes;
        }
        field(50058; "Loan Interest Date"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Loan Anniversary","End of Month","Begining of Month","Mid Month","Specific Date","User Defined At Run Time";
        }
        field(50059; "Specific Loan Interest Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Calc. Loan Interest On"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Principal Only","Principal plus Outstanding Interest","User Defined Interest Amount";
        }
        field(50061; "Dividend Year Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Dividend Processing Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(50063; "Dividend Charge"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Use General Charge","Use Product Based Charge";
        }
        field(50064; "Dividend Processing Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Dividend Processing"));
        }
        field(50065; "Dividend Activity Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50066; "Member Exit Notice Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Member Exit Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Member Withdrawal"));
        }

        field(50068; "Member Exit Transfer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(50069; "Next of Kin Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(50070; "Group Picture Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Picture,Signature,"Picture & Signature";
        }
        field(50071; "Signatory Picture Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Picture,Signature,"Picture & Signature";
        }
        field(50072; "Cheque Reject Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "External STO Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50074; "Income Control Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50075; "Send Receipt Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Send Receipt SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Maximum Valuation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Kin % Allocation Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(50079; "Penalty Days From Exp. Pay Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Minimum Amt to Penalize"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Collateral % of Limit To Use"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Posting Date Limit"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Teller Can Self-Transact"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "MBanking Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "By Pass Cheque Clearing Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "FD Interest Accrual"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Calculate and Post On Maturity","Calculate Every End Month and Post on Maturity","Calculate & Post Every End Month","Calculate On Anniversary and Post on Maturity","Calculate and Post On Anniversary";
        }
        field(50087; "Loan Rescheduling Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Loan Changes"));
        }
        field(50088; "Loan Restructure Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Loan Changes"));
        }
        field(50089; "Test Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Dormancy Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Chq Book Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50092; "Early Member Exit Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Member Withdrawal"));
        }
        field(50093; "Activate Early Exit Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "Sacco Contacts"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Bank Account No,"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Email File Path"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50099; "Allow Loan-Specific Charges"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(50100; "Nominee Mandatory"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(50101; "Checkoff Control"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "g/l account";
        }
        field(50102; "Teller Shortage Email"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50103; "Registration Comm. Expense"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "g/l account";
        }

        field(50104; "Statement Path B64"; Text[2000])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

        field(50105; "SMS Time"; Time)
        {
            DataClassification = ToBeClassified;
            //TableRelation = "G/L Account";
        }
        field(50106; "Withdrawal Fee"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Withdrawal Fee(Quick)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Duplum Interest Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Maximum ATM Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50110; "ATM Card No Characters"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "File Keeping Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Exit Min. Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50113; "External STO Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Standing Order"));
        }
        field(50114; "Internal STO Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Standing Order"));
        }
        field(50115; "Allow Self Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "Reminder SMs Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50117; "Pause Defaulter Offset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50118; "Charge Activation Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50119; "Activation Fee Charge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Account Activation"));
        }
        field(50120; "BBF Expense Account"; code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50123; "Loan Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "Days for Checkoff"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50126; "Min. Contribution [Deposits]"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "Min. Contribution [Shares]"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50128; "Max. Petty Cash Amount"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "Min. Contrib. Amount"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50130; "Share Capital Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Share Exit"));
        }
        field(50131; "Board"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50134; "Board Control Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Can Pay Board" = const(true));
        }
        field(50135; "Board Expense Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Can Pay Board" = const(true));
        }
        field(50136; "Minimum Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50137; "Minimum Deposit Qualification"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "Early Exit Notice Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50141; "Go Live Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50142; "GFE Income Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50143; "Sacco Paybill Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }

        field(50144; "Spot SMS PassKey"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50145; "Spot SMS Sender"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Spot SMS ServiceID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50147; "Spot SMS ClientID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "Min. Benevolent Contrib"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Credit Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "Finance Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; "FOSA Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50153; "Mobile Loan Deposits Limit %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50154; "New Member Share Cap"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50155; "Depreciation No. Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50157; "AGM Msg"; Text[1020])
        {
            DataClassification = ToBeClassified;
        }
        field(50158; "Credit 1 Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50159; "Is Defaulter Tetsing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50160; "Credit 2 Email"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50161; "Testing Defaulter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50162; "Rollover Allowance Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50163; "Chamaa Exit Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Member Withdrawal"));
        }
        field(50164; "Chamaa Early Exit Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("Member Withdrawal"));
        }
        field(50165; "Chamaa Exit Transfer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(50166; "Chamaa Consolidation Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup" where("Product Class" = const(Savings));
        }
        field(50167; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50168; "End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50169; "Mobile Loan Next RunDate"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50170; "No of Days in Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50171; "Azure Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50172; "Azure Storage Path"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50174; "Azure Storage SASToken"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50173; "Arrears Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50175; "Mobile Loans Grace Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50176; "Stop Loan Interest After"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50177; "Interest Day"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50178; "Dividend Reverse Document"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50179; "Dividend Reverse Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50180; "Maximum Share Capital Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50181; "Loan Penalty Next RunDate"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50183; "Minimum No. Board Approvals"; Integer)
        {
            Caption = 'Minimum No. Board Approvals Committee';
            DataClassification = ToBeClassified;
        }
        field(50184; "Statements E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50185; "Interest Billing Grace Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50186; "Minimum Principal Billing"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50187; "Lease Increment %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50188; "UFAA GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(blocked = const(false));
        }
        field(50189; "Opening Balances GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(blocked = const(false));
        }
        field(50190; "VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50191; "Rounding Precision"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50192; "Coop Excise Duty (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50193; "Exempt Loan Principal Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50194; "MBanking Application Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Charges" where(Type = const("MBanking Application"));
        }
        field(50195; "Staff/Board Can Self Gua. Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50196; "Charge Deceased Withdrawal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50197; "Coop B2B Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50198; "Coop P2F Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50199; "Writeoff Provision GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(blocked = const(false));
        }
        field(50200; "Writeoff GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(blocked = const(false));
        }
        field(50201; "PDF Encrypt Function URL"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50205; "WthTax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50206; "Minimum Board Loan Comment Amt"; Decimal)
        {
            Caption = 'Minimum Board Loan Comment Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;
            InitValue = 20000000;
        }
        field(50210; "Coseke EDMS Base URL"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50211; "Coseke EDMS API Key"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50212; "Suspense GL Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50214; "Metropol Base URL"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50215; "Metropol API Key"; Text[200])
        {
            DataClassification = ToBeClassified;
        }



        field(50216; "Coseke Finance Folder Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50217; "Send Email via Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50218; "Prorate 1st Month Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: label '%1 %2 %3 have %4 to %5.';
        Text001: label '%1 %2 have %3 to %4.';
        Text002: label '%1 %2 %3 use %4.';
        Text003: label '%1 %2 use %3.';
        Text004: label '%1 must be rounded to the nearest %2.';
        Text016: label 'Enter one number or two numbers separated by a colon. ';
        Text017: label 'The online Help for this field describes how you can fill in the field.';
        Text018: label 'You cannot change the contents of the %1 field because there are posted ledger entries.';
        Text021: label 'You must close the program and start again in order to activate the amount-rounding feature.';
        Text022: label 'You must close the program and start again in order to activate the unit-amount rounding feature.';
        Text023: label '%1\You cannot use the same dimension twice in the same setup.';
        Dim: Record Dimension;
        GLEntry: Record "G/L Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        FALedgerEntry: Record "FA Ledger Entry";
        MaintenanceLedgerEntry: Record "Maintenance Ledger Entry";
        InsCoverageLedgerEntry: Record "Ins. Coverage Ledger Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        TaxJurisdiction: Record "Tax Jurisdiction";
        AnalysisView: Record "Analysis View";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
        AdjAddReportingCurr: Report "Adjust Add. Reporting Currency";
        ErrorMessage: Boolean;
        DependentFieldActivatedErr: label 'You cannot change %1 because %2 is selected.';
        Text025: label 'The field %1 should not be set to %2 if field %3 in %4 table is set to %5 because deadlocks can occur.';
        ObsoleteErr: label 'This field is obsolete, it has been replaced by Table 248 VAT Reg. No. Srv Config.';
}


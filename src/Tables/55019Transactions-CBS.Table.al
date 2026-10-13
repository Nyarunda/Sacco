Table 55019 "Transactions- CBS"
{

    fields
    {
        field(1; No; Code[20])
        {

        }
        field(2; "Account No"; Code[20])
        {

        }
        field(3; "Account Name"; Text[200])
        {
        }
        field(4; "Transaction Type"; Code[20])
        {
            NotBlank = true;

        }
        field(5; Amount; Decimal)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Transaction Category" = 'BANKERS CHEQUE' then begin
                    if "Bankers Cheque Type" = "bankers cheque type"::Company then begin

                    end;
                end;
                if Amount < 0 then
                    Error('Amount cannot be less than zero');
                //CalcAvailableBal;
            end;
        }
        field(6; Cashier; Code[30])
        {
            Editable = false;
            //TableRelation = User."User Name";
        }
        field(7; "Transaction Date"; Date)
        {
            Editable = true;


        }
        field(8; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
            Editable = true;
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            //TableRelation = "No. Series";
        }
        field(11; "Account Type Code"; Code[20])
        {
            ////TableRelation = "Account Types".Code;
        }
        field(12; "Account Description"; Text[50])
        {
        }
        field(13; "Denomination Total"; Decimal)
        {
        }
        field(14; "Cheque Type"; Code[20])
        {
            //TableRelation = "Cheque Types";

        }
        field(15; "Cheque No"; Code[20])
        {

        }
        field(16; "Cheque Date"; Date)
        {

        }
        field(17; Payee; Text[100])
        {
        }
        field(19; "Bank No"; Code[20])
        {
            //TableRelation = "Bank Account"."No.";
        }
        field(20; "Branch No"; Code[20])
        {

        }
        field(21; "Clearing Charges"; Decimal)
        {
        }
        field(22; "Clearing Days"; DateFormula)
        {
        }
        field(23; Description; Text[150])
        {
        }
        field(24; "Bank Name"; Text[150])
        {
        }
        field(25; "Branch Name"; Text[150])
        {
        }
        field(26; "Transaction Mode"; Option)
        {
            Caption = 'Payment Mode';
            OptionCaption = 'Cash,Cheque';
            OptionMembers = Cash,Cheque;
            ////TableRelation = Table53024;
        }
        field(27; Type; Text[50])
        {
        }
        field(31; "Transaction Description"; Text[100])
        {
        }
        field(32; "Minimum Account Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(33; "Fee Below Minimum Balance"; Decimal)
        {
        }
        field(34; "Normal Withdrawal Charge"; Decimal)
        {
        }
        field(36; Authorised; Option)
        {
            Editable = true;
            OptionMembers = No,Yes,Rejected,"No Charges";

            trigger OnValidate()
            begin
                "Withdrawal FrequencyAuthorised" := Authorised;
            end;
        }
        field(39; "Checked By"; Text[50])
        {
        }
        field(40; "Fee on Withdrawal Interval"; Decimal)
        {
        }
        field(41; Remarks; Text[250])
        {
        }
        field(42; Status; Option)
        {
            OptionMembers = Pending,Honoured,Stopped,Bounced;
        }
        field(43; "Date Posted"; Date)
        {
        }
        field(44; "Time Posted"; Time)
        {
        }
        field(45; "Posted By"; Text[50])
        {
        }
        field(46; "Expected Maturity Date"; Date)
        {
        }
        field(47; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(48; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            //TableRelation = Currency;
        }
        field(49; "Transaction Category"; Code[20])
        {
        }
        field(50; Deposited; Boolean)
        {
        }
        field(51; "Date Deposited"; Date)
        {
        }
        field(52; "Time Deposited"; Time)
        {
        }
        field(53; "Deposited By"; Text[20])
        {
        }
        field(54; "Post Dated"; Boolean)
        {
        }
        field(55; Select; Boolean)
        {
        }
        field(56; "Status Date"; Date)
        {
        }
        field(57; "Status Time"; Time)
        {
        }
        field(58; "Supervisor Checked"; Boolean)
        {
        }
        field(59; "Book Balance"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(60; "Notice No"; Code[20])
        {
        }
        field(61; "Notice Cleared"; Option)
        {
            OptionMembers = Pending,No,Yes,"No Charges";
        }
        field(63; "Has Schedule"; Boolean)
        {
        }
        field(64; Requested; Boolean)
        {
        }
        field(65; "Date Requested"; Date)
        {
        }
        field(66; "Time Requested"; Time)
        {
        }
        field(67; "Requested By"; Text[20])
        {
        }
        field(68; Overdraft; Boolean)
        {
        }
        field(69; "Cheque Processed"; Boolean)
        {
        }
        field(70; "Staff/Payroll No"; Text[20])
        {

            trigger OnValidate()
            begin
                /*Account.RESET;
                Account.SETRANGE(Account."Staff/Payroll No","Staff/Payroll No");
                
                IF Account.FIND('-')THEN BEGIN
                MESSAGE('its there');
                IF Account.Status=Account.Status::Dormant THEN BEGIN
                Account.Status:=Account.Status::Active;
                Account.MODIFY;
                END;
                IF Account.Status=Account.Status::New THEN BEGIN
                END
                ELSE BEGIN
                IF Account.Status<>Account.Status::Active THEN
                ERROR('The account is not active and therefore cannot be transacted upon.');
                END;
                END;
                
                
                IF Account.GET("Staff/Payroll No") THEN BEGIN
                "Account No":=Account."No.";
                "Account Name":=Account.Name;
                "Account Type":=Account."Account Type";
                "Currency Code":=Account."Currency Code";
                
                END;
                
                IF AccountTypes.GET("Account Type") THEN BEGIN
                "Account Description":=AccountTypes.Description;
                "Minimum Account Balance":=AccountTypes."Minimum Balance";
                "Fee Below Minimum Balance":=AccountTypes."Fee Below Minimum Balance";
                //"Normal Withdrawal Charge":=AccountTypes."Withdrawal Charge";
                "Fee on Withdrawal > Interval":=AccountTypes."Withdrawal Penalty";
                END;
                
                 */

            end;
        }
        field(71; "Cheque Transferred"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(72; "Expected Amount"; Decimal)
        {
        }
        field(73; "Line Totals"; Decimal)
        {
        }
        field(74; "Transfer Date"; Date)
        {
        }
        field(75; "BIH No"; Code[20])
        {
        }
        field(76; "Transfer No"; Code[20])
        {
        }
        field(77; Attached; Boolean)
        {
        }
        field(78; "BOSA Account No"; Code[20])
        {
            //            //TableRelation = "SACCO Account"."No." where(Status = const(New));
            // Validate//TableRelation = false;

        }
        field(79; "Salary Processing"; Option)
        {
            OptionMembers = " ",No,Yes;
        }
        field(80; "Expense Account"; Code[30])
        {
            //TableRelation = Table53163.Field1;
        }
        field(81; "Expense Description"; Text[150])
        {
        }
        field(82; "Company Code"; Code[30])
        {
            //TableRelation = Employer.Code;
        }
        field(83; "Schedule Type"; Option)
        {
            OptionMembers = ,"Salary Processing",Contributions,"ATM EFT Transactions","Savings Loan Recoveries";
        }
        field(84; "Banked By"; Code[20])
        {
        }
        field(85; "Date Banked"; Date)
        {
        }
        field(86; "Time Banked"; Time)
        {
        }
        field(87; "Banking Posted"; Boolean)
        {
        }
        field(88; "Cleared By"; Code[20])
        {
        }
        field(89; "Date Cleared"; Date)
        {
        }
        field(90; "Time Cleared"; Time)
        {
        }
        field(91; "Clearing Posted"; Boolean)
        {
        }
        field(92; "Needs Approval"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(93; "ID Type"; Code[20])
        {
        }
        field(94; "ID No"; Code[50])
        {

        }
        field(95; "Reference No"; Code[20])
        {
        }
        field(96; "Refund Cheque"; Boolean)
        {
        }
        field(97; Imported; Boolean)
        {
        }
        field(98; "External Account No"; Code[30])
        {
        }
        field(99; "BOSA Transactions"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(100; "Bank Account"; Code[20])
        {
            //TableRelation = "Bank Account"."No.";


        }
        field(101; "Savers Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(102; "Mustaafu Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(103; "Junior Star Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(104; Printed; Boolean)
        {
        }
        field(105; "Account Type."; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(106; "Account No2"; Code[20])
        {
            Caption = 'Account No.';

        }
        field(107; "Withdrawal FrequencyAuthorised"; Option)
        {
            OptionMembers = No,Yes,Rejected;
        }
        field(108; "Frequency Needs Approval"; Option)
        {
            OptionMembers = " ",No,Yes;
        }
        field(109; "Special Advance No"; Code[20])
        {
        }
        field(110; "Bankers Cheque Type"; Option)
        {
            OptionMembers = Normal,Company;

            trigger OnValidate()
            begin
                if "Bankers Cheque Type" = "bankers cheque type"::Company then begin
                    GenLedgerSetup.Get;
                    // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Company Bankers Cheque Account");
                    "Account Type." := "account type."::"G/L Account";
                    //"Account No.":=GenLedgerSetup."Company Bankers Cheque Account";

                end else begin
                    "Account No2" := '';
                end;
            end;
        }
        field(111; "Suspended Amount"; Decimal)
        {
        }
        field(112; "Transferred By EFT"; Boolean)
        {
        }
        field(113; "Banking User"; Code[20])
        {
        }
        field(114; "Company Text Name"; Code[20])
        {
        }
        field(115; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(116; "Total Salaries"; Integer)
        {
            FieldClass = Normal;
        }
        field(117; "EFT Transferred"; Boolean)
        {
        }
        field(118; "ATM Transactions Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(119; "Bank Code"; Code[20])
        {

        }
        field(120; "External Account Name"; Text[50])
        {
        }
        field(121; "Overdraft Limit"; Decimal)
        {
        }
        field(122; "Overdraft Allowed"; Boolean)
        {
        }
        field(123; "Available Balance"; Decimal)
        {
        }
        field(124; "Authorisation Requirement"; Text[50])
        {
        }
        field(125; "Bankers Cheque No"; Code[20])
        {
        }
        field(126; "Transaction Span"; Option)
        {
            OptionCaption = 'FOSA,BOSA';
            OptionMembers = FOSA,BOSA;
        }
        field(127; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum("Transactions- CBS".Amount where("Account No" = field("Account No"),
                                                                Posted = const(true),
                                                                "Cheque Processed" = const(false),
                                                                Type = const('Cheque Deposit')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(128; "Transaction Available Balance"; Decimal)
        {
        }
        field(129; "Branch Account"; Code[20])
        {

        }
        field(130; "Branch Transaction"; Boolean)
        {
        }
        field(131; "FOSA Branch Name"; Text[30])
        {
        }
        field(133; "Branch Refference"; Text[30])
        {
        }
        field(134; "Branch Account No"; Code[20])
        {
            //TableRelation = "prBank Structure"."Bank Code";


        }
        field(135; "Branch Transaction Date"; Date)
        {
        }
        field(136; "Post Attempted"; Boolean)
        {
        }
        field(137; "Transacting Branch"; Code[20])
        {
            //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(138; Signature; Blob)
        {
        }

        field(140; "Amount Discounted"; Decimal)
        {
        }
        field(141; "Dont Clear"; Boolean)
        {
        }
        field(142; "Other Bankers No."; Code[100])
        {
        }
        field(62000; "N.A.H Balance"; Decimal)
        {
        }
        field(62001; "Cheque Deposit Remarks"; Text[50])
        {
        }
        field(62002; Payout; Boolean)
        {
        }
        field(62003; "Atm Number"; Code[70])
        {
        }
        field(62004; "Attempted Self Transaction"; Boolean)
        {
        }
        field(62005; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field(No)));
            FieldClass = FlowField;
        }
        field(62006; check; Boolean)
        {

            trigger OnValidate()
            begin
                "Checked By" := UserId;
                Time_checked := CurrentDatetime;
            end;
        }
        field(62008; Time_checked; DateTime)
        {
        }
        field(62009; "Product Type"; Code[50])
        {
        }
        field(62010; "Cheque Status"; Option)
        {
            OptionCaption = 'Pending,Honoured,Stopped,Bounced';
            OptionMembers = Pending,Honoured,Stopped,Bounced;
        }
        field(62011; Process; Boolean)
        {
        }
        field(62012; "Signing Instructions"; Option)
        {
            OptionCaption = 'Single,All must Sign,Either Must Sign';
            OptionMembers = Single,"All must Sign","Either Must Sign";
        }
        field(62013; "Cheque Bank"; Code[10])
        {
            //TableRelation = Banks."Bank Code";
        }
        field(62014; "Cheque Bank Name"; Text[100])
        {
        }
        field(62015; Drawer; Text[50])
        {
        }
        field(62016; "Approval By"; Text[50])
        {
        }
        field(62017; "Cheque Bank Branch"; Code[20])
        {
            //TableRelation = Banks."Branch Code" where("Bank Code" = field("Cheque Bank"));


        }
        field(62018; "Blocked Amount No."; Code[10])
        {
            FieldClass = Normal;
        }
        field(62019; "Member No"; Code[20])
        {
        }
        field(62020; "Protected Account"; Boolean)
        {
        }
        field(62021; "Cheque Cleared By"; Code[30])
        {
        }
        field(62022; "Supervisor Approval Status"; Option)
        {
            OptionCaption = 'No,Yes,Rejected,No Charges';
            OptionMembers = No,Yes,Rejected,"No Charges";
        }
        field(62023; "Signing Instruction Narrative"; Text[100])
        {
        }

        field(62025; "Frequency Withdrawal Charged"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; "Transfer No")
        {
            SumIndexFields = Amount;
        }
        key(Key3; Type, "Transaction Date", Posted, "Transaction Category")
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Account No", "Cheque Processed", Deposited, "Transaction Category")
        {
            SumIndexFields = Amount;
        }
        key(Key5; Deposited, Posted, "Transaction Category", "Transaction Date", "Has Schedule")
        {
            SumIndexFields = Amount;
        }
        key(Key6; Requested, "Transaction Category", "Transaction Date")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Account No", "Cheque Processed", Posted, Type)
        {
            SumIndexFields = Amount;
        }
        key(Key8; "Cheque No")
        {
        }
        key(Key9; "Transaction Type", "Transaction Date", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key10; "Bankers Cheque No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Posted = TRUE THEN
        ERROR('The transaction has been posted and therefore cannot be deleted.');
         */

    end;

    trigger OnInsert()
    begin
        Transaction.Reset;
        Transaction.SetRange(Transaction.Cashier, UserId);
        Transaction.SetRange(Transaction.Posted, false);
        if Transaction.Find('-') then begin
            Error('Cannot create a new transaction while transaction No.%1 is not posted', Transaction.No);
        end;



        Cashier := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        Status := Status::Pending;
        "Needs Approval" := "needs approval"::Yes;
        "Frequency Needs Approval" := "frequency needs approval"::Yes;

        //IF UsersID.GET(USERID) THEN
        //"Transacting Branch":=UsersID.Branch;
    end;

    trigger OnModify()
    begin
        /*GLEntry.RESET;
        GLEntry.SETRANGE(GLEntry."Document No.",No);
        IF GLEntry.FIND('-') THEN BEGIN
        Posted:=TRUE;
        "Supervisor Checked":=TRUE;
        "Date Posted":=WORKDATE;
        "Time Posted":=TIME;
        "Posted By":=USERID;
        MODIFY;
        EXIT;
        END;
        
        //FRANCIS
        IF ("Cheque Processed"<>xRec."Cheque Processed") OR ("Checked By"<>xRec."Cleared By")
        OR ("Date Cleared"<>xRec."Date Cleared")
        OR ("Cheque Cleared By"<>xRec."Cheque Cleared By")
        OR (checked_by<>xRec.checked_by)
        OR (Process<>xRec.Process)
        OR (Select<>xRec.Select)
        OR (Authorised<>xRec.Authorised)
        OR (xRec.Time_checked<>Time_checked)
        OR (xRec."Supervisor Approval Status"<>"Supervisor Approval Status")
        THEN BEGIN
        
        MODIFY;
        END ELSE BEGIN
        
        //Cyrus
        IF Cashier <> UPPERCASE(USERID) THEN
        ERROR('Cannot modify a Transaction being processed by %1',Cashier);
        
        
        IF Posted = TRUE  THEN
        ERROR('The transaction has been posted and therefore cannot be modified.');
        END;
         */

    end;

    trigger OnRename()
    begin
        if Type <> 'Cheque Deposit' then begin
            if Posted then begin
                Error('The transaction has been posted and therefore cannot be modified.');
            end;
        end;

        if Deposited then begin
            Error('The cheque has already been deposited and therefore cannot be modified.');
        end;

        //Cyrus
        if Cashier <> UpperCase(UserId) then
            Error('Cannot rename a Transaction being processed by %1', Cashier);
    end;

    var
        PaymentMethod: Record "Payment Method";
        PublicHoliday: Integer;
        weekday: Integer;
        CDays: Integer;
        GLAcc: Record "G/L Account";
        Vend: Record "Savings Accounts";
        BankAcc: Record "Bank Account";
        FA: Record "Fixed Asset";
        GenLedgerSetup: Record "General Ledger Setup";
        VarAmtHolder: Decimal;
        DimValue: Record "Dimension Value";
        EMaturity: Date;
        Acc: Record "Savings Accounts";
        UsersID: Record User;
        Transaction: Record "Transactions- CBS";
        GLEntry: Record "G/L Entry";

}


table 50535 "Sky M-Banking Transactions"
{
    DataClassification = AccountData;
    //LookupPageId = "Sky M-Banking Transactions";
    //DrillDownPageId = "Sky M-Banking Transactions";

    DataCaptionFields = "Originator ID", "Transaction Type";
    fields
    {
        field(1; "No."; BigInteger)
        {
            AutoIncrement = True;
            Editable = true;
        }

        field(2; "Originator ID"; Text[50])
        {
            Caption = 'Originator ID';
            Editable = true;
        }

        field(3; "PESA Type"; Text[100])
        {
            Caption = 'PESA Type';
            Editable = true;
        }

        field(4; "Action"; Text[100])
        {
            Caption = 'Action';
            Editable = true;
        }

        field(5; "Command"; Text[100])
        {
            Caption = 'Command';
            Editable = true;
        }

        field(6; "Sensitivity"; Text[100])
        {
            Caption = 'Sensitivity';
            Editable = true;
        }

        field(7; "Charge"; Decimal)
        {
            Caption = 'Charge';
            Editable = true;
        }
        field(8; "Identifier Type"; Text[100])
        {
            Caption = 'Identifier Type';
            Editable = true;
        }
        field(9; "Identifier"; Text[100])
        {
            Caption = 'Identifier';
            Editable = true;
        }
        field(10; "Initiator Identifier Type"; Text[100])
        {
            Caption = 'Transaction Initiator Identifier Type';
            Editable = true;
        }

        field(11; "Initiator Identifier"; Text[100])
        {
            Caption = 'Transaction Initiator Identifier';
            Editable = true;
        }
        field(12; "Initiator Account"; Text[100])
        {
            Caption = 'Transaction Initiator Account';
            Editable = true;
        }
        field(13; "Initiator Name"; Text[100])
        {
            Caption = 'Transaction Initiator Name';
            Editable = true;
        }
        field(14; "Initiator Reference"; Text[100])
        {
            Caption = 'Transaction Initiator Reference';
            Editable = true;
        }
        field(15; "Initiator Other Details"; Text[2000])
        {
            Caption = 'Transaction Initiator Other Details';
            Editable = true;
        }
        field(16; "Source Identifier Type"; Text[100])
        {
            Caption = 'Transaction Source Identifier Type';
            Editable = true;
        }

        field(17; "Source Identifier"; Text[100])
        {
            Caption = 'Transaction Source Identifier';
            Editable = true;
        }
        field(18; "Source Account"; Text[100])
        {
            Caption = 'Transaction Source Account';
            Editable = true;
        }
        field(19; "Source Name"; Text[100])
        {
            Caption = 'Transaction Source Name';
            Editable = true;
        }
        field(20; "Source Reference"; Text[100])
        {
            Caption = 'Transaction Source Reference';
            Editable = true;
        }
        field(21; "Source Other Details"; Text[2000])
        {
            Caption = 'Transaction Source Other Details';
            Editable = true;
        }
        field(22; "Sender Identifier Type"; Text[100])
        {
            Caption = 'Transaction Sender Identifier Type';
            Editable = true;
        }

        field(23; "Sender Identifier"; Text[100])
        {
            Caption = 'Transaction Sender Identifier';
            Editable = true;
        }
        field(24; "Sender Account"; Text[100])
        {
            Caption = 'Transaction Sender Account';
            Editable = true;
        }
        field(25; "Sender Name"; Text[100])
        {
            Caption = 'Transaction Sender Name';
            Editable = true;
        }
        field(26; "Sender Reference"; Text[100])
        {
            Caption = 'Transaction Sender Reference';
            Editable = true;
        }
        field(27; "Sender Other Details"; Text[2000])
        {
            Caption = 'Transaction Sender Other Details';
            Editable = true;
        }
        field(28; "Receiver Identifier Type"; Text[100])
        {
            Caption = 'Transaction Receiver Identifier Type';
            Editable = true;
        }

        field(29; "Receiver Identifier"; Text[100])
        {
            Caption = 'Transaction Receiver Identifier';
            Editable = true;
        }
        field(30; "Receiver Account"; Text[100])
        {
            Caption = 'Transaction Receiver Account';
            Editable = true;
        }
        field(31; "Receiver Name"; Text[100])
        {
            Caption = 'Transaction Receiver Name';
            Editable = true;
        }
        field(32; "Receiver Reference"; Text[100])
        {
            Caption = 'Transaction Receiver Reference';
            Editable = true;
        }
        field(33; "Receiver Other Details"; Text[2000])
        {
            Caption = 'Transaction Receiver Other Details';
            Editable = true;
        }
        field(34; "Beneficiary Identifier Type"; Text[100])
        {
            Caption = 'Transaction Beneficiary Identifier Type';
            Editable = true;
        }

        field(35; "Beneficiary Identifier"; Text[100])
        {
            Caption = 'Transaction Beneficiary Identifier';
            Editable = true;
        }
        field(36; "Beneficiary Account"; Text[100])
        {
            Caption = 'Transaction Beneficiary Account';
            Editable = true;
        }
        field(37; "Beneficiary Name"; Text[100])
        {
            Caption = 'Transaction Beneficiary Name';
            Editable = true;
        }
        field(38; "Beneficiary Reference"; Text[100])
        {
            Caption = 'Transaction Beneficiary Reference';
            Editable = true;
        }
        field(39; "Beneficiary Other Details"; Text[2000])
        {
            Caption = 'Transaction Beneficiary Other Details';
            Editable = true;
        }
        field(40; "Transaction Amount"; Decimal)
        {
            Caption = 'Transaction Amount';
            Editable = true;
        }
        field(41; "Transaction Description"; Text[2000])
        {
            Caption = 'Transaction Description';
            Editable = true;
        }
        field(42; "Transaction Category"; Text[100])
        {
            Caption = 'Transaction Category';
            Editable = true;
        }
        field(43; "Transaction Source Reference"; Text[100])
        {
            Caption = 'Transaction Source Reference';
            Editable = true;
        }
        field(44; "Request Application"; Text[100])
        {
            Caption = 'Request Application';
            Editable = true;
        }
        field(45; "Source Application"; Text[100])
        {
            Caption = 'Source Application';
            Editable = true;
        }
        field(46; "Transaction Date Time"; DateTime)
        {
            Caption = 'Transaction Date Time';
            Editable = true;
        }
        field(47; "API Request ID"; Text[100])
        {
            Caption = 'API Request ID';
            Editable = true;
        }

        //
        field(50; "Transaction ID"; Code[100])
        {
            Caption = 'Transaction ID';
            Editable = true;
        }
        // field(51; "Product ID"; Text[100])
        // {
        //     Caption = 'Product ID';
        // }

        field(51; "Session ID"; Code[20])
        {
        }

        field(52; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = true;
        }
        field(53; "Posted By"; code[50])
        {
            Caption = 'Posted by';
            Editable = true;
        }
        field(54; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = true;
        }
        field(55; "Posting Time"; Time)
        {
            Caption = 'Posting Time';
            Editable = true;
        }
        field(56; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Editable = true;
        }

        // field(56; Reversed; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = true;
        // }
        // field(57; "Reversed By"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = true;
        // }
        // field(58; "Reversed Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = true;
        // }
        // field(59; "Reversed Time"; Time)
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = true;
        // }

        field(65; "Transaction Type"; enum "Sky M-Banking Trans Types")
        {
            Caption = 'Transaction Type';
            Editable = true;
        }
        // field(66; "Failed Transaction"; Boolean)
        // {
        //     Caption = 'Failed Transaction';
        //     Description = 'Handles requests that were never successful';
        // }
        // field(67; "Failed Reason"; Text[250])
        // {
        //     Caption = 'Failed Reason';
        //     Description = 'Reason for the failure';
        // }
        field(68; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            Description = 'Date when the transaction was initiated';
            Editable = true;
        }
        field(60; "Transaction Time"; Time)
        {
            Caption = 'Transaction Time';
            Description = 'Time when the transaction was initiated';
            Editable = true;
        }
        field(61; "Needs Change"; Boolean)
        {
            Caption = 'Needs Change';
            Description = 'Needs to be checked for changes';
            // Editable = true;
        }
        field(62; "Needs Change Reason"; Text[250])
        {
            Caption = 'Change Reason';
            Description = 'Reason for the change';
            Editable = true;
        }
        field(63; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
            Description = 'Loan Number';
            TableRelation = Loans."Loan No.";

            trigger OnValidate()
            var
                Loan: Record Loans;
            begin
                if Loan.Get(Rec."Loan No.") then begin
                    "Loan Account" := Loan."Loan Account";

                    "Changed By" := UserId;
                    "Changed Date" := Today;
                    "Changed Time" := Time;
                    "Change Type" := "Change Type"::Post;
                end;
            end;
        }
        field(64; "Loan Account"; code[50])
        {
            Caption = 'Loan Account';
            Description = 'Loan Account';
            Editable = true;
        }
        field(69; "Savings Account"; code[100])
        {
            Caption = 'Savings Account';
            Description = 'Savings Account';
            //TableRelation = "Savings Accounts"."No.";

            trigger OnValidate()
            var
                theSavingsAccount: Record "Savings Accounts";
                theSavingsAccountProduct: Record "Product Setup";
            begin
                if theSavingsAccount.Get("Savings Account") then begin
                    if theSavingsAccountProduct.Get(theSavingsAccount."Product Type") then begin
                        if theSavingsAccountProduct."Product Category" = theSavingsAccountProduct."Product Category"::"Fixed Deposit" then begin
                            Error('Deposits to fixed deposit category accounts through mobile channel is NOT allowed!');
                        end;
                    end;
                end;

                "Changed By" := UserId;
                "Changed Date" := Today;
                "Changed Time" := Time;
                "Change Type" := "Change Type"::Post;
            end;
        }
        field(71; "Destination Account"; code[100])
        {
            Caption = 'Destination Account';
            Description = 'Destination Account';
            Editable = true;
            TableRelation = "Savings Accounts"."No.";
        }
        field(70; "Transaction Status"; Option)
        {
            Caption = 'Transaction Status';
            OptionMembers = " ","CONFIRMED","REVERSE_CONFIRMED";
            Editable = true;
        }
        field(72; "Changed By"; code[50])
        {
            Caption = 'Changed by';
            Editable = true;
        }

        field(73; "Changed Date"; Date)
        {
            Caption = 'Changed Date';
            Editable = true;
        }
        field(74; "Changed Time"; Time)
        {
            Caption = 'Changed Time';
            Editable = true;
        }
        field(75; "Signed Amount"; Decimal)
        {
            Caption = 'Signed Amount';
            Editable = true;
        }
        field(76; "Change Type"; Option)
        {
            Caption = 'Change Type';
            OptionMembers = "Post","Reverse";
            Editable = true;
        }
        field(77; "Statement Max Rows"; Integer)
        {
        }
        field(78; "Statement Start Date"; Date)
        {
        }
        field(79; "Statement End Date"; Date)
        {
        }
        field(80; "Account to Check"; Code[20])
        {
        }
        field(81; "Entry No."; Code[100])
        {
        }
        field(82; "UWS Posting Date"; Date)
        {
            Caption = 'UWS Posting Date';
            Editable = true;
        }
        field(83; "UWS Posting Time"; Time)
        {
            Caption = 'UWS Posting Time';
            Editable = true;
        }
        field(100; "Try Posting Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(101; "Total Charges"; Decimal)
        {
            Caption = 'Total Charges';
            Editable = true;
        }
        field(102; "Total Debit Amount"; Decimal)
        {
            Caption = 'Total Debit Amount';
            Editable = true;
        }

        field(105; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            Editable = true;
        }
        field(200; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = true;
            FieldClass = FlowField;
            CalcFormula = lookup("Savings Accounts".Name where("No." = field("Source Account")));
        }
        field(2001; "Manually Inserted"; Boolean)
        {

        }

        field(2002; "Paybill No."; Code[20])
        {

        }

        field(2003; "Paybill Balance"; Decimal)
        {

        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Unique1; "Originator ID")
        {
            Unique = true;
            Clustered = false;
        }
        key(Unique2; "Transaction ID")
        {
            Unique = true;
            Clustered = false;
        }
        key(Key1; "Transaction Date Time", "Transaction Date", "Transaction Time")
        {
            Clustered = false;
        }
        key(Key2; Posted, "Savings Account")
        {
            Clustered = false;
            SumIndexFields = "Signed Amount";
        }
        key(Key3; "Savings Account", "Transaction Date", "Transaction Type")
        {
            Clustered = false;
            SumIndexFields = "Signed Amount";
        }

        // Secondary keys for non-primary fields
        key(IdxPosted; "Posted")
        {
            Clustered = false;
        }

        key(IdxNeedsChange; "Needs Change")
        {
            Clustered = false;
        }

        key(IdxTransactionStatus; "Transaction Status")
        {
            Clustered = false;
        }

        key(IdxTransactionType; "Transaction Type")
        {
            Clustered = false;
        }

        key(IdxTryPostingCount; "Try Posting Count")
        {
            Clustered = false;
        }

        key(IdxSavingsAccount; "Savings Account")
        {
            Clustered = false;
        }

        key(IdxSourceAccount; "Source Account")
        {
            Clustered = false;
        }

        key(IdxLoanNo; "Loan No.")
        {
            Clustered = false;
        }

        // Composite keys for efficient queries involving multiple fields
        key(IdxTransactionStatusType; "Transaction Status", "Transaction Type")
        {
            Clustered = false;
        }

        key(IdxOriginatorIDPosted; "Originator ID", "Posted")
        {
            Clustered = false;
        }

        key(IdxLoanNoPosted; "Loan No.", "Posted")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
    begin

    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
        Error('Deletion is NOT allowed on this table');
    end;

    trigger OnRename()
    begin

    end;

}

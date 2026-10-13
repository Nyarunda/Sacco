page 55095 "Old Teller Trans"
{
    Caption = 'Old Teller Trans';
    PageType = List;
    SourceTable = "Transactions- CBS";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = WHERE(Posted = CONST(true), "Cheque Processed" = CONST(False), Type = CONST('Cheque Deposit'));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Account Type Code"; Rec."Account Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type Code field.';
                }
                field("Account Description"; Rec."Account Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Description field.';
                }
                field("Denomination Total"; Rec."Denomination Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Denomination Total field.';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Type field.';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field("Bank No"; Rec."Bank No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank No field.';
                }
                field("Branch No"; Rec."Branch No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch No field.';
                }
                field("Clearing Charges"; Rec."Clearing Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Charges field.';
                }
                field("Clearing Days"; Rec."Clearing Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Days field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Transaction Mode"; Rec."Transaction Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Description field.';
                }
                field("Minimum Account Balance"; Rec."Minimum Account Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Account Balance field.';
                }
                field("Fee Below Minimum Balance"; Rec."Fee Below Minimum Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fee Below Minimum Balance field.';
                }
                field("Normal Withdrawal Charge"; Rec."Normal Withdrawal Charge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Normal Withdrawal Charge field.';
                }
                field(Authorised; Rec.Authorised)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorised field.';
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Checked By field.';
                }
                field("Fee on Withdrawal Interval"; Rec."Fee on Withdrawal Interval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fee on Withdrawal Interval field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Maturity Date field.';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Category field.';
                }
                field(Deposited; Rec.Deposited)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposited field.';
                }
                field("Date Deposited"; Rec."Date Deposited")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Deposited field.';
                }
                field("Time Deposited"; Rec."Time Deposited")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Deposited field.';
                }
                field("Deposited By"; Rec."Deposited By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposited By field.';
                }
                field("Post Dated"; Rec."Post Dated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Dated field.';
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field("Status Date"; Rec."Status Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Date field.';
                }
                field("Status Time"; Rec."Status Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Time field.';
                }
                field("Supervisor Checked"; Rec."Supervisor Checked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Checked field.';
                }
                field("Book Balance"; Rec."Book Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Balance field.';
                }
                field("Notice No"; Rec."Notice No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notice No field.';
                }
                field("Notice Cleared"; Rec."Notice Cleared")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notice Cleared field.';
                }
                field("Has Schedule"; Rec."Has Schedule")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Has Schedule field.';
                }
                field(Requested; Rec.Requested)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested field.';
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Requested field.';
                }
                field("Time Requested"; Rec."Time Requested")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Requested field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field(Overdraft; Rec.Overdraft)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Overdraft field.';
                }
                field("Cheque Processed"; Rec."Cheque Processed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Processed field.';
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff/Payroll No field.';
                }
                field("Cheque Transferred"; Rec."Cheque Transferred")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Transferred field.';
                }
                field("Expected Amount"; Rec."Expected Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Amount field.';
                }
                field("Line Totals"; Rec."Line Totals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Totals field.';
                }
                field("Transfer Date"; Rec."Transfer Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer Date field.';
                }
                field("BIH No"; Rec."BIH No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BIH No field.';
                }
                field("Transfer No"; Rec."Transfer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer No field.';
                }
                field(Attached; Rec.Attached)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attached field.';
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOSA Account No field.';
                }
                field("Salary Processing"; Rec."Salary Processing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salary Processing field.';
                }
                field("Expense Account"; Rec."Expense Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Account field.';
                }
                field("Expense Description"; Rec."Expense Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Description field.';
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Code field.';
                }
                field("Schedule Type"; Rec."Schedule Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Schedule Type field.';
                }
                field("Banked By"; Rec."Banked By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banked By field.';
                }
                field("Date Banked"; Rec."Date Banked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Banked field.';
                }
                field("Time Banked"; Rec."Time Banked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Banked field.';
                }
                field("Banking Posted"; Rec."Banking Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banking Posted field.';
                }
                field("Cleared By"; Rec."Cleared By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field("Date Cleared"; Rec."Date Cleared")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Cleared field.';
                }
                field("Time Cleared"; Rec."Time Cleared")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Cleared field.';
                }
                field("Clearing Posted"; Rec."Clearing Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Posted field.';
                }
                field("Needs Approval"; Rec."Needs Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Needs Approval field.';
                }
                field("ID Type"; Rec."ID Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID Type field.';
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID No field.';
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Refund Cheque"; Rec."Refund Cheque")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Refund Cheque field.';
                }
                field(Imported; Rec.Imported)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imported field.';
                }
                field("External Account No"; Rec."External Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Account No field.';
                }
                field("BOSA Transactions"; Rec."BOSA Transactions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOSA Transactions field.';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field("Savers Total"; Rec."Savers Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Savers Total field.';
                }
                field("Mustaafu Total"; Rec."Mustaafu Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mustaafu Total field.';
                }
                field("Junior Star Total"; Rec."Junior Star Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Junior Star Total field.';
                }
                field(Printed; Rec.Printed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Printed field.';
                }
                field("Account Type."; Rec."Account Type.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No2"; Rec."Account No2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Withdrawal FrequencyAuthorised"; Rec."Withdrawal FrequencyAuthorised")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Withdrawal FrequencyAuthorised field.';
                }
                field("Frequency Needs Approval"; Rec."Frequency Needs Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Frequency Needs Approval field.';
                }
                field("Special Advance No"; Rec."Special Advance No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Advance No field.';
                }
                field("Bankers Cheque Type"; Rec."Bankers Cheque Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bankers Cheque Type field.';
                }
                field("Suspended Amount"; Rec."Suspended Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suspended Amount field.';
                }
                field("Transferred By EFT"; Rec."Transferred By EFT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transferred By EFT field.';
                }
                field("Banking User"; Rec."Banking User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Banking User field.';
                }
                field("Company Text Name"; Rec."Company Text Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Text Name field.';
                }
                field("Total Salaries"; Rec."Total Salaries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Salaries field.';
                }
                field("EFT Transferred"; Rec."EFT Transferred")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EFT Transferred field.';
                }
                field("ATM Transactions Total"; Rec."ATM Transactions Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATM Transactions Total field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("External Account Name"; Rec."External Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Account Name field.';
                }
                field("Overdraft Limit"; Rec."Overdraft Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Overdraft Limit field.';
                }
                field("Overdraft Allowed"; Rec."Overdraft Allowed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Overdraft Allowed field.';
                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available Balance field.';
                }
                field("Authorisation Requirement"; Rec."Authorisation Requirement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorisation Requirement field.';
                }
                field("Bankers Cheque No"; Rec."Bankers Cheque No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bankers Cheque No field.';
                }
                field("Transaction Span"; Rec."Transaction Span")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Span field.';
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Uncleared Cheques field.';
                }
                field("Transaction Available Balance"; Rec."Transaction Available Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Available Balance field.';
                }
                field("Branch Account"; Rec."Branch Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Account field.';
                }
                field("Branch Transaction"; Rec."Branch Transaction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Transaction field.';
                }
                field("FOSA Branch Name"; Rec."FOSA Branch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FOSA Branch Name field.';
                }
                field("Branch Refference"; Rec."Branch Refference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Refference field.';
                }
                field("Branch Account No"; Rec."Branch Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Account No field.';
                }
                field("Branch Transaction Date"; Rec."Branch Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Transaction Date field.';
                }
                field("Post Attempted"; Rec."Post Attempted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Attempted field.';
                }
                field("Transacting Branch"; Rec."Transacting Branch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transacting Branch field.';
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signature field.';
                }
                field("Amount Discounted"; Rec."Amount Discounted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Discounted field.';
                }
                field("Dont Clear"; Rec."Dont Clear")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dont Clear field.';
                }
                field("Other Bankers No."; Rec."Other Bankers No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Bankers No. field.';
                }
                field("N.A.H Balance"; Rec."N.A.H Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the N.A.H Balance field.';
                }
                field("Cheque Deposit Remarks"; Rec."Cheque Deposit Remarks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Deposit Remarks field.';
                }
                field(Payout; Rec.Payout)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payout field.';
                }
                field("Atm Number"; Rec."Atm Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Atm Number field.';
                }
                field("Attempted Self Transaction"; Rec."Attempted Self Transaction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attempted Self Transaction field.';
                }
                field("Change Log"; Rec."Change Log")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Change Log field.';
                }
                field(check; Rec.check)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the check field.';
                }
                field(Time_checked; Rec.Time_checked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time_checked field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field("Cheque Status"; Rec."Cheque Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Status field.';
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process field.';
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signing Instructions field.';
                }
                field("Cheque Bank"; Rec."Cheque Bank")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Bank field.';
                }
                field("Cheque Bank Name"; Rec."Cheque Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Bank Name field.';
                }
                field(Drawer; Rec.Drawer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drawer field.';
                }
                field("Approval By"; Rec."Approval By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval By field.';
                }
                field("Cheque Bank Branch"; Rec."Cheque Bank Branch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Bank Branch field.';
                }
                field("Blocked Amount No."; Rec."Blocked Amount No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked Amount No. field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Protected Account"; Rec."Protected Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Protected Account field.';
                }
                field("Cheque Cleared By"; Rec."Cheque Cleared By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque Cleared By field.';
                }
                field("Supervisor Approval Status"; Rec."Supervisor Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Approval Status field.';
                }
                field("Signing Instruction Narrative"; Rec."Signing Instruction Narrative")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signing Instruction Narrative field.';
                }
                field("Frequency Withdrawal Charged"; Rec."Frequency Withdrawal Charged")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Frequency Withdrawal Charged field.';
                }
            }
        }
    }
}

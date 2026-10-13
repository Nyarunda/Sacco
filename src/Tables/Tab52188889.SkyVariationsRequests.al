table 50591 "Sky Variation Requests"
{
    Caption = 'Sky Variations Requests';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Member No"; Code[20])
        {
        }
        field(3; "Member Name"; Text[100])
        {
        }
        field(4; "Loan No"; Code[20])
        {
        }
        field(5; "Variation Type"; Option)
        {
            OptionMembers = ,Loan,Deposit;
        }
        field(6; "New Repayment Term"; Integer)
        {
        }
        field(7; "New Deposit"; Decimal)
        {
        }
        field(8; "Original Loan Ammount"; Decimal)
        {
        }
        field(9; "Original Repayment Term"; Integer)
        {
        }
        field(10; "Date Of Disbursement"; Date)
        {
        }
        field(11; Insurance; Decimal)
        {
        }
        field(12; "Original Deposits"; Decimal)
        {
        }
        field(13; "Date Of Variation"; Date)
        {
        }
        field(14; Status; Option)
        {
            OptionMembers = Pending,Approved,Rejected,Cancelled;
        }
        field(15; "Approved Date"; Date)
        {
        }
        field(16; "Approved Time"; Time)
        {
        }
        field(17; "Approved By"; Code[50])
        {
        }
        field(18; "Rejected Date"; Date)
        {
        }
        field(19; "Rejected Time"; Time)
        {
        }
        field(20; "Rejected By"; Code[50])
        {
        }
        field(22; "Rejection Reason"; Text[250])
        {
        }
        field(23; "Cancelled Date"; Date)
        {
        }
        field(24; "Cancelled Time"; Time)
        {
        }
        field(25; "Cancelled By"; Code[50])
        {
        }
        field(26; "Cancellation Reason"; Text[250])
        {
        }
        field(27; "Change Reason"; Text[250])
        {
        }
        field(28; "Request ID"; Code[150])
        {
        }
        field(29; "No. Series"; Code[20])
        {
        }
        field(30; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(31; "Created By"; Code[50])
        {
        }
        field(32; "Outstanding Balance"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
        key(Key2; "Member No", Status)
        {
        }
        key(Key3; "Member No", "Variation Type")
        {
        }
    }

    fieldgroups
    {
    }
}

table 50617 "Loan Reminder Notifications"
{
    Caption = 'Loan Reminder Notifications';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Loan Reminder Notifications";
    LookupPageId = "Loan Reminder Notifications";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan No.";
        }
        field(3; "Member No"; Code[20])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
            TableRelation = Members."No.";
        }
        field(4; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Sent,Failed;
            OptionCaption = ' ,Open,Sent,Failed';
        }
        field(7; Message; Text[1000])
        {
            Caption = 'Message';
            DataClassification = ToBeClassified;
        }
        field(8; "Notification Type"; Option)
        {
            Caption = 'Notification Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",SMS,Email,"SMS & Email";
            OptionCaption = ' ,SMS,Email,SMS & Email';
        }
        field(9; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = ToBeClassified;
        }
        field(10; "Expected Date"; Date)
        {
            Caption = 'Expected Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Amount Due"; Decimal)
        {
            Caption = 'Amount Due';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(Loan; "Loan No.", "Expected Date")
        {
        }
        key(Member; "Member No", "Expected Date")
        {
        }
    }
}

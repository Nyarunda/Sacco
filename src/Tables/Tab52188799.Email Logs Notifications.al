table 50481 "Email Logs Notifications"
{
    Caption = 'Email Logs Notifications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(2; Msg; Text[2038])
        {
            Caption = 'Customer Msg.';
        }
        field(3; Source; Enum "Loan Source")
        {
        }
        field(4; Line; Integer)
        {
            Caption = 'Line Number';
            AutoIncrement = true;
        }
        field(5; "Error Msg"; Text[250])
        {

        }
        field(6; Status; Option)
        {
            OptionMembers = " ",Failed;
        }
        field(7; "Guarantor No."; code[20])
        {

        }
        field(10; Sent; Boolean)
        {
            //Caption = 'Sent';
        }
        field(11; "Sent Remmitance"; Boolean)
        {
            /// Caption = 'Sent';
        }
        field(12; "Send Partial Letter"; Boolean)
        {
            //Caption = 'Sent';
        }
        field(13; "Partial Disbur. Header No."; Code[20])
        {
            Caption = 'Partial Disbursement Header No.';
            DataClassification = CustomerContent;
            TableRelation = "Partial Loans Disb. Header"."No.";
        }

    }
    keys
    {
        key(PK; "Loan No.", Line, Source)
        {
            Clustered = true;
        }
    }
}

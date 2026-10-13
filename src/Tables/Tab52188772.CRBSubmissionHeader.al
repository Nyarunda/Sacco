table 50546 "CRB Submission Header"
{
    Caption = 'CRB Submission Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
        }
        field(4; "Type"; Option)
        {
            OptionMembers = Normal,Update,Closure;
        }
        field(5; Success; Boolean)
        {
            Caption = 'Success';
        }
        field(6; "Has Error"; Boolean)
        {
            Caption = 'Has Error';
        }
        field(7; "Api Code"; Code[20])
        {
            Caption = 'Api Code';
        }
        field(8; "Api Code Description"; Text[100])
        {
            Caption = 'Api Code Description';
        }
        field(9; "Transaction ID"; Text[100])
        {
            Caption = 'Transaction ID';
        }
        field(10; "Repayment Start Date"; Date)
        {
        }
        field(11; "Member No. Filter"; Text[1000])
        {

            TableRelation = Customer;
        }
        field(12; "Loan No. Filter"; Text[1000])
        {

            TableRelation = Loans;
        }
        field(13; "Loan Product Filter"; Text[1000])
        {

            TableRelation = "Product Setup";
        }

        field(14; "Repayment End Date"; Date)
        {

        }
        field(15; "Completion Start Date"; Date)
        {

        }
        field(16; "Completion End Date"; Date)
        {

        }
        field(17; "Is Final Submission"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(18; "Category"; Option)
        {
            OptionMembers = Individual,Joint,Chamaa,Business,MicroGroup;
        }

    }




    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        Date := Today;

        "Captured By" := userid;
    end;
}

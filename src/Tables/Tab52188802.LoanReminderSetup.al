table 50484 "Loan Reminder Setup"
{
    Caption = 'Loan Reminder Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "Loan Reminder Setup";

    fields
    {

        field(1; "Reminder Type"; Option)
        {
            Caption = 'Reminder Type';
            OptionMembers = " ","Before Due Date","On Due Date","After Due Date";
        }
        field(2; "Loan Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Product Setup";
        }
        field(3; "Loan Reminder Days"; DateFormula)
        {
            Caption = 'Loan Reminder Days';
        }
    }
    keys
    {
        key(PK; "Loan Product", "Reminder Type")
        {
            Clustered = true;
        }
    }
}

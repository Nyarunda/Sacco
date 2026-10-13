/// <summary>
/// TableExtension Customer Posting Group (ID 50081) extends Record Customer Posting Group.
/// </summary>
tableextension 50081 "Customer Posting Group" extends "Customer Posting Group"
{
    fields
    {
        field(90000; "Customer Type"; Enum "Customer Type Enum")
        {
            Caption = 'Customer Type ';
            DataClassification = ToBeClassified;
        }
        field(50013; "Payables Account"; Code[20])
        {
            Caption = 'Payables Account';
            DataClassification = ToBeClassified;
            Editable = true;
        }
    }
}

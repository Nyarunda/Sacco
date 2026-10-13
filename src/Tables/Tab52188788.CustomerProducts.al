/// <summary>
/// Table Customer Products (ID 50470).
/// </summary>
table 50470 "Customer Products"
{
    Caption = 'Customer Products';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No"; Code[20])
        {
            Caption = 'Customer No';
        }
        field(2; "Product Code"; Code[10])
        {
            Caption = 'Product Code';
        }
    }
    keys
    {
        key(PK; "Customer No", "Product Code")
        {
            Clustered = true;
        }
    }
}

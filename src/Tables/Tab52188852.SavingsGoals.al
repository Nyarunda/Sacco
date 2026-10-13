table 50554 "Savings Goals"
{
    Caption = 'Savings Goals';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Code[20])
        {
            Caption = 'Line No.';
        }
        field(2; "Account No. "; Code[20])
        {
            Caption = 'Account No. ';
        }
        field(3; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
        }
        field(4; "Member No."; Code[20])
        {
            Caption = 'Member No.';
        }
        field(5; "Product Type"; Code[20])
        {
            Caption = 'Product Type';
        }
        field(6; "Product Description"; Text[100])
        {
            Caption = 'Product Description';
        }
        field(7; "Target Balance"; Decimal)
        {
            Caption = 'Target Balance';
        }
        field(8; "Starting Balance"; Decimal)
        {
            Caption = 'Starting Balance';
        }
        field(9; "Period (Months)"; Integer)
        {
            Caption = 'Period (Months)';
        }
        field(10; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(11; "Created By"; Date)
        {
            Caption = 'Created By';
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Active,Inactive,Achieved,Cancelled;

        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// Calculate the current progress of the savings goal
    /// </summary>
    /// <param name="CurrentBalance">Current balance of the associated account</param>
    /// <returns>Progress percentage between 0 and 100</returns>
    procedure CalculateProgress(CurrentBalance: Decimal): Integer
    var
        Progress: Integer;
    begin
        // Calculate progress percentage
        if "Target Balance" <> "Starting Balance" then
            Progress := Round(((CurrentBalance - "Starting Balance") / ("Target Balance" - "Starting Balance")) * 100, 1)
        else
            Progress := 0;

        // Cap progress at 100%
        if Progress > 100 then
            Progress := 100;

        // If progress is negative (current balance less than starting balance), set to 0
        if Progress < 0 then
            Progress := 0;

        exit(Progress);
    end;
}

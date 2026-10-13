
/// <summary>
/// TableExtension tableextension52188402 (ID 50165) extends Record G/L Account.
/// </summary>
TableExtension 50165 tableextension52188402 extends "G/L Account"
{
    fields
    {
        field(50000; "Cashier G/L"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Can Pay Board"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Can Pay Staff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Can Pay Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Is VAT Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90000; "Expense Code"; Code[20])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
        }
        field(50013; "Budget Controlled"; Boolean)
        {
            Caption = 'Budget Controlled';
            DataClassification = ToBeClassified;
        }
        field(50017; "Budget Control Account"; Code[20])
        {
            Caption = 'Budget Control Account';
            DataClassification = ToBeClassified;
        }

    }

    trigger OnModify()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Edit Chart of Accounts", false);
        if UserSetup.FindFirst() then Error(EditError);

    end;

    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Edit Chart of Accounts", false);
        if UserSetup.FindFirst() then Error(EditError);
    end;


    trigger OnDelete()
    var
        Usersetup: Record "User Setup";
    begin
        Usersetup.Get(UserId);
        if not Usersetup."Delete Chart of Accounts" then
            Error('You do not have permission to delete. "Delete Chart of Accounts"');
    end;


    var
        EditError: Label 'You do not have permission to Edit chart of accounts. Contact ICT administrator';
}


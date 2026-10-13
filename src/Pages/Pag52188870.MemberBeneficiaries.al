page 50995 "Member Beneficiaries"
{
    ApplicationArea = All;
    Caption = 'Member Beneficiaries';
    PageType = List;
    SourceTable = "Member Beneficiaries";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Beneficiary ID"; Rec."Beneficiary ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the beneficiary.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the beneficiary.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of beneficiary.';
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank if applicable.';
                    Visible = Rec.Type = Rec.Type::Bank;
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account number of the beneficiary.';
                }
                field("Date Added"; Rec."Date Added")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the beneficiary was added.';
                }
            }
        }
    }
}


Page 50117 "Payroll Earnings & Deductions"
{
    CardPageID = "Payroll Code.";
    Editable = false;
    PageType = List;
    SourceTable = "Payroll Codes";
    SourceTableView = where("Transaction Type" = filter(Deduction | Earning));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionCode; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(SortOrder; Rec."Sort Order")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceType; Rec."Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field(CalculationType; Rec."Calculation Type")
                {
                    ApplicationArea = Basic;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = Basic;
                }
                field(SpecialTransactions; Rec."Special Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(DeductPremium; Rec."Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field(EmployerDeduction; Rec."Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialIdentifier; Rec."Special Identifier")
                {
                    ApplicationArea = Basic;
                }
                field(IncludeEmployerDeduction; Rec."Include Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        RestrictAccess
    end;


    procedure RestrictAccess()
    var
        SaccoPermissions: Record "User Setup";
    begin
        SaccoPermissions.Reset;
        SaccoPermissions.SetRange("User ID", UserId);
        SaccoPermissions.SetRange(Payroll, true);
        if not SaccoPermissions.FindFirst then
            Error('You do not have the following permission: "Payroll"');
    end;
}



Page 50116 "Payroll Period transactions."
{
    PageType = List;
    SourceTable = "Payroll Period Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(Grouping; Rec.Grouping)
                {
                    ApplicationArea = Basic;
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field(GroupOrder; Rec."Group Order")
                {
                    ApplicationArea = Basic;
                }
                field(SubGroupOrder; Rec."Sub Group Order")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ApplicationArea = Basic;
                }
                field(PeriodFilter; Rec."Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field(EntryType; Rec."Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(PostAs; Rec."Post As")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollCode; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field(PaymentMode; Rec."Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(ACNumber; Rec."A/C Number")
                {
                    ApplicationArea = Basic;
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field(BranchName; Rec."Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(PayrollCodeType; Rec."Payroll Code Type")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialTransactions; Rec."Special Transactions")
                {
                    ApplicationArea = Basic;
                }
                field(SpecialIdentifier; Rec."Special Identifier")
                {
                    ApplicationArea = Basic;
                }
                field("Payslip Sort Order"; Rec."Payslip Sort Order")
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
        HRPayrollPermissionMgt: Codeunit "HR Payroll Permission Mgt";
    begin
        HRPayrollPermissionMgt.RequirePayrollAccess();
    end;
}

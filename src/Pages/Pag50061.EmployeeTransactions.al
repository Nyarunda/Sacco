page 50061 "Employee Transactions"
{
    Caption = 'Employee Transactions';
    PageType = List;
    SourceTable = "Payroll Employee Transactions";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Amount field.';
                }
                field("Employer Balance"; Rec."Employer Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Balance field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Code field.';
                }
                field(Stopped; Rec.Stopped)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stopped field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Sub-Ledger"; Rec."Sub-Ledger")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Ledger field.';
                }
                field("Sub-Ledger Account"; Rec."Sub-Ledger Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Ledger Account field.';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("User Defined Loan Interest"; Rec."User Defined Loan Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Defined Loan Interest field.';
                }
                field("Amortization Total Repayment"; Rec."Amortization Total Repayment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amortization Total Repayment field.';
                }
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryNo field.';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
            }
        }
    }
}

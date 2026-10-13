
Table 50227 "Payroll Period Transactions"
{
    DrillDownPageID = "Payroll Codes List.";
    LookupPageID = "Payroll Codes List.";

    fields
    {
        field(1; "Employee Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '"HR Employees".No.';
            TableRelation = Employee."No.";
        }
        field(2; "Transaction Code"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '"PR Transaction Codes"."Transaction Code"';
            TableRelation = "Payroll Codes"."Transaction Code";
        }
        field(3; Grouping; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Basic Salary,Allowances,Gross Salary,Tax Calculations,Statutories,Deductions,Net Salary,Housing Levy,Housing Levy Levy,Fringe';
            OptionMembers = " ","Basic Salary",Allowances,"Gross Salary","Tax Calculations",Statutories,Deductions,"Net Salary","Housing Levy","Housing Levy Levy",Fringe;
        }
        field(4; "Transaction Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Group Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sub Group Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Periods"."Date Opened";
        }
        field(13; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Employer,Employee;
        }
        field(14; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(15; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee;
        }
        field(16; "Post As"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Debit,Credit;
        }
        field(17; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Payment Mode"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(19; "Bank Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Branch Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "A/C Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(25; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(26; "Payroll Code Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Income,Deduction';
            OptionMembers = Earning,Deduction,"Basic Pay","Gross Pay","Net Pay",PAYE;
        }
        field(27; "Special Transactions"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Represents all Special Transactions';
            OptionMembers = "None","Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Fringe Benefit",Mortgage,"Salary Arrears","Staff Loan","Staff Welfare";
        }
        field(28; "Special Identifier"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",NHIF,NSSF,"House Allowance","Housing Levy";
        }
        field(29; "Sub Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",BasicPay,"BasicPay Arrears","Defined Contribution","Tax Relief","Insurance Relief","Taxable Pay","Tax Charged",NSSF,NHIF,PAYE,"PAYE Arrears","Pension Relief","Owner Occupier","Home Ownership","Non-Taxable","Housing Levy";
        }
        field(30; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Sacco Transaction Type"; Enum "Transaction Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Reference No"; Integer)
        {
        }
        field(33; "Payslip Sort Order"; Integer)
        {
        }
        field(34; "Updated"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Payroll Period", "Entry Type", "Reference No", "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "Payslip Sort Order", "Group Order")
        {
        }
    }

    fieldgroups
    {
    }
}


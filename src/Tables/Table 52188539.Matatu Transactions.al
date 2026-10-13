
Table 50202 "Matatu Transactions"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Member Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member Id No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Member PhoneNo"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; TransactionType; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Ministatement,SaccoAccounts,LoanInfor,BalanceInquiry,CashDeposit,CashSharedeposit,CashWithdraw,LoanRepayment,MemberActivation,MemberPinChange,MemberRegistration,MatatuContribution';
            OptionMembers = ,Ministatement,SaccoAccounts,LoanInfor,BalanceInquiry,CashDeposit,CashSharedeposit,CashWithdraw,LoanRepayment,MemberActivation,MemberPinChange,MemberRegistration,MatatuContribution;
        }
        field(7; TransactionDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; TransactiomTime; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Attached Document Link"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; AgentCode; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Agent List";
        }
        field(12; Account; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; DocumentNo; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Vehicle Plates No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Vehicle Fleet No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Transaction Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Transaction Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Depositors Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Account Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal Deposit,Cash Withdrawal,Balance Enquiry,Ministatement,Loan Repayment,Fleet Deposit';
            OptionMembers = " ","Normal Deposit","Cash Withdrawal","Balance Enquiry",Ministatement,"Loan Repayment","Fleet Deposit";
        }
        field(36; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Group,Member,Vehicle';
            OptionMembers = " ",Group,Member,Vehicle;
        }
        field(37; Terminus; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Terminus Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Date Reversed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Reversal Request By"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Marked For Reversal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Credit Ledger"; Integer)
        {
            CalcFormula = count("Credit Ledger Entry" where("Document No." = field(DocumentNo)));
            FieldClass = FlowField;
        }
        field(46; "Credit Entry"; Integer)
        {
            CalcFormula = count("Credit Ledger Entry" where("Member No." = field("Member Number")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}


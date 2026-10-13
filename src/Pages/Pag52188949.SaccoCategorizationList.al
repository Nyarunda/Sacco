namespace CentralDB.CentralDB;

page 50651 "Sacco Categorization List"
{
    ApplicationArea = All;
    Editable = false;
    Caption = 'Sacco Categorization List';
    PageType = List;
    SourceTable = "SACCO Categorization";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("As At"; Rec."As At")
                {
                    ToolTip = 'Specifies the value of the As At field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the IFRS Stage field.';
                }
                field("Days in Arrears"; Rec."Days in Arrears")
                {
                    ToolTip = 'Specifies the value of the Days in Arrears field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ToolTip = 'Specifies the value of the Employer Code field.';
                }
                field("Installments Defaulted"; Rec."Installments Defaulted")
                {
                    ToolTip = 'Specifies the value of the Installments Defaulted field.';
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ToolTip = 'Specifies the value of the Issued Date field.';
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ToolTip = 'Specifies the value of the Loan Category field.';
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Next Run Date"; Rec."Next Run Date")
                {
                    ToolTip = 'Specifies the value of the Next Run Date field.';
                }
                field("Outstanding Appraisal"; Rec."Outstanding Appraisal")
                {
                    ToolTip = 'Specifies the value of the Outstanding Appraisal field.';
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ToolTip = 'Specifies the value of the Outstanding Interest field.';
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ToolTip = 'Specifies the value of the Outstanding Penalty field.';
                }
                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ToolTip = 'Specifies the value of the Outstanding Principal field.';
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ToolTip = 'Specifies the value of the Principal Arrears field.';
                }
                field("Principal Expected"; Rec."Principal Expected")
                {
                    ToolTip = 'Specifies the value of the Principal Expected field.';
                }
                field("Principal Paid"; Rec."Principal Paid")
                {
                    ToolTip = 'Specifies the value of the Principal Paid field.';
                }
                field("Repay Mode"; Rec."Repay Mode")
                {
                    ToolTip = 'Specifies the value of the Repay Mode field.';
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ToolTip = 'Specifies the value of the Total Arrears field.';
                }
                field("Total Balance"; Rec."Total Balance")
                {
                    ToolTip = 'Specifies the value of the Total Balance field.';
                }
                field("Total Outstanding Balance"; Rec."Total Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Total Outstanding Balance field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }
}

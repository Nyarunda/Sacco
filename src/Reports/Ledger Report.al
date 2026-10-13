report 50042 "Ledgers Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Ledgers Report.rdlc';

    dataset
    {
        dataitem("Credit Ledger Entry"; "Credit Ledger Entry")
        {
            RequestFilterFields = "Transaction Type";
            column(EntryNo_CreditLedgerEntry; "Credit Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_CreditLedgerEntry; "Credit Ledger Entry"."Account No.")
            {
            }
            column(PostingDate_CreditLedgerEntry; FORMAT("Credit Ledger Entry"."Posting Date"))
            {
            }
            column(DocumentNo_CreditLedgerEntry; "Credit Ledger Entry"."Document No.")
            {
            }
            column(Description_CreditLedgerEntry; "Credit Ledger Entry".Description)
            {
            }
            column(Amount_CreditLedgerEntry; "Credit Ledger Entry".Amount * -1)
            {
            }
            column(LoanNo_CreditLedgerEntry; "Credit Ledger Entry"."Loan No.")
            {
            }
            column(MemberName_CreditLedgerEntry; Name)
            {
            }
            column(LoanType_CreditLedgerEntry; "Credit Ledger Entry"."Loan Type")
            {
            }
            column(TransactionType_CreditLedgerEntry; "Credit Ledger Entry"."Transaction Type")
            {
            }
            column(Staff; Staff)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Name := '';
                Staff := '';
                Loans.SETRANGE("Loan Account", "Account No.");
                IF Loans.FINDFIRST THEN BEGIN
                    Members.SETRANGE("No.", Loans."Member No.");
                    IF Members.FINDFIRST THEN BEGIN
                        IF Members."Employer Code" <> EmpCode THEN
                            CurrReport.SKIP;
                        Name := Members.Name;
                        Staff := Members."Payroll/Staff No.";
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin


                "Credit Ledger Entry".SETRANGE("Document No.", DocumentNo);
                IF TType <> TType::" " THEN
                    "Credit Ledger Entry".SETFILTER("Transaction Type", '%1', TType)
                ELSE
                    "Credit Ledger Entry".SETFILTER("Transaction Type", '%1|%2', TType::Repayment, TType::"Interest Paid");
            end;
        }
        dataitem("Savings Ledger Entry"; "Savings Ledger Entry")
        {
            column(EntryNo_SavingsLedgerEntry; "Savings Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_SavingsLedgerEntry; "Savings Ledger Entry"."Account No.")
            {
            }
            column(PostingDate_SavingsLedgerEntry; FORMAT("Savings Ledger Entry"."Posting Date"))
            {
            }
            column(DocumentNo_SavingsLedgerEntry; "Savings Ledger Entry"."Document No.")
            {
            }
            column(Description_SavingsLedgerEntry; "Savings Ledger Entry".Description)
            {
            }
            column(Amount_SavingsLedgerEntry; "Savings Ledger Entry".Amount * -1)
            {
            }
            column(Name; Name)
            {
            }
            column(StaffNo; Staff)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Name := '';
                Staff := '';
                IF SavingsAcc.GET("Account No.") THEN BEGIN
                    IF SavingsAcc."Employer Code" <> EmpCode THEN
                        CurrReport.SKIP;
                    IF SavingsAcc."Product Type" <> SavProd THEN
                        CurrReport.SKIP;
                    Name := SavingsAcc.Name;
                    Staff := SavingsAcc."Payroll/Staff No.";
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Document No.", DocumentNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Transaction Type"; TType)
                {
                    ApplicationArea = All;
                }
                field(Employer; EmpCode)
                {
                    ApplicationArea = All;
                    TableRelation = Customer;
                }
                field("Document No"; DocumentNo)
                {
                    ApplicationArea = All;
                    TableRelation = "Monthly Checkoff Header"."No.";
                }
                field("Product Id"; SavProd)
                {
                    ApplicationArea = All;
                    TableRelation = "Product Setup"."Product ID" WHERE("Product Class" = CONST(Savings));
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        StatusPermission.RESET;
        StatusPermission.SETRANGE(StatusPermission."User ID", USERID);
        StatusPermission.SETRANGE(StatusPermission.Reports, TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    var
        Name: Text;
        Staff: Code[20];
        SavingsAcc: Record "Savings Accounts";
        Emp: Record Customer;
        EmpCode: Code[20];
        DocumentNo: Code[20];
        Loans: Record Loans;
        Members: Record Members;
        TType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,Appraisal;
        ProductFactory: Record "Product Setup";
        SavProd: Code[10];
        StatusPermission: Record "User Setup";
}


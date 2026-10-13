namespace UnitedWomen.UnitedWomen;

report 50586 "EFT Report"
{
    Caption = 'EFT Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/EFT Report.rdlc';
    dataset
    {
        dataitem(HREmployeeBankAccounts; "HR Employee Bank Accounts")
        {
            column(EmployeeCode; "Employee Code")
            {
            }
            column(BankCode; "Bank Code")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BranchCode; "Branch Code")
            {
            }
            column(BranchName; "Branch Name")
            {
            }
            column(ACNumber; "A/C Number")
            {
            }
            column(AmounttoTransfer; "Amount to Transfer")
            {
            }
            column(DisbursementBankName; "Disbursement Bank Name")
            {
            }
            column(DisbursementAccountNo; "Disbursement Account No.")
            {
            }
            column(ChequeNo; "Cheque No.")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(ModeofDisbursement; "Mode of Disbursement")
            {
            }
            column(BeneficiaryName; BeneficiaryName)
            { }
            column(CustomerNo; CustomerNo)
            { }
            column(swiftCode; SwiftCode)
            {
            }

            trigger OnAfterGetRecord()
            var
                LoansRec: Record Loans;
            begin
                LoansRec.Reset();
                LoansRec.SetRange("Loan No.", HREmployeeBankAccounts."Loan No.");
                if LoansRec.FindFirst() then begin

                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        BeneficiaryName: Text[100];
        CustomerNo: Code[20];

    local procedure GetTransactionType()
    begin

    end;
}

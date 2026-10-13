report 50056 "Loans Classifications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Loans Classifications.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Loans Category-SASRA", "Outstanding Principal";
            DataItemTableView = WHERE(Posted = CONST(true),
                                     "Outstanding Principal" = FILTER(> 0));
            RequestFilterFields = "Loans Category-SASRA", "Loan No.";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(ExpectedDateofCompletion_Loans; Loans."Completion Date")
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(OutstandingBalance_Loans; Loans."Outstanding Principal")
            {
            }
            column(DaysInArrears_Loans; Loans."SASRA Days Arrears")
            {
            }
            column(Arrears_Amount_Loans; Loans."Total Arrears")
            {
            }
            column(EmployerCode; EmployerCode)
            {
            }
            column(Deposits; Deposits)
            {
            }


            trigger OnAfterGetRecord()
            begin

                Deposits := 0;

                IF Members.GET(Loans."Member No.") THEN BEGIN
                    EmployerCode := Members."Employer Code";

                    MemberAccounts.Reset;
                    MemberAccounts.SetRange("Member No.", Loans."Member No.");
                    MemberAccounts.SetFilter("Product Category", '%1|%2', MemberAccounts."product category"::"Deposit Contribution", MemberAccounts."product category"::"Micro Member Deposit");
                    MemberAccounts.SetLoadFields("No.");
                    if MemberAccounts.FindFirst then begin
                        repeat
                            Deposits += MemberActivities.GetAccountBalance(MemberAccounts."No.");

                        until MemberAccounts.Next() = 0;
                    end;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        StatusPermission.SETRANGE(StatusPermission."SASRA Report", TRUE);
        IF NOT StatusPermission.FIND('-') THEN BEGIN
            ERROR('You Do Not have Permission to perform this action');
        END;
    end;

    var
        StatusPermission: Record "User Setup";
        Members: Record Members;
        Deposits: decimal;
        MemberActivities: Codeunit "Member Activities";
        MemberAccounts: Record "Savings Accounts";
        EmployerCode: Code[40];
}


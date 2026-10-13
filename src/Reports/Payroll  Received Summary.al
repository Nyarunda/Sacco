report 50048 "Payroll  Received Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Payroll  Received Summary.rdlc';

    dataset
    {
        dataitem("Checkoff Header"; "Monthly Checkoff Header")
        {
            DataItemTableView = WHERE(Posted = CONST(true),
                                      Status = CONST(Approved));
            RequestFilterFields = "No.", "Posting Date", "Employer Code";
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Amount_CheckoffHeader; "Checkoff Header".Amount)
            {
            }
            column(EmployerCode; EmployerCode)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(TotalDeposits; TotalDeposits)
            {
            }
            column(PrincipalPaid; PrincipalPaid)
            {
            }
            column(InterestPaid; InterestPaid)
            {
            }
            column(TotalRepayments; TotalRepayments)
            {
            }
            column(UnallocatedFunds; UnallocatedFunds)
            {
            }
            column(Fosa; Fosa)
            {
            }
            column(DocumentNo_CheckoffHeader; "Checkoff Header"."Document No.")
            {
            }
            column(AccountName_CheckoffHeader; "Checkoff Header"."Account Name")
            {
            }
            column(RegisrationFee; RegistrationFee)
            {
            }
            column(ShareDeposit; ShareDeposit)
            {
            }
            column(PreviousMonthPayroll; PreviousMonthPayroll)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalDeposits := 0;
                TotalRepayments := 0;
                PrincipalPaid := 0;
                InterestPaid := 0;
                UnallocatedFunds := 0;
                Fosa := 0;
                RegistrationFee := 0;
                ShareDeposit := 0;
                GetPreviousMonthPayroll;


                CreditLedgerEntry.RESET;
                CreditLedgerEntry.SETRANGE("Document No.", "Checkoff Header"."Document No.");
                CreditLedgerEntry.SETRANGE("Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
                IF CreditLedgerEntry.FINDFIRST THEN BEGIN
                    CreditLedgerEntry.CALCSUMS(Amount);
                    InterestPaid := CreditLedgerEntry.Amount * -1;
                END;

                CreditLedgerEntry.RESET;
                CreditLedgerEntry.SETRANGE("Document No.", "Checkoff Header"."Document No.");
                CreditLedgerEntry.SETRANGE("Transaction Type", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
                IF CreditLedgerEntry.FINDFIRST THEN BEGIN
                    CreditLedgerEntry.CALCSUMS(Amount);
                    PrincipalPaid := CreditLedgerEntry.Amount * -1;
                END;


                SavingsLedgerEntry.RESET;
                SavingsLedgerEntry.SETRANGE("Document No.", "Checkoff Header"."Document No.");
                IF SavingsLedgerEntry.FINDFIRST THEN
                    REPEAT
                        SavingsAccounts.RESET;
                        SavingsAccounts.SETRANGE("No.", SavingsLedgerEntry."Account No.");
                        IF SavingsAccounts.FINDFIRST THEN BEGIN
                            IF SavingsAccounts."Product Category" IN [SavingsAccounts."Product Category"::"Unallocated Fund"] THEN
                                UnallocatedFunds += (SavingsLedgerEntry.Amount * -1);
                            IF SavingsAccounts."Product Category" IN [SavingsAccounts."Product Category"::"Deposit Contribution", SavingsAccounts."Product Category"::"Mfi Deposit"] THEN
                                TotalDeposits += (SavingsLedgerEntry.Amount * -1);
                            IF SavingsAccounts."Product Category" IN [SavingsAccounts."Product Category"::"Junior Savings", SavingsAccounts."Product Category"::" "] THEN
                                Fosa += (SavingsLedgerEntry.Amount * -1);
                            IF SavingsAccounts."Product Category" IN [SavingsAccounts."Product Category"::"Registration Fee"] THEN
                                RegistrationFee += (SavingsLedgerEntry.Amount * -1);
                            IF SavingsAccounts."Product Category" IN [SavingsAccounts."Product Category"::"Share Capital"] THEN
                                ShareDeposit += (SavingsLedgerEntry.Amount * -1);
                        END;

                    UNTIL SavingsLedgerEntry.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                Company.GET;
                Company.CALCFIELDS(Picture);
                IF "Checkoff Header".GETFILTER("Checkoff Header"."Posting Date") <> '' THEN
                    DateFilter := FORMAT("Checkoff Header".GETRANGEMIN("Checkoff Header"."Posting Date")) + '..' + FORMAT("Checkoff Header".GETRANGEMAX("Checkoff Header"."Posting Date"));
                EmployerCode := "Checkoff Header".GETFILTER("Checkoff Header"."Employer Code");
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

    var
        TotalDeposits: Decimal;
        TotalRepayments: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        Loans: Record Loans;
        PrincipalPaid: Decimal;
        InterestPaid: Decimal;
        Company: Record "Company Information";
        EmployerCode: Code[100];
        DateFilter: Text;
        CheckoffLines: Record "Monthly Checkoff Lines";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        UnallocatedFunds: Decimal;
        Fosa: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        RegistrationFee: Decimal;
        ShareDeposit: Decimal;
        PreviousMonthPayroll: Decimal;

    local procedure GetPreviousMonthPayroll()
    var
        Checkoff: Record "Monthly Checkoff Header";
        //InterestDuePeriod: Record "39004416";
        PreviousMonthDocNo: Code[10];
        Cust: Record Customer;
    begin
        PreviousMonthPayroll := 0;
        IF "Checkoff Header"."Posting Date" <> 0D THEN BEGIN

            // InterestDuePeriod.RESET;
            // InterestDuePeriod.SETFILTER("Interest Due Date", '<%1', "Checkoff Header".Period);
            // InterestDuePeriod.SETCURRENTKEY("Interest Due Date");
            // InterestDuePeriod.SETASCENDING("Interest Due Date", FALSE);
            // IF InterestDuePeriod.FINDFIRST THEN BEGIN
            //     Cust.GET("Checkoff Header"."Account No.");
            //     PreviousMonthDocNo := UPPERCASE(PADSTR(COPYSTR(FORMAT(InterestDuePeriod."Interest Due Date", 0, '<Month Text>'), 1, 3) + FORMAT(DATE2DMY(InterestDuePeriod."Interest Due Date", 3)) + Cust.Initials + 'PAYROLL', 20));
            // END;

            Checkoff.RESET;
            Checkoff.SETRANGE(Posted, TRUE);
            Checkoff.SETRANGE(Status, Checkoff.Status::Approved);
            //Checkoff.SETRANGE("Document No.", PreviousMonthDocNo);
            IF Checkoff.FINDFIRST THEN BEGIN
                Checkoff.CALCSUMS(Amount);
                PreviousMonthPayroll := Checkoff.Amount;
            END;

        END;
    end;

}


report 50496 "Counter Service Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Counter Service Statement-Comb.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(Remarks_Loans; Members.Remarks)
            {
            }
            column(CompAddress; CompanyInfo.Address)
            {
            }
            column(CompPic; CompanyInfo.Picture)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Address; CompanyInfo.Address)
            {
            }
            column(Company_Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Company_Phone_No_2; CompanyInfo."Phone No. 2")
            {
            }
            column(Company_EMail_; CompanyInfo."E-Mail")
            {
            }
            column(Company_HomePage_; '')
            {
            }
            column(Company_Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Company_City; CompanyInfo.City)
            {
            }
            column(today; TODAY)
            {
            }
            column(PendingApprovals; PendingApprovals)
            {
            }
            column(DepositContr; DepositContr)
            {
            }
            column(MonthlyShareCap; MonthlyShareCap)
            {
            }
            column(ApprovedLoans; ApprovedLoans)
            {
            }
            column(TotalAdvice; TotalAdvice)
            {
            }
            column(TotalShareCap; TotalShareCap)
            {
            }
            column(TotalDeposit; TotalDeposit)
            {
            }
            column(TotalArrears; TotalArrears)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = FIELD("No.");
                DataItemTableView = WHERE("Total Outstanding Balance" = FILTER(> 0));
                column(LoanNo_Loans; Loans."Loan No.")
                {
                }
                column(LoanAccount_Loans; Loans."Loan Account")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(OutstandingBalance_Loans; Loans."Outstanding Principal")
                {
                }
                column(Installments_Loans; Loans.Installments)
                {
                }
                column(LastPayDate_Loans; Loans."Last Pay Date")
                {
                }
                column(OutstandingInterest_Loans; Loans."Outstanding Interest")
                {
                }
                column(OutstandingBills_Loans; Loans."Outstanding Principal")
                {
                }
                column(Defaulted_Loans; Loans.Defaulted)
                {
                }
                column(DisbursementDate_Loans; Loans."Disbursement Date")
                {
                }
                column(Repayment_Loans; SaccoActivities.SmartRound(Loans.Repayment))
                {
                }
                column(RemainingPeriod; RemainingPeriod)
                {
                }
                column(Category; Loans."Loans Category-SASRA")
                {
                }
                column(paymentpercentage; ((Loans."Approved Amount" - Loans."Outstanding Principal") / Loans."Approved Amount"))
                {
                }
                column(RecoveryMode_Loans; Loans."Repay Mode")
                {
                }
                column(LastRepaidAmt; LastRepaidAmt)
                {
                }
                column(LastIntPaid; LastRepaidAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RemainingPeriod := 0;
                    LastRepaymentPaid := 0;
                    LastRepaymentPaid := 0;
                    LastIntPaid := 0;

                    Loans.CALCFIELDS("Outstanding Principal");
                    IF Loans.Repayment <> 0 THEN
                        RemainingPeriod := ROUND((Loans."Outstanding Principal" / Loans.Repayment), 1, '<');

                    //last repaid amount
                    CreditLedgerEntry.RESET;
                    CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Loan No.", Loans."Loan No.");
                    //editLedgerEntry.SETRANGE(CreditLedgerEntry."Posting Date", Loans."Last Pay Date");
                    CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type"::"Principal Repayment");
                    CreditLedgerEntry.SetLoadFields("Credit Amount (LCY)");
                    IF CreditLedgerEntry.FindLast() THEN BEGIN
                        LastRepaymentPaid := CreditLedgerEntry."Credit Amount (LCY)";
                    END;
                    //last repaid int
                    CreditLedgerEntry.RESET;
                    CreditLedgerEntry.SETRANGE(CreditLedgerEntry."Loan No.", Loans."Loan No.");
                    CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
                    CreditLedgerEntry.SetLoadFields("Credit Amount (LCY)");
                    IF CreditLedgerEntry.FindLast() THEN BEGIN
                        LastIntPaid := CreditLedgerEntry."Credit Amount (LCY)";
                    END;

                    LastRepaidAmt := LastRepaymentPaid + LastIntPaid;
                    IF Loans."Repayment Start Date" > TODAY THEN
                        LastRepaidAmt := 0.0;
                end;
            }
            dataitem("Savings Accounts"; "Savings Accounts")
            {
                DataItemLink = "Member No." = FIELD("No.");
                DataItemTableView = WHERE("Product Category" = FILTER(<> "Share Capital" | "Deposit Contribution"));
                column(No_SavingsAccounts; "Savings Accounts"."No.")
                {
                }
                column(Name_SavingsAccounts; "Savings Accounts".Name)
                {
                }
                column(ProductName_SavingsAccounts; "Savings Accounts"."Product Name")
                {
                }
                column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
                {
                }
            }
            /*dataitem(DataItem34; Table39004390)
            {
                DataItemLink = Member No.=FIELD(No.);
                column(BondType_Bond; Bond."Bond Type")
                {
                }
                column(BeneficiaryNo_Bond; Bond."Beneficiary No.")
                {
                }
                column(BeneficiaryName_Bond; Bond."Beneficiary Name")
                {
                }
                column(ValidTo_Bond; Bond."Valid To")
                {
                }
                column(Purpose_Bond; Bond.Purpose)
                {
                }
                column(Amount_Bond; Bond.Amount)
                {
                }
                column(BondStatus_Bond; Bond."Bond Status")
                {
                }
                column(BondNo_Bond; Bond."Bond No.")
                {
                }
            }*/
            dataitem("Loan Security"; "Loan Security")
            {
            }

            trigger OnAfterGetRecord()
            var
                Info: Record "Information Base.";
            begin
                PendingApprovals := 0;
                ApprovedLoans := 0;
                TotalAdvice := 0;
                DepositContr := 0;
                MonthlyShareCap := 0;
                "LastAdvNo." := '';
                TotalDeposit := 0;
                TotalShareCap := 0;
                TotalArrears := 0;

                if Members.Remarks = '' then begin

                    Info.Reset();
                    Info.SetRange("Member No.", Members."No.");
                    Info.SetFilter(Info, '<>%1', '');
                    if Info.FindFirst() then
                        Members.Remarks := Info.Info;
                end;

                SaccoCategory.Reset();
                SaccoCategory.SetRange("Member No.", Members."No.");
                if SaccoCategory.FindFirst() then begin
                    SaccoCategory.CalcSums("Total Arrears");
                    TotalArrears := SaccoCategory."Total Arrears";
                end;
                //Pending loans
                Loans.RESET;
                Loans.SETRANGE("Member No.", Members."No.");
                Loans.SETRANGE(Status, Loans.Status::Pending);
                IF Loans.FIND('-') THEN BEGIN
                    Loans.CALCSUMS("Approved Amount");
                    PendingApprovals := Loans."Approved Amount";
                END;

                //Approved
                Loans.RESET;
                Loans.SETRANGE("Member No.", Members."No.");
                Loans.SETRANGE(Status, Loans.Status::Approved);
                Loans.SETRANGE(Posted, FALSE);
                IF Loans.FIND('-') THEN BEGIN
                    Loans.CALCSUMS("Approved Amount");
                    ApprovedLoans := Loans."Approved Amount";
                END;

                //Get last No.
                CheckOffAdvice.RESET;
                CheckOffAdvice.SETRANGE("Member No.", Members."No.");
                CheckOffAdvice.SETRANGE(Processed, TRUE);
                IF CheckOffAdvice.FindLast() THEN
                    "LastAdvNo." := CheckOffAdvice."Advice Header No.";

                //
                CheckOffAdvice.RESET;
                CheckOffAdvice.SETRANGE("Member No.", Members."No.");
                CheckOffAdvice.SETRANGE("Advice Header No.", "LastAdvNo.");
                CheckOffAdvice.SETRANGE(Processed, TRUE);
                IF CheckOffAdvice.FIND('-') THEN BEGIN
                    CheckOffAdvice.CALCSUMS("Amount On");
                    TotalAdvice := CheckOffAdvice."Amount On";
                END;

                //Deposits
                SavAcc.RESET;
                SavAcc.SETRANGE("Member No.", Members."No.");
                SavAcc.SETFILTER("Product Category", '%1|%2', SavAcc."Product Category"::"Deposit Contribution", SavAcc."Product Category"::"Micro Member Deposit");
                IF SavAcc.FIND('-') THEN BEGIN
                    repeat
                        DepositContr += SavAcc."Monthly Contribution";
                        SavAcc.CALCFIELDS("Balance (LCY)");
                        TotalDeposit += SavAcc."Balance (LCY)";
                    until SavAcc.Next() = 0;
                END;
                //Share capital
                SavAcc.RESET;
                SavAcc.SETRANGE("Member No.", Members."No.");
                SavAcc.SETRANGE("Product Category", SavAcc."Product Category"::"Share Capital");
                IF SavAcc.FIND('-') THEN BEGIN
                    MonthlyShareCap := SavAcc."Monthly Contribution";
                    SavAcc.CALCFIELDS("Balance (LCY)");
                    TotalShareCap := SavAcc."Balance (LCY)";
                END;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
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
        Info: Record "Information Base.";
        CompanyInfo: Record "Company Information";
        SaccoCategory: Record "SACCO Categorization";
        PendingApprovals: Decimal;
        DepositContr: Decimal;
        MonthlyShareCap: Decimal;
        ApprovedLoans: Decimal;
        TotalArrears: Decimal;
        TotalAdvice: Decimal;
        Loan: Record Loans;
        CheckOffAdvice: Record "Monthly Advice";
        "LastAdvNo.": Code[20];
        SavAcc: Record "Savings Accounts";
        TotalDeposit: Decimal;
        TotalShareCap: Decimal;
        RemainingPeriod: Integer;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LastRepaymentPaid: Decimal;
        LastIntPaid: Decimal;
        LastRepaidAmt: Decimal;
        SaccoActivities: Codeunit "Sacco Activities";
}


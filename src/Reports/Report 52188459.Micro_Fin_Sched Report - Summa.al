
Report 50122 "Micro_Fin_Sched Report - Summa"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Micro_Fin_Sched Report - Summa.rdlc';

    dataset
    {
        dataitem(Micro_Fin_Transactions; "Micro Credit Transactions")
        {
            column(ReportForNavId_19; 19)
            {
            }
            column(No_MicroFinTransactions; Micro_Fin_Transactions."No.")
            {
            }
            column(TransactionDate_MicroFinTransactions; Micro_Fin_Transactions."Transaction Date")
            {
            }
            column(TransactionTime_MicroFinTransactions; Micro_Fin_Transactions."Transaction Time")
            {
            }
            column(GroupCode_MicroFinTransactions; Micro_Fin_Transactions."Group Code")
            {
            }
            column(GroupName_MicroFinTransactions; Micro_Fin_Transactions."Group Name")
            {
            }
            column(DepositedBy_MicroFinTransactions; Micro_Fin_Transactions."Deposited By")
            {
            }
            column(Cashier_MicroFinTransactions; Micro_Fin_Transactions.Cashier)
            {
            }
            column(Amount_MicroFinTransactions; Micro_Fin_Transactions.Amount)
            {
            }
            column(PostedBy_MicroFinTransactions; Micro_Fin_Transactions."Posted By")
            {
            }
            dataitem(Micro_Fin_Schedule; "Micro Credit Transaction Lines")
            {
                DataItemLink = "No." = field("No.");
                column(ReportForNavId_1102755000; 1102755000)
                {
                }
                column(Account_No; Micro_Fin_Schedule."Account Number")
                {
                }
                column(Account_Name; Micro_Fin_Schedule."Account Name")
                {
                }
                column(Loan_No; Micro_Fin_Schedule."Loan No.")
                {
                }
                column(DepositPaid; DepositPaid)
                {
                }
                column(PenaltyPaid; PenaltyPaid)
                {
                }
                column(AppraisalPaid; AppraisalPaid)
                {
                }
                column(InterestPaid; InterestPaid)
                {
                }
                column(PrinciplePaid; PrinciplePaid)
                {
                }
                column(TotalPaid; TotalPaid)
                {
                }
                column(Expected_Principle; Micro_Fin_Schedule."Expected Principle Amount")
                {
                }
                column(Expected_Interest; Micro_Fin_Schedule."Expected Interest")
                {
                }
                column(Savings; Micro_Fin_Schedule.Savings)
                {
                }
                column(WithdrawableSavings_MicroFinSchedule; Micro_Fin_Schedule."Micro Savings")
                {
                }
                column(Loan_Balance; ToustLoan)
                {
                }
                column(Group_Name; GrpName)
                {
                }
                column(Group_Code; Micro_Fin_Schedule."Group Code")
                {
                }
                column(Company_Name; CompanyInfo.Name)
                {
                }
                column(Company_Picture; CompanyInfo.Picture)
                {
                }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(CurrReport_PAGENO; 0)
                {
                }
                column(UserId; UserId)
                {
                }
                column(SharesCapital_MicroFinSchedule; Micro_Fin_Schedule."Shares Capital")
                {
                }
                column(DepositSavings_MicroFinSchedule; Micro_Fin_Schedule."Deposit Savings")
                {
                }
                column(RegistrationFee_MicroFinSchedule; Micro_Fin_Schedule."Registration Fee")
                {
                }
                column(GroupName_MicroFinSchedule; Micro_Fin_Schedule."Group Name")
                {
                }
                column(Amount_MicroFinSchedule; Micro_Fin_Schedule.Amount)
                {
                }
                column(DateBanked_MicroFinSchedule; Micro_Fin_Schedule."Date Banked")
                {
                }
                column(BranchAgent_MicroFinSchedule; Micro_Fin_Schedule."Branch/Agent")
                {
                }
                column(No_MicroFinSchedule; Micro_Fin_Schedule."No.")
                {
                }
                column(DocumentDate_MicroFinSchedule; Micro_Fin_Schedule."Document Date")
                {
                }
                column(Interest_Amount; Micro_Fin_Schedule."Interest Amount Paid")
                {
                }
                column(Principle_Amount; Micro_Fin_Schedule."Principle Amount Paid")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    DepositPaid := 0;
                    SLedger.Reset;
                    SLedger.SetRange("Document No.", Micro_Fin_Schedule."No.");
                    SLedger.SetRange("Account No.", Micro_Fin_Schedule."Account Number");
                    if SLedger.FindFirst then begin
                        SLedger.CalcSums("Amount (LCY)");
                        DepositPaid := SLedger."Amount (LCY)" * -1;
                    end;


                    PenaltyPaid := 0;
                    CLedger.Reset;
                    CLedger.SetRange("Document No.", Micro_Fin_Schedule."No.");
                    CLedger.SetRange("Member No.", Micro_Fin_Schedule."Member No.");
                    CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Penalty Paid");
                    if CLedger.FindFirst then begin
                        CLedger.CalcSums("Amount (LCY)");
                        PenaltyPaid := CLedger."Amount (LCY)" * -1;
                    end;

                    AppraisalPaid := 0;
                    CLedger.Reset;
                    CLedger.SetRange("Document No.", Micro_Fin_Schedule."No.");
                    CLedger.SetRange("Member No.", Micro_Fin_Schedule."Member No.");
                    CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Appraisal Paid");
                    if CLedger.FindFirst then begin
                        CLedger.CalcSums("Amount (LCY)");
                        AppraisalPaid := CLedger."Amount (LCY)" * -1;
                    end;

                    InterestPaid := 0;
                    CLedger.Reset;
                    CLedger.SetRange("Document No.", Micro_Fin_Schedule."No.");
                    CLedger.SetRange("Member No.", Micro_Fin_Schedule."Member No.");
                    CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Interest Paid");
                    if CLedger.FindFirst then begin
                        CLedger.CalcSums("Amount (LCY)");
                        InterestPaid := CLedger."Amount (LCY)" * -1;
                    end;


                    PrinciplePaid := 0;
                    CLedger.Reset;
                    CLedger.SetRange("Document No.", Micro_Fin_Schedule."No.");
                    CLedger.SetRange("Member No.", Micro_Fin_Schedule."Member No.");
                    CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Principal Repayment");
                    if CLedger.FindFirst then begin
                        CLedger.CalcSums("Amount (LCY)");
                        PrinciplePaid := CLedger."Amount (LCY)" * -1;
                    end;

                    TotalPaid := PenaltyPaid + AppraisalPaid + InterestPaid + PrinciplePaid;

                    // GroupMembers.RESET;
                    // GroupMembers.SETRANGE(GroupMembers."Group Code","Group Code");
                    // IF GroupMembers.FIND('-') THEN BEGIN
                    //
                    // GroupMembers.CALCFIELDS(GroupMembers."Balance (LCY)");
                    // SAVINGS2:=GroupMembers."Balance (LCY)";
                    //
                    // END;
                    //
                    //
                    // "Outstanding Loan" :=0;
                    // ToustLoan :=0;
                    //
                    // vend.RESET;
                    // vend.SETRANGE(vend."No.",Micro_Fin_Schedule."Account Number");
                    // IF vend.FIND('-') THEN BEGIN
                    //
                    // IF vend.Blocked=vend.Blocked::All THEN BEGIN
                    // CurrReport.SKIP;
                    // END;
                    //
                    // vend.CALCFIELDS(vend."Balance (LCY)");
                    // Saving:=vend."Balance (LCY)";
                    // Tsavings:=Tsavings+Saving;
                    // END;
                    //
                    //
                    // LoanApplic.RESET;
                    // LoanApplic.SETRANGE(LoanApplic."Client Code",Micro_Fin_Schedule."Account Number");
                    // LoanApplic.SETRANGE(LoanApplic.Source,LoanApplic.Source::MICRO);
                    // IF LoanApplic.FIND('-') THEN BEGIN
                    // REPEAT
                    // LoanApplic.CALCFIELDS(LoanApplic."Outstanding Balance",LoanApplic."Oustanding Interest");
                    // IF LoanApplic."Outstanding Balance"<> 0 THEN BEGIN
                    // "Outstanding Loan":=LoanApplic."Outstanding Balance";//+LoanApplic."Oustanding Interest";
                    // ToustLoan:=ToustLoan+"Outstanding Loan";
                    // END;
                    // UNTIL LoanApplic.NEXT =0;
                    // END;
                    // Tsaving:=Tsaving+Saving;
                    //
                    //
                    //
                    //Get group name
                    Grps.Reset;
                    if Grps.Get(Micro_Fin_Schedule."Group Code") then begin
                        GrpName := Grps.Name;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("No.");

                    CompanyInfo.Get();
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
                end;
            }
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        "Outstanding Loan": Decimal;
        Saving: Decimal;
        LoanApplic: Record Loans;
        Tsaving: Decimal;
        ToustLoan: Decimal;
        Tsavings: Decimal;
        GrpName: Text[100];
        Grps: Record Customer;
        Loans: Record Loans;
        Outbal: Decimal;
        OutInt: Decimal;
        MicroSubform: Record "Micro Credit Transactions";
        GroupMembers: Record Members;
        SAVINGS2: Decimal;
        CompanyInfo: Record "Company Information";
        Micro_Trans: Record "Micro Credit Transactions";
        SLedger: Record "Savings Ledger Entry";
        CLedger: Record "Credit Ledger Entry";
        DepositPaid: Decimal;
        PenaltyPaid: Decimal;
        AppraisalPaid: Decimal;
        InterestPaid: Decimal;
        PrinciplePaid: Decimal;
        TotalPaid: Decimal;
}


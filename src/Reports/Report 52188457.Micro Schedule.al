
Report 50120 "Micro Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Micro Schedule.rdlc';

    dataset
    {
        dataitem(Micro_Fin_Schedule; "Micro Credit Transaction Lines")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(OutstandingInterest_MicroFinSchedule; Micro_Fin_Schedule."Outstanding Interest")
            {
            }
            column(OutstandingAppraisal_MicroFinSchedule; Micro_Fin_Schedule."Outstanding Appraisal")
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
            column(DepositSavings_MicroFinSchedule; Micro_Fin_Schedule.Savings)
            {
            }
            column(ExpectedDeposits_MicroFinSchedule; Micro_Fin_Schedule."Expected Deposits")
            {
            }
            column(Loan_Balance; Micro_Fin_Schedule."Outstanding Balance")
            {
            }
            column(ExpectedPenalty_MicroFinSchedule; Micro_Fin_Schedule."Expected Penalty")
            {
            }
            column(ExpectedAppraisalFee_MicroFinSchedule; Micro_Fin_Schedule."Expected Appraisal Fee")
            {
            }
            column(Expected_Interest; Micro_Fin_Schedule."Expected Interest")
            {
            }
            column(Expected_Principle; Micro_Fin_Schedule."Expected Principle Amount")
            {
            }
            column(TotalLoanAmount; TotalLoanAmount)
            {
            }
            column(TotalExpected; TotalLoanAmount + Micro_Fin_Schedule."Expected Deposits")
            {
            }
            column(Savings; Micro_Fin_Schedule.Savings)
            {
            }
            column(WithdrawableSavings_MicroFinSchedule; Micro_Fin_Schedule."Micro Savings")
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

                TotalLoanAmount := Micro_Fin_Schedule."Expected Penalty" + Micro_Fin_Schedule."Expected Appraisal Fee" + Micro_Fin_Schedule."Expected Interest" + Micro_Fin_Schedule."Expected Principle Amount";

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
        Tsaving: Decimal;
        ToustLoan: Decimal;
        Tsavings: Decimal;
        GrpName: Text[100];
        Grps: Record Customer;
        Outbal: Decimal;
        OutInt: Decimal;
        SAVINGS2: Decimal;
        CompanyInfo: Record "Company Information";
        TotalLoanAmount: Decimal;
}


report 50389 "Member Statement Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Member Statement Summary.rdlc';

    /*   
    dataset
       {


            dataitem(Members; Members)
            {
                column(CompanyName; CompanyInfo.Name)
                {
                }
                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                column(StartDate; StartDate)
                {
                }
                column(EndDate; EndDate)
                {
                }
                column(No_Members; Members."No.")
                {
                }
                column(Name_Members; Members.Name)
                {
                }
                column(IDPassportNo_Members; Members."ID No.")
                {
                }
                column(LoanProvBal; LoanProvBal)
                {
                }
                column(M_no; Members."No.")
                {
                }
                column(MAddress; Members.Address)
                {
                }
                column(Account; Members."Employer Code")
                {
                }
                column(DOB; Members."Date of Birth")
                {
                }
                column(MName; Members.Name)
                {
                }
                column(M_Email; Members."E-Mail")
                {
                }
                column(MID; Members.Passport)
                {
                }
                column(UserName; UserName)
                {
                }
                column(MPhone; Members."Mobile Phone No.")
                {
                }
                column(DepLoanRatio; DepLoanRatio)
                {
                }
                column(DepGuarRatio; DepGuarRatio)
                {
                }
                column(MonthlyRep; MonthlyRep)
                {
                }
                column(TArrears; TArrears)
                {
                }
                column(Black; Black)
                {
                }
                column(Status_Members; Members.Status)
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
                {
                }
                column(CompanyInformation_Picture; CompanyInformation.Picture)
                {
                }
                column(CompanyAddress; CompanyAddress)
                {
                }
                column(CompanyTelephone; CompanyTelephone)
                {
                }
                column(CommunicationOnline; CommunicationOnline)
                {
                }
                column(Web; Web)
                {
                }
                column(PeriodFilter; PeriodFilter)
                {
                }
                column(WorkingDate_Member; FORMAT(TODAY, 0, 4))
                {
                }
                column(sHARES_Member; "Retained Shares")
                {
                }
                column(Bbf_Member; Bbf)
                {
                }
                column(InstantLoan_Member; InstantLoan)
                {
                }
                column(FosaLoan_Member; FosaLoan)
                {
                }
                column(Jiajiri; Jiajiri)
                {
                }
                column(TOutInt; TOutInt)
                {
                }
                column(MCash; MCash)
                {
                }
                column(SecAmt; SecAmt)
                {
                }
                column(MembrEligibility; MembrEligibility)
                {
                }
                column(CurrentShares_Members; Members."Current Shares")
                {
                }
                column(TotalNormalLoans; TotalNormalLoans)
                {
                }
                column(TotalMobileLoans; TotalMobileLoans)
                {
                }
                column(TotalLoansBalance; TotalLoansBalance)
                {
                }
                dataitem(DataItem60; Table23)
                {
                    DataItemLink = Member No.=FIELD(No.);
                    column(AccountType_Vendor; AccName)
                    {
                    }
                    column(FosaBal; FosaBal)
                    {
                    }
                    column(Child; Child)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Child := '';
                        IF Vendor."Account Type" = 'JUNIOR' THEN
                            Child := Name;
                        FosaBal := Msacco.AccountBalance(Vendor."No.");

                        AccTypes.GET(Vendor."Account Type");
                        AccName := AccTypes.Description;
                    end;
                }
                dataitem(DataItem11; Table39004241)
                {
                    CalcFields = Outstanding Balance;
                    DataItemLink = Member No.=FIELD(No.);
                    DataItemTableView = WHERE(Posted = CONST(Yes));
                    column(LoanNo_Loans; Loans."Loan No.")
                    {
                    }
                    column(ProductType_Loans; Loans."Product Type")
                    {
                    }
                    column(IssuedDate_Loans; Loans."Issued Date")
                    {
                    }
                    column(Installments_Loans; Loans.Installments)
                    {
                    }
                    column(LoanArrears; LoanArrears)
                    {
                    }
                    column(Repayment_Loans; Loans.Repayment)
                    {
                    }
                    column(IsMobileLoan; IsMobileLoan)
                    {
                    }
                    column(RepaymentStartDate_Loans; Loans."Repayment Start Date")
                    {
                    }
                    column(ApprovedAmount_Loans; Loans."Approved Amount")
                    {
                    }
                    column(TheLoanBalance; TheLoanBalance)
                    {
                    }
                    dataitem(LoanDate; Table2000000007)
                    {
                        DataItemTableView = WHERE(Period Type=CONST(Month));
                        column(PeriodName_LoanDate; PeriodName)
                        {
                        }
                        column(LoanOpeningBalance; LoanOpeningBalance)
                        {
                        }
                        column(PrincipalRepayment; PrincipalRepayment)
                        {
                        }
                        column(InterestDue; InterestDue)
                        {
                        }
                        column(InterestPaid; InterestPaid)
                        {
                        }
                        column(PenaltyCharged; PenaltyCharged)
                        {
                        }
                        column(TotalReceipts; TotalReceipts)
                        {
                        }
                        column(LoanClosingBalance; LoanClosingBalance)
                        {
                        }
                        column(LoanDateLoanNo; LoanDateLoanNo)
                        {
                        }
                        column(RollOverFee; RollOverFee)
                        {
                        }
                        column(LoanProductType; LoanProductType)
                        {
                        }
                        column(TotalLoanBalance; TotalLoanBalance)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Loan: Record "39004241";
                            LoansProcessII: Codeunit "39004246";
                            LoanType: Record "39004240";
                        begin
                            LoanOpeningBalance := 0;
                            PrincipalRepayment := 0;
                            InterestDue := 0;
                            InterestPaid := 0;
                            PenaltyCharged := 0;
                            TotalReceipts := 0;
                            LoanClosingBalance := 0;
                            LoanDateLoanNo := '';
                            PeriodName := '';
                            RollOverFee := 0;
                            TotalLoanBalance := 0;

                            PeriodName := LoanDate."Period Name" + ' ' + FORMAT(DATE2DMY(LoanDate."Period Start", 3));

                            Loan.RESET;
                            Loan.SETRANGE("Loan No.", Loans."Loan No.");
                            Loan.SETFILTER("Date Filter", '..%1', LoanDate."Period Start" - 1);
                            Loan.SETAUTOCALCFIELDS("Outstanding Principal");
                            IF Loan.FINDFIRST THEN
                                LoanOpeningBalance := Loan."Outstanding Principal";

                            LoanDateLoanNo := Loans."Loan No.";
                            LoanProductType := Loans."Product Type";

                            Loan.RESET;
                            Loan.SETRANGE("Loan No.", Loans."Loan No.");
                            Loan.SETRANGE("Date Filter", LoanDate."Period Start", LoanDate."Period End");
                            Loan.SETAUTOCALCFIELDS("Loan Repayment", "Interest Due", "Interest Paid");
                            IF Loan.FINDFIRST THEN BEGIN
                                PrincipalRepayment := Loan."Loan Repayment";
                                InterestDue := Loan."Interest Due";
                                InterestPaid := Loan."Interest Paid";
                                // PenaltyCharged := Loan."Loan Penalty";
                                TotalReceipts := InterestPaid + PrincipalRepayment;
                            END;


                            Loan.RESET;
                            Loan.SETRANGE("Loan No.", Loans."Loan No.");
                            Loan.SETFILTER("Date Filter", '..%1', LoanDate."Period End");
                            Loan.SETAUTOCALCFIELDS("Outstanding Principal");
                            IF Loan.FINDFIRST THEN
                                LoanClosingBalance := Loan."Outstanding Principal";

                            IF NOT IsMobileLoan THEN BEGIN
                                IF CALCDATE('CM', LoanDate."Period Start") <> CALCDATE('CM', TODAY) THEN BEGIN
                                    LoansProcessII.GetDefaulter(Loans, CALCDATE('CM', LoanDate."Period Start"), LoanArrear, MonthArrear);
                                    LoanType.GET(Loans."Product Type");
                                    PenaltyCharged := LoanArrear * LoanType."Penalty Percentage" * 0.01;
                                END;
                            END;

                            TotalLoanBalance := LoanClosingBalance + (InterestDue - InterestPaid);

                            IF IsMobileLoan THEN BEGIN
                                // MCASH Rollover
                                RollOverFee := GetDebitByDescription(Members."No.", Loans."Loan No.", MemLed."Transaction Type"::"Interest Due", 'MCASH Rollover*', LoanDate."Period Start", LoanDate."Period End");

                                PenaltyCharged := GetDebitByDescription(Members."No.", Loans."Loan No.", MemLed."Transaction Type"::"Interest Due", '*Penalty*', LoanDate."Period Start", LoanDate."Period End");

                            END;



                            IF (LoanOpeningBalance + PrincipalRepayment + InterestDue + InterestPaid + PenaltyCharged + RollOverFee + TotalReceipts + LoanClosingBalance) = 0 THEN
                                CurrReport.SKIP;
                        end;

                        trigger OnPreDataItem()
                        begin
                            LoanDate.SETRANGE("Period Start", StartDate, EndDate);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        CLedger: Record "39004416";
                        LoanBalance: Record "39004241";
                    begin

                        LoanType.RESET;
                        LoanType.SETRANGE(Code, Loans."Product Type");
                        LoanType.SETRANGE("Mobile Loans", TRUE);
                        IsMobileLoan := LoanType.FINDFIRST;


                        IF Loans."Outstanding Principal" <= 0 THEN BEGIN
                            CLedger.RESET;
                            CLedger.SETRANGE("Loan No", Loans."Loan No.");
                            CLedger.SETRANGE(Reversed, FALSE);
                            CLedger.SETRANGE("Posting Date", StartDate, EndDate);
                            IF NOT CLedger.FINDFIRST THEN CurrReport.SKIP;
                        END;
                        LoanArrears := 0;
                        PenaltyCharged := 0;

                        IF SASRACategorization.GET(Loans."Loan No.") THEN BEGIN
                            IF SASRACategorization."Principal Arrears" > Loans."Outstanding Principal" THEN
                                SASRACategorization."Principal Arrears" := Loans."Outstanding Principal";

                            LoanArrears := SASRACategorization."Principal Arrears";
                            //PenaltyCharged := LoanType."Penalty Percentage"*LoanArrears*0.01;
                        END;


                        LoanBalance.RESET;
                        LoanBalance.SETRANGE("Loan No.", Loans."Loan No.");
                        LoanBalance.SETFILTER("Date Filter", '..%1', EndDate);
                        LoanBalance.SETAUTOCALCFIELDS("Outstanding Principal", "Interest Due", "Interest Paid");
                        IF LoanBalance.FINDFIRST THEN
                            TheLoanBalance := (LoanBalance."Outstanding Principal" + LoanBalance."Interest Due") - LoanBalance."Interest Paid";
                    end;

                    trigger OnPostDataItem()
                    var
                        Loan: Record "39004241";
                    begin
                    end;

                    trigger OnPreDataItem()
                    begin
                        Loans.SETFILTER("Date Filter", '..%1', EndDate);
                    end;
                }
                dataitem(DataItem26; Table2000000026)
                {
                    DataItemTableView = WHERE(Number = CONST(1));
                    dataitem(SavingDate; Table2000000007)
                    {
                        DataItemTableView = WHERE(Period Type=CONST(Month));
                        column(SavingPeriodName; SavingPeriodName)
                        {
                        }
                        column(ShareDepositOpeningBalance; ShareDepositOpeningBalance)
                        {
                        }
                        column(ShareDepositContribution; ShareDepositContribution)
                        {
                        }
                        column(ShareDepositRecoveryToBenevolent; ShareDepositRecoveryToBenevolent)
                        {
                        }
                        column(ShareDepositRecoveryToOwnLoan; ShareDepositRecoveryToOwnLoan)
                        {
                        }
                        column(ShareDepositRecoveryToGuarantors; ShareDepositRecoveryToGuarantors)
                        {
                        }
                        column(ShareDepositClosingBalance; ShareDepositClosingBalance)
                        {
                        }
                        column(ShareDepositRecoveryToShareCapital; ShareDepositRecoveryToShareCapital)
                        {
                        }
                        column(OtherShareDepositRecoveries; OtherShareDepositRecoveries)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Member: Record "39004418";
                            DateFilter: Text;
                        begin
                            SavingPeriodName := SavingDate."Period Name" + ' ' + FORMAT(DATE2DMY(SavingDate."Period Start", 3));
                            ShareDepositOpeningBalance := 0;
                            ShareDepositContribution := 0;
                            ShareDepositRecoveryToBenevolent := 0;
                            ShareDepositRecoveryToOwnLoan := 0;
                            ShareDepositRecoveryToGuarantors := 0;
                            ShareDepositRecoveryToShareCapital := 0;
                            ShareDepositClosingBalance := 0;
                            DateFilter := FORMAT(SavingDate."Period Start") + '..' + FORMAT(SavingDate."Period End");


                            Member.RESET;
                            Member.SETRANGE("No.", Members."No.");
                            Member.SETFILTER("Date Filter", '..%1', SavingDate."Period Start" - 1);
                            Member.SETAUTOCALCFIELDS("Current Shares");
                            IF Member.FINDFIRST THEN
                                ShareDepositOpeningBalance := Member."Current Shares";

                            Member.RESET;
                            Member.SETRANGE("No.", Members."No.");
                            Member.SETFILTER("Date Filter", '..%1', SavingDate."Period End");
                            Member.SETAUTOCALCFIELDS("Current Shares");
                            IF Member.FINDFIRST THEN
                                ShareDepositClosingBalance := Member."Current Shares";

                            /*Member.RESET;
                            Member.SETRANGE("No.",Members."No.");
                            Member.SETFILTER("Date Filter",'%1..%2',SavingDate."Period Start",SavingDate."Period End");
                            Member.SETAUTOCALCFIELDS("Current Shares");
                            IF Member.FINDFIRST THEN
                              ShareDepositContribution:=Member."Current Shares";*/

    /*ShareDepositContribution := GetCreditByPeriod(Members."No.", MemLed."Transaction Type"::"Deposit Contribution", DateFilter);

    ShareDepositRecoveryToBenevolent := GetDebitByDocumentNo(Members."No.", MemLed."Transaction Type"::"Deposit Contribution", 'DB-*', DateFilter);
    ShareDepositRecoveryToShareCapital := GetDebitByDocumentNo(Members."No.", MemLed."Transaction Type"::"Deposit Contribution", 'DS-*', DateFilter);
    ShareDepositRecoveryToGuarantors := GetDebitByDocumentNo(Members."No.", MemLed."Transaction Type"::"Deposit Contribution", 'GL-*', DateFilter);
    ShareDepositRecoveryToOwnLoan := GetDebitByDocumentNo(Members."No.", MemLed."Transaction Type"::"Deposit Contribution", 'LR-*', DateFilter);
    OtherShareDepositRecoveries := GetDebitByDocumentNo(Members."No.", MemLed."Transaction Type"::"Deposit Contribution", '<>LR-*&<>GL-*&<>DS-*&<>DB-*', DateFilter);

end;

trigger OnPreDataItem()
begin
    SavingDate.SETRANGE("Period Start", StartDate, EndDate);

    // SHARE DEPOSIT OPENING BALANCESHARE DEPOSIT CONTRIBUTIONSHARE DEPOSIT RECOVERY TO BENOVELENTSHARE DEPOSIT RECOVERY TO OWN LOAN
    //SHARE DEPOSIT RECOVERY TO GUARANTORSSHARE DEPOSIT RECOVERY TO SHARE CAPITALSHARE DEPOSIT CLOSING BALANCE
end;
}
}
dataitem(BenInt; Table2000000026)
{
DataItemTableView = WHERE(Number = CONST(1));
dataitem(BenDate; Table2000000007)
{
DataItemTableView = WHERE(Period Type=CONST(Month));
column(BenPeriodName; BenPeriodName)
{
}
column(BenOpeningBalance; BenOpeningBalance)
{
}
column(BenContribution; BenContribution)
{
}
column(BenClosingBalance; BenClosingBalance)
{
}

trigger OnAfterGetRecord()
var
    Member: Record "39004418";
    DateFilter: Text;
begin
    BenPeriodName := BenDate."Period Name" + ' ' + FORMAT(DATE2DMY(BenDate."Period Start", 3));
    BenOpeningBalance := 0;
    BenContribution := 0;
    BenClosingBalance := 0;

    DateFilter := FORMAT(BenDate."Period Start") + '..' + FORMAT(BenDate."Period End");


    Member.RESET;
    Member.SETRANGE("No.", Members."No.");
    Member.SETFILTER("Date Filter", '..%1', BenDate."Period Start" - 1);
    Member.SETAUTOCALCFIELDS("Benevolent Fund");
    IF Member.FINDFIRST THEN
        BenOpeningBalance := Member."Benevolent Fund";

    Member.RESET;
    Member.SETRANGE("No.", Members."No.");
    Member.SETFILTER("Date Filter", '..%1', BenDate."Period End");
    Member.SETAUTOCALCFIELDS("Benevolent Fund");
    IF Member.FINDFIRST THEN
        BenClosingBalance := Member."Benevolent Fund";

    BenContribution := GetCreditByPeriod(Members."No.", MemLed."Transaction Type"::"Benevolent Fund", DateFilter);
end;

trigger OnPreDataItem()
begin
    BenDate.SETRANGE("Period Start", StartDate, EndDate);
end;
}
}
dataitem(SCapInt; Table2000000026)
{
DataItemTableView = WHERE(Number = CONST(1));
dataitem(ScapDate; Table2000000007)
{
DataItemTableView = WHERE(Period Type=CONST(Month));
column(ScapPeriodName; ScapPeriodName)
{
}
column(SCapOpeningBalance; SCapOpeningBalance)
{
}
column(SCapContribution; SCapContribution)
{
}
column(ScapClosingBalance; ScapClosingBalance)
{
}

trigger OnAfterGetRecord()
var
    DateFilter: Text;
begin

    ScapPeriodName := ScapDate."Period Name" + ' ' + FORMAT(DATE2DMY(ScapDate."Period Start", 3));

    SCapOpeningBalance := 0;
    SCapContribution := 0;
    ScapClosingBalance := 0;

    DateFilter := FORMAT(ScapDate."Period Start") + '..' + FORMAT(ScapDate."Period End");


    Member.RESET;
    Member.SETRANGE("No.", Members."No.");
    Member.SETFILTER("Date Filter", '..%1', ScapDate."Period Start" - 1);
    Member.SETAUTOCALCFIELDS("Retained Shares");
    IF Member.FINDFIRST THEN
        SCapOpeningBalance := Member."Retained Shares";

    Member.RESET;
    Member.SETRANGE("No.", Members."No.");
    Member.SETFILTER("Date Filter", '..%1', SavingDate."Period End");
    Member.SETAUTOCALCFIELDS("Retained Shares");
    IF Member.FINDFIRST THEN
        ScapClosingBalance := Member."Retained Shares";


    SCapContribution := GetCreditByPeriod(Members."No.", MemLed."Transaction Type"::"Shares Capital", DateFilter);
end;

trigger OnPreDataItem()
begin
    ScapDate.SETRANGE("Period Start", StartDate, EndDate);
end;
}
}

trigger OnAfterGetRecord()
var
OutInterest: Decimal;
begin
IF Members."Mobile Phone No." = '' THEN
Members."Mobile Phone No." := Members."Phone No.";

Bbf := 0;

Cust.RESET;
Cust.SETRANGE("No.", Members."No.");
Cust.SETFILTER("Date Filter", '%1..%2', CALCDATE('-CY', TODAY), CALCDATE('CY', TODAY));
Cust.SETAUTOCALCFIELDS("Benevolent Fund");
IF Cust.FINDFIRST THEN
Bbf := Cust."Benevolent Fund";

SecAmt := 0;
SecuritiesRegister.RESET;
SecuritiesRegister.SETRANGE("Account No.", Members."No.");
SecuritiesRegister.SETRANGE(Status, SecuritiesRegister.Status::Approved);
IF SecuritiesRegister.FINDFIRST THEN BEGIN
REPEAT
    SecAmt += SecuritiesRegister."Charged Value";
UNTIL SecuritiesRegister.NEXT = 0;
END;

//MESSAGE('%1',SecAmt);


LoanProvBal := 0;
LoanApps.RESET;
LoanApps.SETRANGE("Member No.", Members."No.");
LoanApps.SETFILTER("Outstanding Principal", '>0');
IF LoanApps.FINDFIRST THEN BEGIN
REPEAT
    LoanApps.CALCFIELDS("Loan Provisioning Balance");
    LoanProvBal := LoanApps."Loan Provisioning Balance";
UNTIL LoanApps.NEXT = 0;
END;

TOutInt := 0;
LoanApps.RESET;
LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
LoanApps.SETFILTER("Outstanding Interest", '>0');
IF LoanApps.FIND('-') THEN BEGIN
REPEAT
    LoanApps.CALCFIELDS(LoanApps."Outstanding Interest");
    TOutInt += LoanApps."Outstanding Interest";

UNTIL LoanApps.NEXT = 0;
END;

Black := 'No';
IF Members."Mobile Loan Blacklisted" THEN
Black := 'Yes';

IF StartDate = 0D THEN BEGIN
StartDate := CALCDATE('-11M -CM', TODAY);
EndDate := CALCDATE('CM', StartDate);
END;

DivProg.RESET;

DivProg.SETRANGE(DivProg."Member No", "No.");
IF DivProg.FIND('-') THEN
DivProg.DELETEALL;

CDiv := 0;
GenSetUp.GET(0);


FOR i := 1 TO Months DO BEGIN



FromDate := CALCDATE('-CM', StartDate);
ToDate := CALCDATE('CM', StartDate);



EVALUATE(FromDateS, FORMAT(FromDate));
EVALUATE(ToDateS, FORMAT(ToDate));
DateFilter := FromDateS + '..' + ToDateS;

Cust.RESET;
Cust.SETRANGE(Cust."No.", "No.");
Cust.SETFILTER(Cust."Date Filter", DateFilter);
IF Cust.FIND('-') THEN BEGIN

    Cust.CALCFIELDS(Cust."Current Shares", Cust."Current Loan", "Benevolent Fund", "Retained Shares");
    Benevolent := Cust."Benevolent Fund";
    ShCap := Cust."Retained Shares";


    DivProg.INIT;
    DivProg."Member No" := "No.";
    DivProg.Date := ToDate;
    //Monthly Loan issued & Deposit Contribution
    DivProg."Deposit Contribution" := Cust."Current Shares";
    LoanApps.RESET;
    LoanApps.SETRANGE(LoanApps."Member No.", "No.");
    LoanApps.SETFILTER(LoanApps.Posted, 'YES');
    LoanApps.SETFILTER(LoanApps."Issued Date", DateFilter);
    IF LoanApps.FIND('-') THEN BEGIN
        REPEAT
            LoanApps.CALCFIELDS(LoanApps."Outstanding Principal", LoanApps."Loan Repayment", LoanApps."Interest Paid", LoanApps."Interest Due",
                                                                                                  LoanApps."Outstanding Interest");
            //**IF (LoanApps."Product Type"<>'INST') AND (LoanApps."Product Type"<>'FLP') THEN
            IF LoanApps."Disbursement Method" = LoanApps."Disbursement Method"::"Partial Disbursement" THEN
                DivProg."New Loans" += LoanApps."Amount To Disburse"
            ELSE
                DivProg."New Loans" += LoanApps."Approved Amount";
        UNTIL LoanApps.NEXT = 0;
    END;

    Partial.RESET;
    Partial.SETRANGE(Partial."Member No.", Cust."No.");
    Partial.SETFILTER(Partial.Posted, 'YES');
    Partial.SETFILTER(Partial."Issued Date", DateFilter);
    IF Partial.FIND('-') THEN BEGIN
        REPEAT
            DivProg."New Loans" += Partial."Amount to Disburse"
        UNTIL Partial.NEXT = 0;
    END;

    //Montly repayment on loan Principle less INST & FLP Loan
    LoanApps.RESET;
    LoanApps.SETRANGE(LoanApps."Member No.", Cust."No.");
    LoanApps.SETRANGE(Posted, TRUE);
    LoanApps.SETFILTER(LoanApps."Date Filter", DateFilter);
    IF LoanApps.FIND('-') THEN BEGIN
        REPEAT
            LoanApps.CALCFIELDS(LoanApps."Outstanding Principal", LoanApps."Loan Repayment", LoanApps."Interest Paid", LoanApps."Interest Due",
                                                                                                          LoanApps."Outstanding Interest");

            Penalty1 := GetBalance(LoanApps."Loan No.", TransType::Penalty, DateFilter);
            Penalty2 := GetIrregularPenalty(LoanApps."Loan No.", DateFilter);
            //**IF (LoanApps."Product Type"<>'INST') AND (LoanApps."Product Type"<>'FLP') THEN
            DivProg.Repayment += LoanApps."Loan Repayment";
            DivProg."Interest Paid" += LoanApps."Interest Paid";
            DivProg."Interest Due" += LoanApps."Interest Due";//+Penalty1+Penalty2;
            DivProg."Oustanding Interest" += LoanApps."Outstanding Interest";
        //TOutInt+=LoanApps."Outstanding Interest";

        UNTIL LoanApps.NEXT = 0;
    END;
    //Opening Balance Deposits

    //PN
    DateFilter := '..' + FORMAT(CALCDATE('-1D', FromDate));

    CustR.RESET;
    CustR.SETRANGE(CustR."No.", Cust."No.");
    CustR.SETFILTER(CustR."Date Filter", DateFilter);
    IF CustR.FIND('-') THEN BEGIN
        CustR.CALCFIELDS(CustR."Current Loan", CustR."Current Shares");
        DivProg."Deposit Opening Balance" := CustR."Current Shares";
    END;

    //Loan Balance less INST & FLP Loan
    PenaltyOnly := 0;
    LoanApps.RESET;
    LoanApps.SETRANGE(LoanApps."Member No.", Cust."No.");
    LoanApps.SETRANGE(Posted, TRUE);
    LoanApps.SETFILTER(LoanApps."Date Filter", DateFilter);
    IF LoanApps.FIND('-') THEN BEGIN
        REPEAT

            LoanApps.CALCFIELDS(LoanApps."Outstanding Principal", "Outstanding Interest");
            Penalty1 := GetBalance(LoanApps."Loan No.", TransType::Penalty, DateFilter);
            PenaltyOnly += Penalty1;
            //**IF (LoanApps."Product Type"<>'INST') AND (LoanApps."Product Type"<>'FLP') THEN
            DivProg."Opening Balance" := DivProg."Opening Balance" + LoanApps."Outstanding Principal" + LoanApps."Outstanding Interest";

        UNTIL LoanApps.NEXT = 0;
    END;

    DivProg."Oustanding Loan" := DivProg."Opening Balance" + DivProg."New Loans" - DivProg.Repayment + DivProg."Interest Due" - DivProg."Interest Paid";
    DivProg."Closing Deposits" := DivProg."Deposit Opening Balance" + DivProg."Deposit Contribution";
    DivProg."Month Contribution" := DivProg.Repayment + DivProg."Interest Paid" + DivProg."Deposit Contribution";
    DivProg."Total Contribution" := DivProg."Month Contribution" + Benevolent + ShCap;
    DivProg.INSERT;
END;

StartDate := CALCDATE('1M', StartDate);

END;



DepLoanRatio := 0;
DepGuarRatio := 0;
CustR.RESET;
CustR.SETRANGE(CustR."No.", Members."No.");
IF CustR.FIND('-') THEN BEGIN
CustR.CALCFIELDS(CustR."Current Loan", CustR."Current Shares");


MonthlyRep := 0;
LBal := 0;
TArrears := 0;

LoanApps.RESET;
LoanApps.SETRANGE(LoanApps."Member No.", Members."No.");
//LoanApps.SETFILTER(LoanApps."Product Type",'<>INST&<>MCASH');
LoanApps.SETFILTER("Outstanding Principal", '>0');
IF LoanApps.FIND('-') THEN BEGIN

    LBal := 0;
    REPEAT
        LoanApps.CALCFIELDS(LoanApps."Outstanding Principal");
        LBal += LoanApps."Outstanding Principal";

        IF LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::Amortised THEN
            MonthlyRep += LoanApps.Repayment
        ELSE
            MonthlyRep += LoanApps."Loan Principle Repayment" + ROUND(LoanApps."Outstanding Principal" * LoanApps."Annual Interest %" / 1200);

        IF SASRACategorization.GET(LoanApps."Loan No.") THEN BEGIN
            IF SASRACategorization."Principal Arrears" > LoanApps."Outstanding Principal" THEN
                SASRACategorization."Principal Arrears" := LoanApps."Outstanding Principal";

            TArrears += SASRACategorization."Principal Arrears";
        END;
    UNTIL LoanApps.NEXT = 0;
END;

MonthlyRep += (GenSetUp."Min. Contribution [Deposits]" + GenSetUp."Insurance Retension");

DepLoanRatio := LBal;

IF CustR."Current Shares" > 0 THEN
    DepLoanRatio := ROUND(LBal / (CustR."Current Shares"));

DepGuarRatio := 0;
GuaranteeValue := 0;
LoanGuarantorsandSecurity.RESET;
LoanGuarantorsandSecurity.SETRANGE("Account No.", Members."No.");
IF LoanGuarantorsandSecurity.FIND('-') THEN BEGIN
    REPEAT
        LoanApps.GET(LoanGuarantorsandSecurity."Loan No.");
        LoanApps.CALCFIELDS("Outstanding Principal", "Total Guaranteed");
        //IF LoanApps."Member No."<>Members."No." THEN
        IF LoanApps."Outstanding Principal" > 0 THEN BEGIN
            IF LoanApps."Total Guaranteed" > 0 THEN
                GuaranteeValue += ((LoanGuarantorsandSecurity."Amount Guaranteed" / LoanApps."Total Guaranteed") * LoanApps."Outstanding Principal");

        END;
    UNTIL LoanGuarantorsandSecurity.NEXT = 0;
END;

DepGuarRatio := GuaranteeValue;
IF CustR."Current Shares" > 0 THEN
    DepGuarRatio := ROUND(GuaranteeValue / (CustR."Current Shares"));


END;

//ELIGIBILITY
MembrEligibility := 0;
Eligibility := 0;

Cust.RESET;
Cust.SETRANGE(Cust."No.", "No.");
IF Cust.FIND('-') THEN BEGIN

LoanBalance := 0;
TotalMobileLoans := 0;
TotalNormalLoans := 0;
TotalLoansBalance := 0;
LoanApps.RESET;
LoanApps.SETRANGE(LoanApps."Member No.", Cust."No.");
LoanApps.SETFILTER(LoanApps."Outstanding Principal", '>0');
LoanApps.SETFILTER("Date Filter", '..%1', EndDate);
IF LoanApps.FIND('-') THEN BEGIN
    REPEAT


        LoanApps.CALCFIELDS(LoanApps."Outstanding Principal", "Outstanding Interest");
        IF LoanType.GET(LoanApps."Loan Product Type") THEN
            IF LoanType."Appraise Deposits" THEN
                OutInterest := 0;
        LoanBalance += LoanApps."Outstanding Principal";
        IF LoanApps."Outstanding Interest" > 0 THEN
            OutInterest := LoanApps."Outstanding Interest";

        LoanType.GET(LoanApps."Loan Product Type");
        IF LoanType."Mobile Loans" THEN
            TotalMobileLoans += LoanApps."Outstanding Principal" + OutInterest
        ELSE
            TotalNormalLoans += LoanApps."Outstanding Principal" + OutInterest;


    UNTIL LoanApps.NEXT = 0;
END;

TotalLoansBalance := TotalNormalLoans + TotalMobileLoans;

SharesMultiplier := 4;
MembrEligibility := ("Current Shares" * SharesMultiplier) - LoanBalance;

IF MembrEligibility <= 0 THEN BEGIN
    Eligibility := 0;
END;

IF MembrEligibility > 0 THEN BEGIN
    Eligibility := MembrEligibility;
END;
END;

IF "Charge Fee" THEN BEGIN
SaccoOperations.ChargeStatementFee(Members."No.", '');
END;
end;

trigger OnPreDataItem()
begin
IF (StartDate = 0D) OR (EndDate = 0D) THEN ERROR(err_date);
Members.SETFILTER("Date Filter", '..%1', EndDate);
end;
} 
}

requestpage
{

    layout
    {
        area(content)
        {
            group(Filters)
            {
                field("Start Date"; StartDate)
                {
                }
                field("End Date"; EndDate)
                {
                }
                field("Charge Fee"; "Charge Fee")
                {
                    Caption = 'Charge Fee';
                }
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
    StartDate := CALCDATE('-1Y-CM', TODAY);
    EndDate := CALCDATE('CM', TODAY);
end;

trigger OnPreReport()
begin


    IF CompanyInformation.GET THEN
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
    /*
    CompanyAddress:= CompanyInformation.Address+' -Post Code: '+CompanyInformation."Post Code"+' -City:'+CompanyInformation.City+' Region: '+ CompanyInformation."Country/Region Code";
    CompanyTelephone :='Tel: '+CompanyInformation."Phone No."+' -Office Tel: '+CompanyInformation."Phone No. 2";
    CommunicationOnline:='E-mail: '+CompanyInformation."E-Mail"+'- Website: '+CompanyInformation."Home Page";
    */

    /*CompanyAddress := CompanyInformation.Address + ' - ' + CompanyInformation."Post Code";
    CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";//+' ; '+CompanyInformation."Phone No. 2";
    CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail";
    Web := 'Member Portal: ' + CompanyInformation."Home Page";

end;

var
    StartDate: Date;
    EndDate: Date;
    CompanyInfo: Record "Company Information";
    LoanArrears: Decimal;
    LoanOpeningBalance: Decimal;
    PrincipalRepayment: Decimal;
    InterestDue: Decimal;
    InterestPaid: Decimal;
    PenaltyCharged: Decimal;
    TotalReceipts: Decimal;
    LoanClosingBalance: Decimal;
    err_date: Label 'Start date and End Date must have a value!';
    LoanDateLoanNo: Code[20];
    LoanProductType: Text;
    PeriodName: Text;
    RollOverFee: Decimal;
    SavingPeriodName: Text;
    ShareDepositOpeningBalance: Decimal;
    ShareDepositContribution: Decimal;
    ShareDepositRecoveryToBenevolent: Decimal;
    ShareDepositRecoveryToOwnLoan: Decimal;
    ShareDepositRecoveryToGuarantors: Decimal;
    ShareDepositRecoveryToShareCapital: Decimal;
    ShareDepositClosingBalance: Decimal;
    //MemLed: Record "39004416";
    OtherShareDepositRecoveries: Decimal;
    BenPeriodName: Text;
    BenOpeningBalance: Decimal;
    BenContribution: Decimal;
    BenClosingBalance: Decimal;
    ScapPeriodName: Text;
    SCapOpeningBalance: Decimal;
    SCapContribution: Decimal;
    ScapClosingBalance: Decimal;
    CompanyInformation: Record "Company Information";
    CompanyAddress: Text;
    CompanyTelephone: Text;
    CommunicationOnline: Text;
    "PeriodFilter/": Text;
    Amounts: array[5] of Decimal;
    LongTLoans: Decimal;
    TotalLoans: Decimal;
    LoanApps: Record Loans;
    DateFilter: Text[100];
    FromDate: Date;
    ToDate: Date;
    FromDateS: Text[100];
    ToDateS: Text[100];
    DivProg: Record "Dividends Progression";
    CDiv: Decimal;
    GenSetUp: Record "Sacco Setup";
    Cust: Record Members;
    SHARES: Decimal;
    Bbf: Decimal;
    MName: Text;
    InstantLoan: Decimal;
    FosaLoan: Decimal;
    LoanType: Record "Product Setup";
    StartDateFilt: Text;
    Partial: Record "Partial Disbursement Schedule";
    Months: Integer;
    Msacco: Codeunit "Sky MBanking";
    FosaBal: Decimal;
    Jiajiri: Decimal;
    Black: Text;
    Web: Text;
    Child: Text;
    Benevolent: Decimal;
    TotRcpt: Decimal;
    MCash: Decimal;
    DepLoanRatio: Decimal;
    DepGuarRatio: Decimal;
    MonthlyRep: Decimal;
    TArrears: Decimal;
    LBal: Decimal;
    GuaranteeValue: Decimal;
    LoanGuarantorsandSecurity: Record "Loan Security";
    SASRACategorization: Record "Sasra Categorization";
    //AccTypes: Record "39004271";
    AccName: Text;
    Sacco: Codeunit "Sky MBanking";
    UserName: Text;
    SecLoan: Text;
    TOutInt: Decimal;
    SecuritiesRegister: Record "Loan Collateral Register";
    SecAmt: Decimal;
    MonthlyBBF: Decimal;
    MonthlyShares: Decimal;
    ShCap: Decimal;
    Penalty1: Decimal;
    Penalty2: Decimal;
    TransType: Enum "Transaction Type Enum";
    DatePeriod: Text;
    PenaltyOnly: Decimal;
    LoanBalance: Decimal;
    LoansR: Record "Loan Repayment Schedule";
    MembrEligibility: Decimal;
    Eligibility: Decimal;
    i: Integer;
    SharesMultiplier: Decimal;
    LoanProvBal: Decimal;
    PeriodFilter: Text;
    IsMobileLoan: Boolean;
    TotalNormalLoans: Decimal;
    TotalMobileLoans: Decimal;
    TotalLoansBalance: Decimal;
    //LoanType: Record "39004240";
    LoanArrear: Decimal;
    MonthArrear: Integer;
    TotalLoanBalance: Decimal;
    TheLoanBalance: Decimal;
    "Charge Fee": Boolean;
    CLedger: Record "Credit Ledger Entry";
    SLedger: Record "Savings Ledger Entry";
    SaccoOperations: Codeunit "Sacco Activities";

local procedure GetRepaidAmount(LoanNo: Code[20]; TransType: Integer)
var

begin
    CLedger.RESET;
    CLedger.SETRANGE("Loan No.", LoanNo);
    CLedger.SETRANGE("Transaction Type", TransType);
end;

local procedure GetDebitByDescription(MemberNo: Code[20]; LoanNo: Code[20]; TransType: Integer; Description: Text; StartDate: Date; EndDate: Date) DebitAmt: Decimal
var

begin
    DebitAmt := 0;
    CLedger.RESET;
    CLedger.SETRANGE("Loan No.", LoanNo);
    CLedger.SETRANGE("Transaction Type", TransType);
    CLedger.SETRANGE("Account No.", MemberNo);
    CLedger.SETFILTER(Description, Description);
    CLedger.SETRANGE(Reversed, FALSE);
    CLedger.SETFILTER(Amount, '>0');
    CLedger.SETRANGE("Posting Date", StartDate, EndDate);
    IF CLedger.FINDFIRST THEN BEGIN
        CLedger.CALCSUMS(Amount);
        DebitAmt := CLedger.Amount;
    END;
end;

local procedure GetDebitByDocumentNo(AccNo: Code[20]; TransactionType: Integer; DocumentNo: Text; DateFilter: Text) DebitAmt: Decimal
var

begin
    DebitAmt := 0;
    SLedger.RESET;
    SLedger.SETRANGE("Account No.", AccNo);
    //SLedger.SETRANGE("Transaction Type", TransactionType);
    SLedger.SETRANGE(Reversed, FALSE);
    SLedger.SETFILTER(Amount, '>0');
    SLedger.SETFILTER("Document No.", DocumentNo);
    SLedger.SETFILTER("Posting Date", DateFilter);
    IF SLedger.FINDFIRST THEN BEGIN
        SLedger.CALCSUMS(Amount);
        DebitAmt := SLedger.Amount;
    END;
end;

local procedure GetDebitByDocumentNoOtherDeductions(AccNo: Code[20]; TransactionType: Integer; DocumentNo: Text) DebitAmt: Decimal
var

begin
    DebitAmt := 0;
    SLedger.RESET;
    SLedger.SETRANGE("Account No.", AccNo);
    //SLedger.SETRANGE("Transaction Type", TransactionType);
    SLedger.SETRANGE(Reversed, FALSE);
    SLedger.SETFILTER(Amount, '>0');
    //SLedger.SETFILTER("Document No.",'<>%1&<>%2&<>%3&<>%4',);
    IF SLedger.FINDFIRST THEN BEGIN
        SLedger.CALCSUMS(Amount);
        DebitAmt := SLedger.Amount;
    END;
end;

local procedure GetCreditByPeriod(AccNo: Code[20]; TransactionType: Integer; DateFilter: Text) CreditAmt: Decimal
var
//SLedger: Record "39004416";
begin
    CreditAmt := 0;

    SLedger.RESET;
    SLedger.SETRANGE("Account No.", AccNo);
    //SLedger.SETRANGE("Transaction Type", TransactionType);
    SLedger.SETRANGE(Reversed, FALSE);
    SLedger.SETFILTER(Amount, '<0');
    //SLedger.SETFILTER("Document No.",DocumentNo);
    SLedger.SETFILTER("Posting Date", DateFilter);
    IF SLedger.FINDFIRST THEN BEGIN
        SLedger.CALCSUMS(Amount);
        CreditAmt := SLedger.Amount * -1;
    END;
end;

procedure GetBalance(LoanNo: Code[20]; TransType: Enum "Transaction Type Enum"; DFilter: Text): Decimal
var
//CLedger: Record "39004416";
begin
    IF LoanNo = '' THEN
        EXIT(0);


    CLedger.RESET;
    CLedger.SETRANGE("Loan No.", LoanNo);
    IF TransType = TransType::"Principal Repayment" THEN
        CLedger.SETFILTER("Transaction Type", '%1|%2', CLedger."Transaction Type"::"Loan Disbursement", CLedger."Transaction Type"::"Principal Repayment");
    IF TransType = TransType::"Interest Paid" THEN
        CLedger.SETFILTER("Transaction Type", '%1|%2', CLedger."Transaction Type"::"Interest Due", CLedger."Transaction Type"::"Interest Paid");
    IF TransType = TransType::"Penalty Paid" THEN
        CLedger.SETFILTER("Transaction Type", '%1', CLedger."Transaction Type"::"Penalty Paid");
    CLedger.SETFILTER("Posting Date", DFilter);
    IF CLedger.FINDFIRST THEN BEGIN
        CLedger.CALCSUMS("Amount (LCY)");
        EXIT(CLedger."Amount (LCY)");
    END;
end;

procedure GetIrregularPenalty(LoanNo: Code[20]; DFilter: Text): Decimal
var

    LRec: Record Loans;
    Penalty: Decimal;
    i: Integer;
    FirstDate: Date;
begin
    IF LoanNo = '' THEN
        EXIT(0);

    LRec.GET(LoanNo);
    LoanType.GET(LRec."Loan Product Type");

    IF LoanType."Product ID" <> 'INST' THEN
        IF LoanType."Product ID" <> 'INST2' THEN
            IF LoanType."Product ID" <> 'MCASH' THEN
                EXIT(0);


    Penalty := 0;

    CLedger.RESET;
    CLedger.SETRANGE("Loan No.", LoanNo);
    CLedger.SETRANGE(Reversed, FALSE);
    CLedger.SETFILTER("Transaction Type", '%1', CLedger."Transaction Type"::"Loan Disbursement");
    IF CLedger.FINDFIRST THEN BEGIN
        IF CLedger.COUNT > 1 THEN BEGIN

            FirstDate := CLedger."Posting Date";

            CLedger.RESET;
            CLedger.SETRANGE("Loan No.", LoanNo);
            CLedger.SETRANGE(Reversed, FALSE);
            CLedger.SETFILTER("Transaction Type", '%1', CLedger."Transaction Type"::"Loan Disbursement");
            CLedger.SETFILTER("Posting Date", DFilter);
            IF CLedger.FINDFIRST THEN BEGIN
                REPEAT
                    IF CLedger."Posting Date" > FirstDate THEN
                        Penalty += CLedger."Amount (LCY)";
                UNTIL CLedger.NEXT = 0;
            END;
        END;
    END;

    EXIT(Penalty);
end;

*/
}

